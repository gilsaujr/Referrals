using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Referrals.ReferralsServices
{
    public enum StatusType
    {
        Failed = 1,
        Invited = 2,
        New = 3,
        Offline = 4,
        Online = 5,
        Read = 6,
        Sent = 7,
        Unread = 8
    }

    public enum CommType
    {
        Email = 1,
        InternalMessage = 2,
        TextMessage = 3
    }

    public enum ActionType
    {
        Invitation = 1,
        None = 2,
        Nudge = 3,
        Referral = 4,
        Reward = 5
    }

    public enum ReceiverType
    {
        To = 1,
        Referred = 2
    }
}
