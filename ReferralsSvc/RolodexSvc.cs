using System;
using System.Web;
using System.Linq;
using System.Collections.Generic;


namespace Referrals.ReferralsServices
{
    public class RolodexSvc
    {
        private ReferralsEntities db;

        public RolodexSvc()
        {
            db = new ReferralsEntities();
        }

        public IList<AccountContact> GetContactsByAccount(int accountId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            List<AccountContact> accts = null;
            try
            {
                accts = (from ac in db.AccountContacts
                        where ac.Account.Id == accountId
                        select ac).ToList();

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting a list of accountContacts.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return accts;
        }

        public AccountContact AddContact(int accountId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];
            AccountContact acAdded = null;
            try
            {
                AccountContact ac = new AccountContact();
                ac.AccountId = acctCurrent.Id;
                ac.ContactId = accountId;
                ac.StatusId = (int)StatusType.Invited;
                ac.Created = DateTime.Now;
                ac.CreatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);
                ac.LastUpdated = DateTime.Now;
                ac.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);

                acAdded = db.AccountContacts.Add(ac);
                db.SaveChanges();

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem adding the accountContact.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acAdded;
        }

        public AccountContact UpdateContact(AccountContact acctContact, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];
            AccountContact acUpdated = db.AccountContacts.Where(ac => ac.Id == acctContact.Id).FirstOrDefault();
            try
            {
                acUpdated.AccountId = acctContact.AccountId;
                acUpdated.ContactId = acctContact.ContactId;
                acUpdated.StatusId = acctContact.StatusId;
                acUpdated.LastUpdated = DateTime.Now;
                acUpdated.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);

                db.SaveChanges();

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem adding the accountContact.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acUpdated;
        }

        public bool RemoveContact(int accountContactId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            try
            {
                AccountContact acDel = db.AccountContacts.Where(ac => ac.Id == accountContactId).FirstOrDefault();
                db.AccountContacts.Remove(acDel);

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem removing the accountContact.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return scr.Success;
        }
    }
}