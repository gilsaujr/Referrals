using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Referrals.ReferralsServices;

namespace Referrals.Controllers
{
    public class JobsController : Controller
    {
        public ActionResult Manage()
        {
            SecuritySvc.SecurePage();

            ServiceCallResult scr;
            JobSvc jobSvc = new JobSvc();
            IList<Job> jobs = jobSvc.GetAllJobs(out scr);

            return View(jobs);
        }

    }
}
