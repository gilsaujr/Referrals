using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Referrals.ReferralsServices;

namespace Referrals.Controllers
{
    public class MembersController : Controller
    {
        [HttpGet]
        public ActionResult Find()
        {
            SecuritySvc.SecurePage();

            string firstname = Request.QueryString["find-firstname"] != null ? Request.QueryString["find-firstname"] : string.Empty;
            string lastname = Request.QueryString["find-lastname"] != null ? Request.QueryString["find-lastname"] : string.Empty;
            int state = Request.QueryString["find-state"] != null ? int.Parse(Request.QueryString["find-state"]) : 0;
            int country = Request.QueryString["find-country"] != null ? int.Parse(Request.QueryString["find-country"]) : 0;
            string[] professions = Request.QueryString["find-professions"] != null ? Request.QueryString["find-professions"].Split(',') : null;

            //Search results
            IList<Account> accts = new List<Account>();

            //Search for accounts
            if (firstname != "" || lastname != "" || state > 0 || country > 0 || professions != null)
            {
                ServiceCallResult scr;
                AccountSvc acctSvc = new AccountSvc();
                accts = acctSvc.SearchAccounts(out scr, Firstname: firstname, Lastname: lastname, StateId: state, CountryId: country, Professions: professions);
            }

            //Get lists for search
            GetLists();

            return View(accts);
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
}
