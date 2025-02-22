using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Referrals.ReferralsServices
{
    public static class CommSvc
    {
        private static ReferralsEntities db = new ReferralsEntities();

        public static IEnumerable<Communication> GetReferrals(int referralType, bool read, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];

            IEnumerable<Communication> comms = null;
            try
            {
                if (referralType == 1)
                {
                    comms = (from c in db.Communications
                             .Include("Account")
                             .Include("Account1")
                             .Include("Account2")
                             .Include("Status")
                             where c.ActionId == (int)ActionType.Referral
                             && c.FromAcctId == acctCurrent.Id
                             && c.Archived == false
                             select c);
                }
                else if (referralType == 2)
                {
                    comms = (from c in db.Communications
                             .Include("Account")
                             .Include("Account1")
                             .Include("Account2")
                             .Include("Status")
                             where c.ActionId == (int)ActionType.Referral
                             && c.ToAcctId == acctCurrent.Id
                             && c.Archived == false
                             select c);
                }
                else if (referralType == 3)
                {
                    comms = (from c in db.Communications
                             .Include("Account")
                             .Include("Account1")
                             .Include("Account2")
                             .Include("Status")
                             where c.ActionId == (int)ActionType.Referral
                             && c.ReferredAcctId == acctCurrent.Id
                             && c.Archived == false
                             select c);
                }
                else if (referralType == 4)
                {
                    comms = (from c in db.Communications
                             .Include("Account")
                             .Include("Account1")
                             .Include("Account2")
                             .Include("Status")
                             where c.ActionId == (int)ActionType.Referral
                             && (c.FromAcctId == acctCurrent.Id || c.ToAcctId == acctCurrent.Id || c.ReferredAcctId == acctCurrent.Id)
                             && c.Archived == true
                             select c);
                }

                //Update status
                if (read)
                {
                    foreach (Communication comm in comms)
                    {
                        if (comm.ToAcctId == acctCurrent.Id)
                        {
                            comm.StatusToId = (int)StatusType.Read;
                        }
                        else if (comm.ReferredAcctId == acctCurrent.Id)
                        {
                            comm.StatusReferredId = (int)StatusType.Read;
                        }
                    }
                    db.SaveChanges();
                }

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting a list of referrals.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return comms;
        }

        public static Communication GetMostRecentMessageByConversationId(Guid? conversationId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];

            Communication comm = null;
            try
            {
                //Get messages for this conversation, to update their status to READ, omit message I've sent to other person
                comm = (from c in db.Communications
                        .Include("Account")
                        .Include("Account2")
                       where c.ConversationId == conversationId
                       select c).OrderByDescending(c => c.LastUpdated).Take(1).First();

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting the most recent message for the conversation.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return comm;
        }

        public static IList<Communication> GetMessagesByConversationId(Guid? conversationId, bool newMessages, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];

            IList<Communication> comms = null;
            try
            {
                //Get messages for this conversation
                if (newMessages)
                {
                    comms = (from c in db.Communications
                             .Include("Account")
                             .Include("Account2")
                             where c.ConversationId == conversationId
                             && c.ToAcctId == acctCurrent.Id
                             && c.StatusToId == (int)StatusType.New
                             select c).ToList();
                }
                else
                {
                    comms = (from c in db.Communications
                             .Include("Account")
                             .Include("Account2")
                             where c.ConversationId == conversationId
                             select c).ToList();
                }

                //Update status
                foreach (Communication comm in comms)
                {
                    comm.StatusToId = (int)StatusType.Read;
                }
                db.SaveChanges();
                
                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting a list of messages.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return comms;
        }

        public static IEnumerable<Conversation> GetMyConversations(bool newMessages, int howMany, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];

            IEnumerable<Conversation> convos = null;
            try
            {
                //Leftpanel
                if (newMessages)
                {
                    convos = (from c in db.Communications
                              .Include("Account")
                              .Include("Account2")
                              where c.ActionId == (int)ActionType.None
                              && (c.ToAcctId == acctCurrent.Id)
                              && c.StatusToId == (int)StatusType.New
                              group c by c.ConversationId into g
                              select new Conversation() { Id = g.Key, LastUpdated = g.Max(c => c.LastUpdated), Props = g })
                        .OrderByDescending(g => g.LastUpdated);
                }

                //Messages page
                else
                {
                    convos = (from c in db.Communications
                              .Include("Account")
                              .Include("Account2")
                              where c.ActionId == (int)ActionType.None
                              && (c.ToAcctId == acctCurrent.Id || c.FromAcctId == acctCurrent.Id)
                              group c by c.ConversationId into g
                              select new Conversation() { Id = g.Key, LastUpdated = g.Max(c => c.LastUpdated), Props = g })
                        .OrderByDescending(g => g.LastUpdated);
                }

                if (howMany > 0)
                {
                    convos = convos.Take(howMany);
                }

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting the conversation list.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return convos;
        }

        public static IEnumerable<Communication> GetMyNotifications(int howMany, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];

            IEnumerable<Communication> notes = null;
            try
            {
                IEnumerable<Communication> refsTo = (from c in db.Communications
                                                   .Include("Account")
                                                where c.ActionId == (int)ActionType.Referral
                                                && c.StatusToId == (int)StatusType.New
                                                && c.ToAcctId == acctCurrent.Id
                                                select c);

                IEnumerable<Communication> refsReferred = (from c in db.Communications
                                                   .Include("Account")
                                                     where c.ActionId == (int)ActionType.Referral
                                                     && c.StatusReferredId == (int)StatusType.New
                                                     && c.ReferredAcctId == acctCurrent.Id
                                                     select c);

                IEnumerable<Communication> invites = (from c in db.Communications
                                                      .Include("Account")
                                                      where c.ActionId == (int)ActionType.Invitation
                                                      && c.StatusToId == (int)StatusType.New
                                                      && (c.ToAcctId == acctCurrent.Id)
                                                      select c);

                IEnumerable<Communication> nudges = (from c in db.Communications
                                                     .Include("Account")
                                                     where c.ActionId == (int)ActionType.Nudge
                                                     && c.StatusToId == (int)StatusType.New
                                                     && (c.ToAcctId == acctCurrent.Id)
                                                     select c);

                IEnumerable<Communication> rewards = (from c in db.Communications
                                                      .Include("Account")
                                                      where c.ActionId == (int)ActionType.Reward
                                                      && c.StatusToId == (int)StatusType.New
                                                      && (c.ToAcctId == acctCurrent.Id)
                                                      select c);

                notes = refsTo.Union(refsReferred).Union(invites).Union(nudges).Union(rewards).OrderByDescending(c => c.LastUpdated).Take(howMany);
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting the notifications.";
            }

            if (howMany > 0)
            {
                notes = notes.Take(howMany);
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return notes;
        }

        public static Communication SendCommunication(Communication comm, ActionType actionType, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            AccountSvc acctSvc = new AccountSvc();
            Account acctCurrent = (Account)((comm.FromAcctId > 0) ? acctSvc.GetAccountById(comm.FromAcctId, out scr) : HttpContext.Current.Session["User"]);
            
            ServiceCallResult scrTo;
            Account acctTo = acctSvc.GetAccountById(comm.ToAcctId, out scrTo);

            ServiceCallResult scrRef;
            int iReferred = comm.ReferredAcctId != null ? (int)comm.ReferredAcctId : 0;
            Account acctRef = (iReferred > 0) ? acctSvc.GetAccountById(iReferred, out scrRef) : null;
            
            //Add communication to database
            comm.ActionId = (int)actionType;
            comm.StatusToId = (int)StatusType.New;
            comm.StatusReferredId = (int)StatusType.New;
            comm.Archived = false;
            comm.Created = DateTime.Now;
            comm.CreatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);
            comm.LastUpdated = DateTime.Now;
            comm.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);

            switch (actionType)
            {
                #region Invitation
                case ActionType.Invitation:

                    comm.MessageTo = Properties.Settings.Default.CommInvIntMsg;
                    db.Communications.Add(comm);
                    db.SaveChanges();

                    break;
                #endregion

                #region Nudge
                case ActionType.Nudge:

                    comm.MessageTo = Properties.Settings.Default.CommNudIntMsg;
                    db.Communications.Add(comm);
                    db.SaveChanges();

                    break;
                #endregion

                #region None
                case ActionType.None:
                    
                    //Add message to conversation
                    if (comm.ConversationId != null)
                    {
                        //Add new message to conversation
                        db.Communications.Add(comm);
                        db.SaveChanges();

                        scr.Success = true;
                    }
                    
                    break;
                #endregion

                #region Referral
                case ActionType.Referral:

                    if (comm.ReferralId != null)
                    {

                        //Internal Message
                        comm.MessageTo = string.Format(Properties.Settings.Default.CommRefIntMsgTo, acctTo.Firstname, acctTo.Lastname);
                        comm.MessageReferred = string.Format(Properties.Settings.Default.CommRefIntMsgRef, acctRef.Firstname, acctRef.Lastname);

                        //Email Message
                        if (acctTo.IGetReferralSendMeEmail)
                        {
                            comm.MessageToEmail = string.Format(Properties.Settings.Default.CommRefEmailTo, acctTo.Firstname, acctTo.Lastname);
                            EmailSvc.SendMail(comm.SubjectTo, comm.MessageToEmail, acctCurrent.Email, acctTo.Email, out scr);
                            comm.MessageToEmailSent = true;
                        }

                        if (acctRef.IGetReferralSendMeEmail)
                        {
                            comm.MessageReferredEmail = string.Format(Properties.Settings.Default.CommRefEmailRef, acctRef.Firstname, acctRef.Lastname);
                            EmailSvc.SendMail(comm.SubjectReferred, comm.MessageReferredEmail, acctCurrent.Email, acctRef.Email, out scr);
                            comm.MessageRefEmailSent = true;
                        }

                        //Text Message
                        if (acctTo.IGetReferralSendMeTxtMsg)
                        {
                            comm.MessageToTxtMsg = string.Format(Properties.Settings.Default.CommRefTxtMsgTo, acctTo.Firstname, acctTo.Lastname);
                            TextMsgSvc.SendTextMessage(acctTo.SendHubId, comm.MessageToTxtMsg, out scr);
                            comm.MessageToTxtMsgSent = true;
                        }

                        if (acctRef.IGetReferralSendMeTxtMsg)
                        {
                            comm.MessageReferredTxtMsg = string.Format(Properties.Settings.Default.CommRefTxtMsgRef, acctRef.Firstname, acctRef.Lastname);
                            TextMsgSvc.SendTextMessage(acctRef.SendHubId, comm.MessageReferredTxtMsg, out scr);
                            comm.MessageRefTxtMsgSent = true;
                        }

                        db.Communications.Add(comm);
                        db.SaveChanges();

                        scr.Success = true;
                    }
                    
                    break;
                #endregion

                #region Reward
                case ActionType.Reward:

                    comm.MessageTo = Properties.Settings.Default.CommRewIntMsg;
                    db.Communications.Add(comm);
                    db.SaveChanges();

                    break;
                #endregion
            }

            return comm;
        }
    }

    public class Conversation
    {
        public Guid? Id { get; set; }
        public DateTime LastUpdated { get; set; }
        public IGrouping<Guid?, Communication> Props { get; set; }
    }
}
