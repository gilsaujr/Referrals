using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Referrals.ReferralsServices;

namespace Referrals.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Dashboard()
        {
            SecuritySvc.SecurePage();

            return View();
        }
    }
}
