using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Referrals.ReferralsServices
{
    public static class SecuritySvc
    {
        public static void AddCookie(string cookieName, string cookieValue)
        {
            HttpCookie cookie = new HttpCookie(cookieName);
            cookie.Value = cookieValue;
            cookie.Expires = DateTime.Now.AddYears(1);
            HttpContext.Current.Response.Cookies.Add(cookie);
        }

        public static void RemoveCookie(string cookieName)
        {
            HttpCookie myCookie = new HttpCookie(cookieName);
            myCookie.Expires = DateTime.Now.AddDays(-1d);
            HttpContext.Current.Response.Cookies.Add(myCookie);
        }

        public static void SecurePage()
        {
            //Log out
            if (HttpContext.Current.Request.Url.ToString().IndexOf("logout=1") > -1)
            {
                RemoveCookie("email");
                HttpContext.Current.Session.Abandon();
            }

            //User is NOT logged in
            else if (HttpContext.Current.Session["User"] == null)
            {
                //NOT at login page, redirect to login page
                if (HttpContext.Current.Request.Url.ToString().IndexOf("login") == -1)
                {
                    HttpContext.Current.Response.Redirect("~/account/login");
                }
            }
        }
    }
}
