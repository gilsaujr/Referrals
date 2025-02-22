using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Configuration;
using Referrals.ReferralsServices;

namespace Referrals.Controllers
{
    public class RolodexController : Controller
    {
        public ActionResult Manage()
        {
            SecuritySvc.SecurePage();

            return View();
        }

        public JsonResult Add(AddNewContact newContact)
        {
            Account acctCurrent = (Account)Session["User"];
            
            //Check if account exists
            AccountSvc acctSvc = new AccountSvc();
            ServiceCallResult scrGetAcct;
            Account acctToAdd = acctSvc.GetAccountByPhone(newContact.Phone, out scrGetAcct);

            //Account not found, so add it
            if (!scrGetAcct.Success)
            {
                acctToAdd.Firstname = newContact.Firstname;
                acctToAdd.Lastname = newContact.Lastname;
                acctToAdd.Phone = newContact.Phone;
                acctToAdd.Email = newContact.Email;

                ServiceCallResult scrAddAcct;
                acctToAdd = acctSvc.AddAccount(acctToAdd, out scrAddAcct);
            }

            //Add Contact to Rolodex
            ServiceCallResult scrAddContact = new ServiceCallResult();
            if (acctToAdd != null)
            {
                RolodexSvc roloSvc = new RolodexSvc();
                roloSvc.AddContact(acctToAdd.Id, out scrAddContact);
            }

            return Json(scrAddContact);
        }
    }

    public class AddNewContact
    {
        public string Phone { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Email { get; set; }
    }
}
