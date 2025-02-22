using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Configuration;
using System.Web.Script.Serialization;

namespace Referrals.ReferralsServices
{
    public static class TextMsgSvc
    {
        private static string SendHubEndPointParams = string.Format(Properties.Settings.Default.SendHubEndPointParams, Properties.Settings.Default.SendHubUsername, Properties.Settings.Default.SendHubAPIKey);

        public static bool SendTextMessage(string sendHubContactId, string txtMsg, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            //REST Client used to make web request to SendHub
            RestClient rc = new RestClient();
            rc.EndPoint = Properties.Settings.Default.SendHubEndPointMessages;
            rc.Method = HttpVerb.POST;
            rc.ContentType = "application/json";
            rc.PostData = "{ \"contacts\": [  " + sendHubContactId + " ], \"text\": \"" + txtMsg + "\"}";

            //Make web request to REST API at SendHub, to send text message
            string[] webResponse = new string[]{};
            try
            {
                webResponse = rc.MakeRequest(SendHubEndPointParams).Split(',');

                //There was a response
                if (webResponse.Count() > 0)
                {
                    //Response was NOT OK
                    if(!webResponse[0].EndsWith(HttpStatusCode.OK.ToString())){
                        scr.MessageForLog = string.Format("Status: {0}, Response: {1}", webResponse[0], webResponse[1]);
                        scr.MessageForUser = "There was a problem sending the text message.";
                    }

                    //Response was OK
                    else{
                        scr.Success = true;
                    }
                }

                //No response was returned, so there must be an error
                else{
                    scr.MessageForLog = "There was NO RESPONSE from the RESTClient WebRequest made to SendHub.";
                    scr.MessageForUser = "There was a problem sending the text message.";
                }
                
            }
            catch(Exception ex) {
                scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem sending the text message.";
            }

            //Log error
            if(!string.IsNullOrEmpty(scr.MessageForLog)) LogSvc.LogError(scr.MessageForLog);

            return scr.Success;
        }

        public static bool Add_SendHubContact(string name, string number, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            //REST Client used to make web request to SendHub
            RestClient rc = new RestClient();
            rc.EndPoint = Properties.Settings.Default.SendHubEndPointContacts;
            rc.Method = HttpVerb.POST;
            rc.ContentType = "application/json";
            rc.PostData = "{ \"name\": \"" + name + "\", \"number\": \"" + number + "\"}";

            //Make web request to SendHub, using REST Client
            string[] webResponse = new string[] { };
            try
            {
               

                webResponse = rc.MakeRequest(SendHubEndPointParams).Split(',');

                //There was a response
                if (webResponse.Count() > 0)
                {

                

                    //Response was NOT OK
                    if (!webResponse[0].ToLower().Contains("status: created"))
                    {
                        scr.MessageForLog = string.Format("Status: {0}, Response: {1}", webResponse[0], webResponse[1]);
                        scr.MessageForUser = "There was a problem adding the user to our text message service.";
                    }

                    //Response was OK
                    else
                    {
                        scr.Success = true;

                        //Get Send Hub Id returned (" \"id\": 10960030")
                        scr.Id = int.Parse(webResponse[6].Replace("\\", "").Replace("\"", "").Replace(":", "").Replace("id", "").Trim());
                    }
                }

                //No response was returned, so there must be an error
                else
                {
                    scr.MessageForLog = "There was NO RESPONSE from the RESTClient WebRequest made to SendHub.";
                    scr.MessageForUser = "There was a problem adding the user to our text message service.";
                }

            }
            catch (Exception ex)
            {
                scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem adding the user to our text message service.";
            }

            //Log error
            if (!string.IsNullOrEmpty(scr.MessageForLog)) LogSvc.LogError(scr.MessageForLog);

            return scr.Success;
        }

        public static bool Update_SendHubContact(int id, string name, string number, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();
            
            //REST Client used to make web request to SendHub
            RestClient rc = new RestClient();
            rc.EndPoint = string.Format("{0}{1}/", Properties.Settings.Default.SendHubEndPointContacts, id);
            rc.Method = HttpVerb.PUT;
            rc.ContentType = "application/json";
            rc.PostData = "{ \"id\": \"" + id + "\", \"name\": \"" + name + "\", \"number\": \"" + number + "\"}";

            //Make web request to SendHub, using REST Client
            string[] webResponse = new string[] { };
            try
            {
                webResponse = rc.MakeRequest(SendHubEndPointParams).Split(',');

                //There was a response
                if (webResponse.Count() > 0)
                {
                    //Response was NOT OK
                    if (!webResponse[0].EndsWith(HttpStatusCode.OK.ToString()))
                    {
                        scr.MessageForLog = string.Format("Status: {0}, Response: {1}", webResponse[0], webResponse[1]);
                        scr.MessageForUser = "There was a problem updating the user in our text message service.";
                    }

                    //Response was OK
                    else
                    {
                        scr.Success = true;

                        //Get Send Hub Id returned
                        int startPos = webResponse[1].IndexOf("id\":") + 4;
                        int endPos = webResponse[1].IndexOf(",", startPos);
                        int substringLen = endPos - startPos;

                        scr.Id = int.Parse(webResponse[1].Substring(startPos, substringLen));
                    }
                }

                //No response was returned, so there must be an error
                else
                {
                    scr.MessageForLog = "There was NO RESPONSE from the RESTClient WebRequest made to SendHub.";
                    scr.MessageForUser = "There was a problem updating the user in our text message service.";
                }

            }
            catch (Exception ex)
            {
                scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem updating the user in our text message service.";
            }

            //Log error
            if (!string.IsNullOrEmpty(scr.MessageForLog)) LogSvc.LogError(scr.MessageForLog);

            return scr.Success;
        }

        public static bool Delete_SendHubContact(int id, out ServiceCallResult scr)
        {
            scr = new ServiceCallResult();

            //REST Client used to make web request to SendHub
            RestClient rc = new RestClient();
            rc.EndPoint = string.Format("{0}{1}/", Properties.Settings.Default.SendHubEndPointContacts, id);
            rc.Method = HttpVerb.DELETE;
            rc.ContentType = "application/json";

            //Make web request to SendHub, using REST Client
            string[] webResponse = new string[] { };
            try
            {
                webResponse = rc.MakeRequest(SendHubEndPointParams).Split(',');

                //There was a response
                if (webResponse.Count() > 0)
                {
                    //Response was NOT OK
                    if (!webResponse[0].EndsWith(HttpStatusCode.OK.ToString()))
                    {
                        scr.MessageForLog = string.Format("Status: {0}, Response: {1}", webResponse[0], webResponse[1]);
                        scr.MessageForUser = "There was a problem deleting the user in our text message service.";
                    }

                    //Response was OK
                    else
                    {
                        scr.Success = true;

                        //Get Send Hub Id returned
                        int startPos = webResponse[1].IndexOf("id\":") + 4;
                        int endPos = webResponse[1].IndexOf(",", startPos);
                        int substringLen = endPos - startPos;

                        scr.Id = int.Parse(webResponse[1].Substring(startPos, substringLen));
                    }
                }

                //No response was returned, so there must be an error
                else
                {
                    scr.MessageForLog = "There was NO RESPONSE from the RESTClient WebRequest made to SendHub.";
                    scr.MessageForUser = "There was a problem deleting the user in our text message service.";
                }

            }
            catch (Exception ex)
            {
                scr.MessageForLog = string.Format("MESSAGE:{0} --- INNER-EXCEPTION:{1} --- SOURCE:{2} --- STACK-TRACE:{3}", ex.Message, ex.InnerException, ex.Source, ex.StackTrace);
                scr.MessageForUser = "There was a problem deleting the user in our text message service.";
            }

            //Log error
            if (!string.IsNullOrEmpty(scr.MessageForLog)) LogSvc.LogError(scr.MessageForLog);

            return scr.Success;
        }
    }
}