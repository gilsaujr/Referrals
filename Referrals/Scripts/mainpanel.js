var mainPanel = $('#divMainPanel');
var statusElements = [];
var statusUserIds = [];
$(document).ready(function () {
    
    //Page Onload
    MainPanelResize();

    //Window resizes
    win.resize(function () {
        MainPanelResize();
    });

    //Update statuses all over the current page
    //console.log('mainpanel: ' + statusElements);
    setInterval(UpdateStatuses, intUpdateStatuses);
});

function UpdateStatuses() {
    //console.log('*****************************************************');
    //console.log(statusUserIds);

    //Run ajax
    $.ajax({
        type: "POST",
        url: "/account/getstatus",
        data: { users: statusUserIds.toString() }
    })
    .fail(function (response) {
        //console.log(response.responseText);
    })
    .done(function (response) {

        //console.log('********* SUCCESS, RESPONSE *************');
        //console.log(response);

        var accountStatuses = response;
        var intCounter = 0;
        //Loop thru elements and update their status
        for (var se in statusElements) {
            intCounter++;

            var elem = $('#' + statusElements[se].ElemId);
            var userId = statusElements[se].UserId;

            //Look for current user's status
            var statusColor = 'gray';
            var statusText = 'Offline';
            for (var as in accountStatuses) {
                if (accountStatuses[as].AccountId == userId) {
                    statusColor = accountStatuses[as].StatusColor;
                    statusText = accountStatuses[as].StatusText;
                    break;
                }
            }

            //Redirect to login page, if user is timedout
            if (intCounter == 1 && statusText == 'Offline') {
                window.location = '../account/login';
            }

            //console.log('********** Element being updated *************');
            //console.log(elem);

            elem.css('color', statusColor);
            elem.text(statusText);
        }

        //console.log('******************** Success!\r\n');
        //console.log(response);
    });
}

//Resize main panel
function MainPanelResize() {
    var newHeight = win.height() - $('#header').height();

    mainPanel.css('height', newHeight);
    $('#divMainPanelInner').css('height', newHeight-45);
}