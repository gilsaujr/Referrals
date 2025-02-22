var leftPanel = $('#leftPanel');
var msgsDropdown = $('#ulMsgs');
var notesDropdown = $('#ulNotes');
var acctSettingsDropdown = $('#ulAcctSettings');

$(document).ready(function () {
    
    //Page Onload
    LeftPanelResize();
    LeftPanelPosition();
    MessagesResize();
    NotificationsResize();
    NotificationsPosition();
    
    //Window resizes
    win.resize(function () {
        LeftPanelResize();
        LeftPanelPosition();
        MessagesResize();
        NotificationsResize();
        NotificationsPosition();
    });

    //Open left panel with button click
    $('#btnLeftPanel').click(function () {
        rolodex.hide();

        if (leftPanel.is(':visible')) {
            leftPanel.hide();
            mainPanel.show();
        }
        else {
            mainPanel.hide();
            leftPanel.slideDown();
        }
    });

    //Create timer for new conversation messages
    CheckForNewMsgsForLeftPanel();
    setInterval(CheckForNewMsgsForLeftPanel, intCheckForNewMsgsForLeftPanel);
    
    //Create timer for new notifications
    CheckForNewNotesForLeftPanel();
    setInterval(CheckForNewNotesForLeftPanel, intCheckForNewNotesForLeftPanel);

    //Add status elements
    statusElements.push({ ElemId: $('#status-current-user').attr('id'), UserId: $('#status-current-user').attr('data-id') });
    statusUserIds.push($('#status-current-user').attr('data-id'));

    //console.log('leftpanel: ' + statusElements);

});

//Create timer for new messages
function CheckForNewMsgsForLeftPanel() {
    var msgsList = $('#ulMsgs');
    var msgCount = $('#msgCount');
    var msgCounter = 0;

    if (!msgsList.is(':visible')) {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/messages/get",
            data: { leftPanel: true, conversationId: 0, msgType: 1, newMessages: true  }
        })
        .fail(function (response) {

            console.log(response.responseText);

        })
        .done(function (response) {
            msgsList.empty();
            msgsList.html(response);
            msgCount.show();

            //Subtract dividers in html
            msgCounter = ($('li', '<div>' + response + '</div>').length - 1) / 2;
            msgCounter = msgCounter > 1 ? msgCounter - 1 : msgCounter;
            msgCount.text(msgCounter);

            //console.log(response);
        });
    }
}

//Create timer for new notifications
function CheckForNewNotesForLeftPanel() {
    var notesList = $('#ulNotes');
    var noteCount = $('#noteCount');
    var noteCounter = 0;

    if (!notesList.is(':visible')) {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/messages/get",
            data: { leftPanel: true, conversationId: 0, msgType: 2, newMessages: true }
        })
        .fail(function (response) {

            //console.log(response.responseText);

        })
        .done(function (response) {
            notesList.empty();
            notesList.html(response);
            noteCount.show();

            //Subtract dividers in html
            noteCounter = ($('li', '<div>' + response + '</div>').length - 1) / 2;
            noteCounter = noteCounter > 1 ? noteCounter - 1 : noteCounter;
            noteCount.text(noteCounter);

            //console.log(response);
        });
    }
}

//Position left panel
function LeftPanelPosition() {
    var leftPos = (win.width() < iWidthLimit) ? 0 : 5;

    leftPanel.css('left', leftPos);
    win.width() > iWidthLimit ? leftPanel.show() : leftPanel.css('display', 'none');
}

//Resize left panel
function LeftPanelResize() {
    var newHeight = win.height() - $('#header').height();
    leftPanel.css('height', newHeight);
    $('#divLeftPanelInner').css('height', newHeight-40);

    var newWidth = (win.width() < iWidthLimit) ? win.width() : $('#divLeftPanel').width() + 20;
    leftPanel.css('width', newWidth);
}

//Messages dropdown resize
function MessagesResize() {
    msgsDropdown.css('width', leftPanel.width() - 20);
}

//Notifications dropdown position
function NotificationsPosition() {
    notesDropdown.css('left', 0 - (leftPanel.width() / 3) + 5 + 'px');
    acctSettingsDropdown.css('left', 0 - (leftPanel.width() / 3)-5 + 'px');
}

//Notifications dropdown resize
function NotificationsResize() {
    notesDropdown.css('width', leftPanel.width() - 20);
    acctSettingsDropdown.css('width', ((leftPanel.width()/3)*2) - 20);
}