using System;
using System.Web;
using System.Linq;
using System.Collections.Generic;

namespace Referrals.ReferralsServices
{
    public class JobSvc
    {
        private ReferralsEntities db;
        
        public JobSvc()
        {
            db = new ReferralsEntities();
        }

        public IList<Job> GetAllJobs(out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            IList<Job> jobs = null;
            try
            {
                jobs = (from j in db.Jobs
                       select j).ToList();

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting a list of jobs.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return jobs;
        }

        public IList<Job> GetJobsPostedByAccount(int accountId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            IList<Job> jobs = null;
            try
            {
                jobs = db.Jobs.Where(j => j.PostedByAcctId == accountId).ToList();

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting a list of jobs.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return jobs;
        }

        public Job GetJobById(int jobId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Job job = null;
            try
            {
                job = db.Jobs.Where(j => j.Id == jobId).FirstOrDefault();

                if(job != null){
                    scr.Success = true;
                }
                else
                {
                    scr.MessageForUser = string.Format("We were unable to find job with id: {}.", jobId);
                }
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem getting the job.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return job;
        }

        public Job AddJob(Job job, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Job jobAdded = null;
            try
            {
                Account acctCurrent = (Account)HttpContext.Current.Session["User"];

                job.StatusId = (int)StatusType.New;
                job.Created = DateTime.Now;
                job.CreatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);
                job.LastUpdated = DateTime.Now;
                job.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);

                jobAdded = job = db.Jobs.Add(job);
                db.SaveChanges();
                
                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem adding the job.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return jobAdded;
        }

        public Job UpdateJob(Job job, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            Account acctCurrent = (Account)HttpContext.Current.Session["User"];

            Job jobUpdated = null;
            try
            {
                jobUpdated = db.Jobs.Where(j => j.Id == job.Id).FirstOrDefault();

                jobUpdated.Name = job.Name;
                jobUpdated.Description = job.Description;
                jobUpdated.PostedByAcctId = job.PostedByAcctId;
                jobUpdated.StatusId = job.StatusId;
                jobUpdated.LastUpdated = DateTime.Now;
                jobUpdated.LastUpdatedBy = string.Format("{0} {1}", acctCurrent.Firstname, acctCurrent.Lastname);

                db.SaveChanges();

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem updating the job.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return jobUpdated;
        }

        public bool RemoveJob(int jobId, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            try
            {
                Job job = db.Jobs.Where(j => j.Id == jobId).FirstOrDefault();
                db.Jobs.Remove(job);

                scr.Success = true;
            }
            catch (Exception ex)
            {
                scr.MessageForLog = scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem removing the job.";
            }

            //Log errors
            if (!scr.Success) LogSvc.LogError(scr.MessageForLog);

            return scr.Success;
        }
    }
}