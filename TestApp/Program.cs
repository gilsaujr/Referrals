using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Referrals.ReferralsServices;

namespace TestApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Guid referralId = Guid.NewGuid();


            //************** REFERRALS *******************
            Console.WriteLine("Preparing Referral");
            
            Communication comm = new Communication();
            comm.ReferralId = referralId;
            comm.FromAcctId = 1; //chaos
            comm.ToAcctId = 26; //gargoyo
            comm.ReferredAcctId = 29; //gilbert

            ServiceCallResult scr;

            Console.WriteLine("Sending Referral, Chaos referred Gilbert to Gargoyo");
            CommSvc.SendCommunication(comm, ActionType.Referral, out scr);

            if (scr.Success)
            {
                Console.WriteLine("Success!");
            }
            else
            {
                Console.WriteLine(scr.MessageForLog);
            }

            Console.ReadLine();

            //************** MESSAGES *******************
            Console.WriteLine("Preparing Message");

            comm = new Communication();
            comm.ConversationId = Guid.NewGuid();
            comm.MessageTo = "Hey Gargoyle! Where is my mythical statues?!?!";
            comm.FromAcctId = 1; //chaos
            comm.ToAcctId = 26; //gargoyo
            
            scr = new ServiceCallResult();

            Console.WriteLine("Sending Message, Chaos sending to Gargoyo");
            CommSvc.SendCommunication(comm, ActionType.None, out scr);

            if (scr.Success)
            {
                Console.WriteLine("Success!");
            }
            else
            {
                Console.WriteLine(scr.MessageForLog);
            }

            Console.ReadLine();

            //************** INVITATIONS *******************
            Console.WriteLine("Preparing Invitation");

            comm = new Communication();
            comm.FromAcctId = 1; //chaos
            comm.ToAcctId = 26; //gargoyo

            scr = new ServiceCallResult();

            Console.WriteLine("Sending Invitation, Chaos sending to Gargoyo");
            CommSvc.SendCommunication(comm, ActionType.Invitation, out scr);

            if (scr.Success)
            {
                Console.WriteLine("Success!");
            }
            else
            {
                Console.WriteLine(scr.MessageForLog);
            }

            Console.ReadLine();

            //************** NUDGES *******************
            Console.WriteLine("Preparing Nudge");

            comm = new Communication();
            comm.FromAcctId = 1; //chaos
            comm.ToAcctId = 26; //gargoyo
            comm.ReferralId = referralId;

            scr = new ServiceCallResult();

            Console.WriteLine("Sending Nudge, Chaos sending to Gargoyo");
            CommSvc.SendCommunication(comm, ActionType.Nudge, out scr);

            if (scr.Success)
            {
                Console.WriteLine("Success!");
            }
            else
            {
                Console.WriteLine(scr.MessageForLog);
            }

            Console.ReadLine();

            //************** REWARDS *******************
            Console.WriteLine("Preparing Reward");

            comm = new Communication();
            comm.FromAcctId = 26; //gargoyo
            comm.ToAcctId = 1; //chaos
            comm.ReferralId = referralId;

            scr = new ServiceCallResult();

            Console.WriteLine("Sending Reward, Chaos sending to Gargoyo");
            CommSvc.SendCommunication(comm, ActionType.Reward, out scr);

            if (scr.Success)
            {
                Console.WriteLine("Success!");
            }
            else
            {
                Console.WriteLine(scr.MessageForLog);
            }

            Console.ReadLine();
        }
    }
}
