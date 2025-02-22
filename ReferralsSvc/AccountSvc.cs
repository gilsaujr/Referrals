using System;
using System.Web;
using System.Linq;
using System.Data.Entity.Validation;
using System.Collections.Generic;

namespace Referrals.ReferralsServices
{
    public class AccountSvc
    {
        private ReferralsEntities db;
        
        public AccountSvc()
        {
            db = new ReferralsEntities();
        }

        public IList<Account> SearchAccounts(out ServiceCallResult scr, string Firstname="", string Lastname="", string Email="", string Phone="", string City="", int StateId=0, string Zipcode="", int CountryId=0, string[] Professions=null)
        {
            scr = new ServiceCallResult();

            IList<Account> accts = null;
            try
            {
                accts = (from a in db.Accounts
                        select a).ToList();

                //Search by firstname
                if(!string.IsNullOrEmpty(Firstname))
                {
                    accts = accts.Where(a => a.Firstname.ToLower().Trim().Contains(Firstname.ToLower().Trim())).ToList();
                }
                //Search by lastname
                if (!string.IsNullOrEmpty(Lastname))
                {
                    accts = accts.Where(a => a.Lastname.ToLower().Trim().Contains(Lastname.ToLower().Trim())).ToList();
                }
                //Search by email
                if (!string.IsNullOrEmpty(Email))
                {
                    accts = accts.Where(a => a.Email.ToLower().Trim() == Email.ToLower().Trim()).ToList();
                }
                //Search by phone
                if (!string.IsNullOrEmpty(Phone))
                {
                    accts = accts.Where(a => a.Phone.ToLower().Trim().Replace("-", string.Empty) == Phone.ToLower().Trim().Replace("-", string.Empty)).ToList();
                }
                //Search by city
                if (!string.IsNullOrEmpty(City))
                {
                    accts = accts.Where(a => a.City.ToLower().Trim() == City.ToLower().Trim()).ToList();
                }
                //Search by state
                if (StateId > 0)
                {
                    accts = accts.Where(a => a.StateId == StateId).ToList();
                }
                //Search by zipcode
                if (!string.IsNullOrEmpty(Zipcode))
                {
                    accts = accts.Where(a => a.Zipcode.Trim() == Zipcode.Trim()).ToList();
                }
                //Search by country
                if (CountryId > 0)
                {
                    accts = accts.Where(a => a.CountryId == CountryId).ToList();
                }
                //Search by professions
                if (Professions != null)
                {
                    foreach (string prof in Professions)
                    {
                        accts = accts.Where(a => db.AccountProfessions
                                            .Where(ap => ap.ProfessionId == int.Parse(prof))
                                            .Select(ap => ap.AccountId)
                                            .Contains(a.Id)).ToList();
                    }
                }
                
                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting a list of accounts.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return accts;
        }

        public Account GetAccountById(int accountId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acct = null;
            try
            {
                acct = (from a in db.Accounts
                            .Include("Status")
                        where a.Id == accountId
                        select a).FirstOrDefault();

                if (acct != null)
                {
                    scr.Success = true;
                }
                else
                {
                    scr.MessageForUser = string.Format("We were unable to find an account with id: {}.", accountId);
                }
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was an error finding the account.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acct;
        }

        public Account GetAccountByPhone(string phone, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acct = null;
            try
            {
                acct = (from a in db.Accounts
                        where a.Phone.Replace("-", "") == phone.Replace("-", "")
                        select a).FirstOrDefault();

                if (acct != null)
                {
                    scr.Success = true;
                }
                else
                {
                    scr.MessageForUser = "Member not found. Fill out form and click Add.";
                }
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem with our search engine. Please try again.";
            }
            
            //Log errors
            if(!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acct;
        }

        public bool LogOutCurrentUser(int accountId, HashSet<AccountStatus> appStatuses, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            //Update status to OFFLINE
            StatusSvc.UpdateAccountStatus(accountId, StatusType.Offline, appStatuses, out scr);
            
            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return scr.Success;
        }

        public Account AuthenticateUser(string email, string password, HashSet<AccountStatus> appStatuses, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acct = null;
            try
            {
                //Find account
                acct = (from a in db.Accounts
                                .Include("Status")
                        where a.Email == email && a.Password == password
                        select a).FirstOrDefault();
                
                if (acct != null)
                {
                    //Update status to ONLINE
                    StatusSvc.UpdateAccountStatus(acct.Id, StatusType.Online, appStatuses, out scr);

                    //Add Online status object to account object
                    acct.Status = db.Status.Single(s => s.Id == (int)StatusType.Online);
                
                    scr.Success = true;
                }
                else
                {
                    scr.MessageForUser = "Username/Password combination is invalid. Please try again.";
                }
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem logging in. Please try again.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acct;
        }

        public Account GetAccountByEmail(string email, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acct = null;
            try
            {
                acct = (from a in db.Accounts
                            .Include("Status")
                        where a.Email == email
                        select a).FirstOrDefault();

                if (acct != null)
                {
                    scr.Success = true;
                }
                else
                {
                    scr.MessageForUser = "Could not find user with this email.";
                }
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "Could not find user with this email.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acct;
        }

        public Account AddAccount(Account acct, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            //Add contact to Send Hub, for sending text messages
            ServiceCallResult scrAddSendHub;
            TextMsgSvc.Add_SendHubContact(string.Format("{0} {1}", acct.Firstname, acct.Lastname), acct.Phone, out scrAddSendHub);
            
            //Add account to database
            if (scrAddSendHub.Success)
            {
                //Get Id assigned from SendHub
                acct.SendHubId = scrAddSendHub.Id.ToString();

                try
                {
                    Account acctCurrent = (Account)HttpContext.Current.Session["User"];
                    if (acctCurrent == null) acctCurrent = new Account() { Firstname="System", Lastname="System" };
                    
                    //Set password if missing
                    if(string.IsNullOrEmpty(acct.Password))
                    {
                        acct.Password = System.Web.Security.Membership.GeneratePassword(8, 2);
                    }

                    acct.StatusId = (int)StatusType.Offline;
                    acct.ProfilePic = "icon_person.jpg";
                    acct.Rating = 100;
                    acct.Created = DateTime.Now;
                    acct.CreatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);
                    acct.LastUpdated = DateTime.Now;
                    acct.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);
                    
                    acct = db.Accounts.Add(acct);
                    db.SaveChanges();

                    acct = (from a in db.Accounts
                            .Include("Communications")
                            .Include("AccountContacts.Account")
                            .Include("AccountContacts.Account1")
                            .Include("AccountProfessions.Account")
                            .Include("AccountProfessions.Profession")
                            .Include("AccountLocations.Account")
                            .Include("AccountLocations.Location")
                            .Include("Status")
                            where a.Id == acct.Id
                            select a).FirstOrDefault();
                    
                    scr.Success = true;
                }
                catch (Exception ex)
                {
                    scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                    scr.MessageForUser = "There was an error adding the account.";
                }
            }

            //Can't add to database, SendHub had an error
            else
            {
                scr.MessageForLog = "There was an error adding the contact to SendHub.";
                scr.MessageForUser = "There was an error adding the account.";
            }

            //Log errors
            if(!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acct;
        }

        public Account UpdateAccount(Account acct, bool updatePhone, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            //Update contact's number in Send Hub, for sending text messages
            ServiceCallResult scrUpdateSendHub = new ServiceCallResult();
            if (updatePhone)
            {   
                TextMsgSvc.Update_SendHubContact(int.Parse(acct.SendHubId), string.Format("{0} {1}", acct.Firstname, acct.Lastname), acct.Phone, out scrUpdateSendHub);
            }

            Account acctUpd = null;
            
            //Updating phone in SendHub failed
            if(updatePhone && !scrUpdateSendHub.Success){
                scr.MessageForLog = "There was an error updating contact in SendHub.";
                scr.MessageForUser = "There was a problem updating the account.";
            }

            //Update account in database
            else
            {
                try
                {
                    Account acctCurrent = (Account)HttpContext.Current.Session["User"];

                    acctUpd = db.Accounts.First(a => a.Id == acct.Id);
                    acctUpd.Email = acct.Email;
	                acctUpd.Password = string.IsNullOrEmpty(acct.Password) ? acctCurrent.Password : acct.Password;
	                acctUpd.Firstname = acct.Firstname;
	                acctUpd.Middlename = acct.Middlename;
	                acctUpd.Lastname = acct.Lastname;
	                acctUpd.Address1 = acct.Address1;
	                acctUpd.Address2 = acct.Address2;
	                acctUpd.City = acct.City;
                    acctUpd.StateId = acct.StateId;
                    acctUpd.Zipcode = acct.Zipcode;
                    acctUpd.CountryId = acct.CountryId;
                    acctUpd.Phone = acct.Phone;
                    acctUpd.ProfilePic = acct.ProfilePic;
                    acctUpd.ProfileUrl = acct.ProfileUrl;
                    acctUpd.SendHubId = acct.SendHubId;
                    acctUpd.Paypal = acct.Paypal;
                    acctUpd.Rating = acct.Rating;
                    acctUpd.StatusId = acct.StatusId;
                    acctUpd.IGetMessageSendMeEmail = acct.IGetMessageSendMeEmail;
                    acctUpd.IGetMessageSendMeTxtMsg = acct.IGetMessageSendMeTxtMsg;
                    acctUpd.IGetNudgeSendMeEmail = acct.IGetNudgeSendMeEmail;
                    acctUpd.IGetNudgeSendMeTxtMsg = acct.IGetNudgeSendMeTxtMsg;
                    acctUpd.IGetReferralSendMeEmail = acct.IGetReferralSendMeEmail;
                    acctUpd.IGetReferralSendMeTxtMsg = acct.IGetReferralSendMeTxtMsg;
                    acctUpd.IAmReferralSendMeTxtMsg = acct.IAmReferralSendMeTxtMsg;
                    acctUpd.IAmReferralSendMeEmail = acct.IAmReferralSendMeEmail;
                    acctUpd.IGetRewardSendMeEmail = acct.IGetRewardSendMeEmail;
                    acctUpd.IGetRewardSendMeTxtMsg = acct.IGetRewardSendMeTxtMsg;
                    acctUpd.IGetRolodexInviteSendMeEmail = acct.IGetRolodexInviteSendMeEmail;
                    acctUpd.IGetRolodexInviteSendMeTxtMsg = acct.IGetRolodexInviteSendMeTxtMsg;
                    acctUpd.IGetJobQuestionSendMeEmail = acct.IGetJobQuestionSendMeEmail;
                    acctUpd.IGetJobQuestionSendMeTxtMsg = acct.IGetJobQuestionSendMeTxtMsg;
                    acctUpd.HidePhoneNumber = acct.HidePhoneNumber;
                    acctUpd.HideEmailAddress = acct.HideEmailAddress;
                    acctUpd.LastUpdated = DateTime.Now;
                    acctUpd.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);

                    //Add professions
                    acctUpd.AccountProfessions.Clear();
                    db.SaveChanges();

                    foreach (AccountProfession ap in acct.AccountProfessions)
                    {
                        AccountProfession newAp = new AccountProfession();
                        newAp.AccountId = ap.AccountId;
                        newAp.Account = db.Accounts.Single(a => a.Id == ap.AccountId);
                        newAp.ProfessionId = ap.ProfessionId;
                        newAp.Profession = db.Professions.Single(p => p.Id == ap.ProfessionId);
                        
                        acctUpd.AccountProfessions.Add(newAp);
                    }
                    db.SaveChanges();

                    //Add locations
                    acctUpd.AccountLocations.Clear();
                    db.SaveChanges();

                    foreach (AccountLocation al in acct.AccountLocations)
                    {
                        AccountLocation newAl = new AccountLocation();
                        newAl.StateId = al.StateId;
                        newAl.Name = al.Name;
                        newAl.State = db.States.Single(st => st.Id == al.StateId);
                        newAl.CountryId = al.CountryId;
                        newAl.Country = db.Countries.Single(co => co.Id == al.CountryId);
                        newAl.Created = DateTime.Now;
                        newAl.CreatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);
                        newAl.LastUpdated = DateTime.Now;
                        newAl.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);
                        
                        acctUpd.AccountLocations.Add(newAl);
                    }
                    db.SaveChanges();

                    scr.Success = true;
                }
                catch (DbEntityValidationException vEx)
                {
                    foreach (var eve in vEx.EntityValidationErrors)
                    {
                        scr.MessageForLog += string.Format("\r\nEntity of type \"{0}\" in state \"{1}\" has the following validation errors:", eve.Entry.Entity.GetType().Name, eve.Entry.State);
                        
                        foreach (var ve in eve.ValidationErrors)
                        {
                            scr.MessageForLog += string.Format("\r\n- Property: \"{0}\", Error: \"{1}\"", ve.PropertyName, ve.ErrorMessage);
                            scr.MessageForUser += string.Format("<hr/>{0}", ve.ErrorMessage);
                        }
                    }
                }
                catch (Exception ex)
                {
                    scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                    scr.MessageForUser = "There was an problem updating the account.";
                }
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return acctUpd;
        }
    }

    public class AccountStatus
    {
        public int AccountId { get; set; }
        public Status Status { get; set; }
    }

    public static class StateSvc
    {
        private static ReferralsEntities db = new ReferralsEntities();

        public static IList<State> GetAllStates()
        {
            return db.States.ToList();
        }
    }

    public static class CountrySvc
    {
        private static ReferralsEntities db = new ReferralsEntities();

        public static IList<Country> GetAllCountries()
        {
            return db.Countries.ToList();
        }
    }

    public static class ProfessionSvc
    {
        private static ReferralsEntities db = new ReferralsEntities();

        public static IList<Profession> GetProfessions(int parent)
        {
            return db.Professions.Where(p => p.Parent == parent).ToList();
        }
    }
}