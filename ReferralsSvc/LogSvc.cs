using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;

namespace Referrals.ReferralsServices
{
    public static class LogSvc
    {
        public static void LogError(string msg)
        {
            if (HttpContext.Current != null)
            {

                string dir = string.Format("{0}Logs", HttpContext.Current.Request.ServerVariables["APPL_PHYSICAL_PATH"].Replace("\\", "\\\\"));
                string dateStamp = string.Format("{0:yyyy.MM.dd}", DateTime.Now);
                string timeStamp = string.Format("{0:yyyy.MM.dd HH:mm:ss}", DateTime.Now);
                string fullPath = string.Format("{0}\\{1}.txt", dir, dateStamp);

                StreamWriter sw;

                //Create today's log file
                if (!File.Exists(fullPath))
                {
                    sw = File.CreateText(fullPath);
                }

                //Open today's log file
                else
                {
                    sw = File.AppendText(fullPath);
                }

                //Current user
                string name = "Not Available";
                string email = "Not Available";
                string phone = "Not Available";
                try
                {
                    Account user = (Account)HttpContext.Current.Session["User"];
                    name = string.Format("{0} {1}", user.Firstname, user.Lastname);
                    email = user.Email;
                    phone = user.Phone;
                }
                catch { }

                //Write error and time to log file
                sw.WriteLine();
                sw.WriteLine("*************************************************************************************************");
                sw.WriteLine(string.Format("{0} ||| {1} ||| {2} ||| {3} ||| {4}", timeStamp, name, email, phone, msg));

                sw.Close();
                sw.Dispose();
            }
        }
    }
}
