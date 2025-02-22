using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using Referrals.ReferralsServices;

namespace Referrals.Controllers
{
    public class MessagesController : Controller
    {
        [HttpPost]
        public JsonResult Update(int referralType)
        {
            ServiceCallResult scr;
            CommSvc.GetReferrals(referralType, true, out scr);

            return Json(scr);
        }
        
        [HttpPost]
        public ActionResult Get(bool leftPanel, Guid? conversationId, int msgType, bool newMessages)
        {
            //Leftpanel Messages & Notifications
            if (leftPanel)
            {
                //Regular Messages
                if (msgType == 1)
                {
                    ServiceCallResult scrConvos;
                    IEnumerable<Conversation> convos = CommSvc.GetMyConversations(newMessages, 5, out scrConvos);
                    return PartialView("~/Views/Messages/LeftPanelMsgDropDown.cshtml", convos);
                }

                //Notes
                else if (msgType == 2)
                {
                    ServiceCallResult scrNotes;
                    IEnumerable<Communication> notes = CommSvc.GetMyNotifications(5, out scrNotes);
                    return PartialView("~/Views/Messages/LeftPanelNotesDropDown.cshtml", notes);
                }
            }

            //Messages page, Conversation Panel
            ViewBag.CurrentConvoId = conversationId;
            ServiceCallResult scrMsgs;
            IList<Communication> msgs = CommSvc.GetMessagesByConversationId(conversationId, newMessages, out scrMsgs).OrderBy(m => m.LastUpdated).ToList();
            return PartialView("~/Views/Messages/ConversationPanel.cshtml", msgs);
        }
        
        [HttpGet]
        public ActionResult Manage()
        {
            SecuritySvc.SecurePage();

            Account acctCurrent = (Account)Session["User"];

            //Get conversations
            IList<Communication> convos = new List<Communication>();

            return View(convos);
        }

        [HttpGet]
        public ActionResult Notifications()
        {
            SecuritySvc.SecurePage();

            Account acctCurrent = (Account)Session["User"];

            //Get conversations
            IList<Communication> convos = new List<Communication>();

            return View(convos);
        }

        [HttpPost]
        public JsonResult SendMessage(MessageInfo info)
        {
            Account acctCurrent = (Account)Session["User"];

            ServiceCallResult scrAddMessage = new ServiceCallResult();

            //Create new conversation
            Communication comm = new Communication();
            comm.FromAcctId = acctCurrent.Id;
            comm.ToAcctId = info.ToAcctId;
            comm.ConversationId = (info.ConversationId != Guid.Empty) ? info.ConversationId : Guid.NewGuid();
            comm.MessageTo = info.Message;
            
            //Add message to database
            ServiceCallResult scr;
            CommSvc.SendCommunication(comm, ActionType.None, out scr);
            
            return Json(scr);
        }

        public class MessageInfo
        {
            public int FromAcctId { get; set; }
            public int ToAcctId { get; set; }
            public Guid ConversationId { get; set; }
            public string Message { get; set; }
        }
    }
}
