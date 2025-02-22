using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Configuration;
using Referrals.ReferralsServices;

namespace Referrals.Controllers
{
    public class ReferralsController : Controller
    {
        public JsonResult Refer(ReferToAcctInfo info)
        {
            ServiceCallResult scr = new ServiceCallResult();
            
            AccountSvc acctSvc = new AccountSvc();

            //Current user
            Account acctCurrent = (Account)Session["User"];
            Account acctRef = (Account)acctSvc.GetAccountById(info.ReferredAcctId, out scr);
            Account acctTo = null;

            if (info.ToAcctId > 0)
            {
                acctTo = (Account)acctSvc.GetAccountById(info.ToAcctId, out scr);
            }

            //ToAcct is a NEW CONTACT, so look for Account or, Create It!
            else if (info.ToAcctId == 0)
            {
                string phone = info.Phone.Replace("-", "").Replace(")", "").Replace("(", "").Replace(" ", "").Trim();

                //Check Members
                acctTo = acctSvc.GetAccountByPhone(info.Phone, out scr);

                //AcctTo not found, then create Account
                if (!scr.Success && acctTo == null)
                {
                    acctTo = new Account();
                    acctTo.Firstname = info.Firstname;
                    acctTo.Lastname = info.Lastname;
                    acctTo.Phone = info.Phone;
                    acctTo.Email = info.Email;

                    //Add account as new member and send invite to sign up
                    acctTo = acctSvc.AddAccount(acctTo, out scr);
                }
            }
            
            //Create referral
            Communication comm = new Communication();
            comm.FromAcctId = acctCurrent.Id;
            comm.ToAcctId = acctTo.Id;
            comm.ReferredAcctId = acctRef.Id;
            comm.ReferralId = Guid.NewGuid();
            
            //Send Referral
            CommSvc.SendCommunication(comm, ActionType.Referral, out scr);
            
            return Json(scr);
        }

        public ActionResult Manage()
        {
            SecuritySvc.SecurePage();

            Account acctCurrent = (Account)Session["User"];

            //Get list of referrals
            IList<Communication> comms = new List<Communication>();

            return View(comms);
        }
    }

    public class ReferToAcctInfo
    {
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Message { get; set; }
        public int ToAcctId { get; set; }
        public int ReferredAcctId { get; set; }
    }

}
