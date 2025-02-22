using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Text;
using Referrals.ReferralsServices;
using System.IO;

namespace Referrals.Controllers
{
    public class AccountController : Controller
    {
        [HttpPost]
        public JsonResult GetStatus(string users)
        {
            //Return list
            List<Object> returnStatuses = new List<Object>();

            string[] userIds = users.Split(',');

            //Loop thru list sent in, and get status for each user
            ServiceCallResult scr;
            for(int u = 0; u < userIds.Count(); u++)
            {
                //User id to search for
                int userId = int.Parse(userIds[u]);

                //Get user status
                Status statusFound = StatusSvc.GetAccountStatus(userId, out scr);

                //User found, add their status to return list
                if (statusFound != null)
                {
                    returnStatuses.Add(new { AccountId=userId, StatusColor=statusFound.Color, StatusText=statusFound.Name });
                }
            }

            return Json(returnStatuses);
        }

        [HttpPost]
        public ActionResult Update()
        {
            SecuritySvc.SecurePage();

            Account acctCurrent = (Account)Session["User"];
            bool updatePhone = false;
            string returnView = "ProfileView";

            //Update account, from page ProfileView
            if (Request.Form["updateProfile"] != null)
            {
                acctCurrent.Firstname = Request.Form["profile-firstname"];
                acctCurrent.Middlename = Request.Form["profile-middlename"];
                acctCurrent.Lastname = Request.Form["profile-lastname"];
                acctCurrent.Address1 = Request.Form["profile-address1"];
                acctCurrent.Address2 = Request.Form["profile-address2"];
                acctCurrent.City = Request.Form["profile-city"];
                acctCurrent.Zipcode = Request.Form["profile-zipcode"];
                acctCurrent.StateId = Request.Form["profile-state"] != null ? int.Parse(Request.Form["profile-state"]) : 0;
                acctCurrent.CountryId = Request.Form["profile-country"] != null ? int.Parse(Request.Form["profile-country"]) : 0;
                acctCurrent.Email = Request.Form["profile-email"];
                acctCurrent.Password = Request.Form["profile-password"];
                acctCurrent.Paypal = Request.Form["profile-paypal"];

                //Profile Pic
                foreach (string file in Request.Files)
                {
                    var postedFile = Request.Files[file];

                    if (postedFile.ContentLength > 0)
                    {
                        postedFile.SaveAs(Server.MapPath("~/profilepics/") + Path.GetFileName(acctCurrent.ProfilePic));
                    }
                }

                //Remove all professions from account
                acctCurrent.AccountProfessions.Clear();

                //Add professions to account
                if (Request.Form["profile-professions-acct"] != null)
                {
                    string[] profs = Request.Form["profile-professions-acct"].Split(',');
                    if (profs.Count() > 0)
                    {
                        foreach (string profId in profs)
                        {
                            acctCurrent.AccountProfessions.Add(new AccountProfession() { AccountId = acctCurrent.Id, ProfessionId = int.Parse(profId) });
                        }
                    }
                }

                //Remove all locations from account
                acctCurrent.AccountLocations.Clear();

                //Add locations to account
                if (Request.Form["profile-locations-acct"] != null)
                {
                    string[] locs = Request.Form["profile-locations-acct"].Split(',');
                    if (locs.Count() > 0)
                    {
                        foreach (string loc in locs)
                        {
                            var locArr = loc.Split('|');
                            acctCurrent.AccountLocations.Add(new AccountLocation() { AccountId = acctCurrent.Id, Name = locArr[0], StateId = int.Parse(locArr[1]), CountryId = int.Parse(locArr[2]) });
                        }
                    }
                }

                //Update phone
                if (Request.Form["profile-phone"] != acctCurrent.Phone)
                {
                    acctCurrent.Phone = Request.Form["profile-phone"];
                    updatePhone = true;
                }

                //Get lists for dropdowns
                GetLists();
            }

            //Update account settings, from Settings page
            else if (Request.Form["updateSettings"] != null)
            {
                acctCurrent.IGetReferralSendMeTxtMsg = Request.Form["settings-iGetReferralSendMeTxtMsg"] != null ? true : false;
                acctCurrent.IGetReferralSendMeEmail = Request.Form["settings-iGetReferralSendMeEmail"] != null ? true : false;
                acctCurrent.IAmReferralSendMeTxtMsg = Request.Form["settings-iAmReferralSendMeTxtMsg"] != null ? true : false;
                acctCurrent.IAmReferralSendMeEmail = Request.Form["settings-iAmReferralSendMeEmail"] != null ? true : false;
                acctCurrent.IGetRolodexInviteSendMeTxtMsg = Request.Form["settings-iGetRolodexInviteSendMeTxtMsg"] != null ? true : false;
                acctCurrent.IGetRolodexInviteSendMeEmail = Request.Form["settings-iGetRolodexInviteSendMeEmail"] != null ? true : false;
                acctCurrent.IGetRewardSendMeTxtMsg = Request.Form["settings-iGetRewardSendMeTxtMsg"] != null ? true : false;
                acctCurrent.IGetRewardSendMeEmail = Request.Form["settings-iGetRewardSendMeEmail"] != null ? true : false;
                acctCurrent.IGetNudgeSendMeTxtMsg = Request.Form["settings-iGetNudgeSendMeTxtMsg"] != null ? true : false;
                acctCurrent.IGetNudgeSendMeEmail = Request.Form["settings-iGetNudgeSendMeEmail"] != null ? true : false;
                acctCurrent.IGetMessageSendMeTxtMsg = Request.Form["settings-iGetMessageSendMeTxtMsg"] != null ? true : false;
                acctCurrent.IGetMessageSendMeEmail = Request.Form["settings-iGetMessageSendMeEmail"] != null ? true : false;
                acctCurrent.IGetJobQuestionSendMeTxtMsg = Request.Form["settings-iGetJobQuestionSendMeTxtMsg"] != null ? true : false;
                acctCurrent.IGetJobQuestionSendMeEmail = Request.Form["settings-iGetJobQuestionSendMeEmail"] != null ? true : false;
                acctCurrent.HidePhoneNumber = Request.Form["settings-hidePhoneNumber"] != null ? true : false;
                acctCurrent.HideEmailAddress = Request.Form["settings-hideEmailAddress"] != null ? true : false;

                returnView = "Manage";
            }

            //Update account
            ServiceCallResult scr;
            AccountSvc acctSvc = new AccountSvc();
            Session["User"] = acctSvc.UpdateAccount(acctCurrent, updatePhone, out scr);

            return View(returnView, scr);
        }
        
        [HttpGet]
        public ActionResult Manage()
        {
            SecuritySvc.SecurePage();

            return View();
        }

        [HttpGet]
        public ActionResult ProfileView()
        {
            SecuritySvc.SecurePage();

            ServiceCallResult scr = new ServiceCallResult();

            //Get user account to view
            if (Request.QueryString["id"] != null)
            {
                AccountSvc acctSvc = new AccountSvc();
                Account userAcct = acctSvc.GetAccountById(int.Parse(Request.QueryString["id"]), out scr);
                
                if(scr.Success){
                    scr.DynObject = userAcct;
                }
            }

            //Lists for dropdowns
            if (Request.QueryString["edit"] != null)
            {
                GetLists();
            }

            return View(scr);
        }

        [HttpGet]
        public string GetCategories(int parent)
        {
            //List of professions
            IList<Profession> profs = ProfessionSvc.GetProfessions(parent);

            StringBuilder sb = new StringBuilder("<option value=\"0\">Select Sub-category</option>");
            foreach (Profession prof in profs)
            {
                sb.Append(string.Format("<option value=\"{0}\">{1}</option>", prof.Id, prof.Name));
            }

            return sb.ToString();
        }

        [HttpGet]
        public JsonResult Search(string phone)
        {
            AccountSvc svc = new AccountSvc();
            ServiceCallResult scr;
            Account acct = svc.GetAccountByPhone(phone, out scr);

            if (scr.Success && acct != null)
            {
                scr.DynObject = new { firstname=acct.Firstname, lastname=acct.Lastname, email=acct.Email, phone=acct.Phone };
            }

            return Json(scr, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult Login(int logout=0)
        {
            SecuritySvc.SecurePage();

            return View();
        }

        [HttpPost]
        public JsonResult SignUp(SignupAcct suAcct)
        {
            //Prepare account to add
            Account acct = new Account();
            acct.Firstname = suAcct.Firstname;
            acct.Lastname = suAcct.Lastname;
            acct.Phone = suAcct.Phone;
            acct.Email = suAcct.Email;
            acct.Password = suAcct.Password;
            
            //Add account
            AccountSvc acctSvc = new AccountSvc();
            ServiceCallResult scr;
            Account acctAdded = acctSvc.AddAccount(acct, out scr);

            //Add was successful and returned a copy of the account
            if (scr.Success && acctAdded != null)
            {
                Session["User"] = acctAdded;
                SecuritySvc.AddCookie("email", acct.Email);
            }
            
            return Json(scr);
        }

        [HttpPost]
        public JsonResult SignIn(string email, string password)
        {
            //Get account
            AccountSvc svc = new AccountSvc();
            ServiceCallResult scr;
            Account acct = svc.AuthenticateUser(email, password, ((HashSet<AccountStatus>)HttpContext.Application["AccountStatus"]), out scr);

            //Getting account was successful and returned a copy of the account
            if (scr.Success && acct != null)
            {
                Session["User"] = acct;
                SecuritySvc.AddCookie("email", email);
            }

            return Json(scr);
        }

        [HttpGet]
        public ActionResult Rewards()
        {
            SecuritySvc.SecurePage();

            return View();
        }

        private void GetLists()
        {
            //List of states
            ViewBag.States = StateSvc.GetAllStates();

            //List of countries
            ViewBag.Countries = CountrySvc.GetAllCountries();

            //List of professions
            ViewBag.Professions = ProfessionSvc.GetProfessions(0);
        }
    }

    public class SignupAcct
    {
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int SendHubId { get; set; }
    }

    public class StatusElement
    {
        public string ElemId { get; set; }
        public int UserId { get; set; }
    }
}
