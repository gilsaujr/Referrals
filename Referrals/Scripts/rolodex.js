var rolodex = $('#rolodexBox');

$(document).ready(function () {
    
    /*************************** Rolodex Behavior *****************************/
    //Page Onload
    RolodexResize();
    RolodexPosition();

    //Window resizes
    win.resize(function () {
        RolodexResize();
        RolodexPosition();
    });

    //Open Rolodex with button click
    $('#btnRightPanel').click(function () {
        leftPanel.hide();

        if (rolodex.is(':visible')) {
            rolodex.hide();
            mainPanel.show();
        }
        else {
            mainPanel.hide();
            rolodex.slideDown('slow');
        }
    });

    //Close button is clicked
    $('.close-modal').click(function () {
        mainPanel.show();
    });

    //Add status elements to global array
    $(".status-rolodex-user").each(function(){
        statusElements.push({ ElemId: $(this).attr('id'), UserId: $(this).attr('data-id') });
        statusUserIds.push($(this).attr('data-id'));
    });

    //console.log('rolodex: ' + statusElements);

    /*************************** End of Rolodex Behavior *****************************/

    /*************************** Refer a Professional *****************************/
    //Refer button is clicked, hide Rolodex if on small device
    $("a:contains('REFER')").click(function () {
        var referredAcctName = $(this).attr('data-referredname').toUpperCase();
        var referredAcctId = $(this).attr('data-referredacctid');
        
        $('#refer-title').text(referredAcctName);
        $('#refer-referredacctid').val(referredAcctId);

        if (win.width() < iWidthLimit) rolodex.hide();
    });

    //Send Referral
    $('#btnSendReferral').click(function () {
        if (!mainPanel.is(':visible')) {
            mainPanel.show();
        }

        SendReferral();
    });

    //A contact is selected
    $('#refer-toacctid').change(function () {
        if ($(this).val() == 0) {
            $('#divNewContactFields').show();
        }
        else {
            $('#divNewContactFields').hide();
        }
    });
    /*************************** End of Refer a Professional *****************************/

    /*************************** Send Message *****************************/
    //Message button is clicked, hide Rolodex if on small device
    $("a:contains('MESSAGE')").click(function () {
        $('#message-title').text($(this).attr('data-messagetoname').toUpperCase());
        $('#message-contactid').val($(this).attr('data-messagecontactid'));
        $('#message-text').focus();
        
        if (win.width() < iWidthLimit) rolodex.hide();
    });

    //Send Message
    $('#btnSendMessage').click(function () {
        if (!mainPanel.is(':visible')) {
            mainPanel.show();
        }

        SendMessage();
    });
    /*************************** End of Send Message *****************************/


    /*************************** Add New Contact *****************************/
    //Add New Contact link clicked
    $('a[href="#addNewContactForm"]').click(function () {

        //If on small device, hide Rolodex
        if (win.width() < iWidthLimit) {
            rolodex.slideUp();
        }
    });

    $('#addnewcontact-phone').keypress(function (e) {
        var code = e.keyCode || e.which;

        if (code == 13) {
            $('#btnSearchPhone').trigger('click');
        }
    });

    //Search button in Add New Contact form is clicked
    $('#btnSearchPhone').click(function () {
        SearchMember();
    });

    //Input field in Add New Contact form has focus
    $('#addnewcontact-phone, #addnewcontact-firstname, #addnewcontact-lastname, #addnewcontact-email').focus(function () {
        $('#divAddNewContactSearchFailed').hide();
        $('#divAddNewContactError1, #divAddNewContactError2').hide();
    });

    $('#btnAddNewContact').click(function () {
        if (!mainPanel.is(':visible')) {
            mainPanel.show();
        }

        AddNewContactToRolodex();
    });

    /*************************** End of Add New Contact *****************************/

});

//Add new contact to Rolodex
function AddNewContactToRolodex() {
    var phone = $('#addnewcontact-phone');
    var firstname = $('#addnewcontact-firstname');
    var lastname = $('#addnewcontact-lastname');
    var email = $('#addnewcontact-email');
    
    //Validate fields
    if ($.trim(phone.val()) == '') {
        $('#divAddNewContactError1, #divAddNewContactError2').show();
        $('#divAddNewContactError1, #divAddNewContactError2').text('Please provide a phone number.');
        return;
    }
    else if ($.trim(firstname.val()) == '') {
        $('#divAddNewContactError1, #divAddNewContactError2').show();
        $('#divAddNewContactError1, #divAddNewContactError2').text('Please provide a first name.');
        return;
    }

    //Show Dialog Box
    $('#addNewContactForm').modal('hide');
    $('#procMsg').text('Adding new contact to Rolodex...');
    $('#modalProcessing').modal('show');

    //Show dialog for at least 3 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/rolodex/add",
            data: { Firstname: firstname, Lastname: lastname, Phone: phone, Email: email }
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('There was an error adding the contact to your Rolodex.');
            $('#modalOk').modal('show');

            console.log('fail');
            console.log("response.statusText: " + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {
                location.reload();
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('There was an error adding the contact to your Rolodex.');
                $('#modalOk').modal('show');
            }

            console.log("response.statusText: " + response.statusText);
            console.log("response.responseText: " + response.responseText);
        });

    }, 3000);
}

//Search for existing member
function SearchMember() {
    var phone = $.trim($('#addnewcontact-phone').val());
    
    //Validate field
    if (phone == '') {
        $('#divAddNewContactError1, #divAddNewContactError2').show();
        $('#divAddNewContactError1, #divAddNewContactError2').text('Please provide a phone number.');
        return;
    }

    //Show searching bar
    $('#divAddNewContactSearchFailed').hide();
    $('#divAddNewContactSearching').show();
    
    //Show bar for at least 3 seconds
    setTimeout(function () {

        console.log('sending ajax');

        //Run ajax
        $.ajax({
            type: "GET",
            url: "/account/search/",
            data: "phone=" + phone
        })
        .fail(function (response) {
            $('#divAddNewContactSearching').hide();
            
            console.log('fail');
            console.log("response.statusText: " + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {
                $('#divAddNewContactSearching').hide();
                
                $('#addnewcontact-firstname').val(response.DynObject.firstname);
                $('#addnewcontact-lastname').val(response.DynObject.lastname);
                $('#addnewcontact-email').val(response.DynObject.email);
            }
            else {
                $('#divAddNewContactSearching').hide();
                $('#divAddNewContactSearchFailed').show();
            }

            console.log('done');
            console.log('response.Success: ' + response.Success);
            console.log('response.DynObject.firstname: ' + response.DynObject.firstname);
            console.log('response.DynObject.lastname: ' + response.DynObject.lastname);
        });

    }, 3000);
}

//Send Referral
function SendReferral() {
    var firstname = $('#refer-firstname').val();
    var lastname = $('#refer-lastname').val();
    var phone = $('#refer-phone').val();
    var email = $('#refer-email').val();
    var message = $('#refer-message').val();
    var toAcctId = $('#refer-toacctid').val();
    var referredAcctId = $('#refer-referredacctid').val();

    //Show Dialog Box
    $('#referForm').modal('hide');
    $('#procMsg').text('Sending referral, please wait...');
    $('#modalProcessing').modal('show');

    //Show dialog for at least 3 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/referrals/refer",
            data: { Firstname: firstname, Lastname: lastname, Phone: phone, Email: email, Message: message, ToAcctId: toAcctId, ReferredAcctId: referredAcctId }
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('There was a problem sending the referral.');
            $('#modalOk').modal('show');

            console.log('Failed!');
            console.log(response.responseText);
        })
        .done(function (response) {

            if (response.Success) {
                //Hide Dialog Box
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('Referral was sent successfully!');
                $('#modalOk').modal('show');

                console.log('Success!');
                console.log(response);
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('There was a problem sending the referral.');
                $('#modalOk').modal('show');

                console.log('Failed!');
                console.log(response);
            }
        });

    }, 3000);
}

//Send Message
function SendMessage() {
    var message = $('#message-text').val();
    var toAcctId = $('#message-contactid').val();
    
    //Show Dialog Box
    $('#messageForm').modal('hide');
    $('#procMsg').text('Sending message...');
    $('#modalProcessing').modal('show');

    //Show dialog for at least 3 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/messages/sendmessage/",
            data: { FromAcctId: 0, ToAcctId: toAcctId, ConversationId: '', Message: message }
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('There was a problem sending the message.');
            $('#modalOk').modal('show');

            console.log('fail');
            console.log('response.statusText: ' + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {
                //Hide Dialog Box
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('Message was sent successfully!');
                $('#modalOk').modal('show');
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('There was a problem sending the message.');
                $('#modalOk').modal('show');
            }

            console.log('done');
            console.log(response);
        });

    }, 3000);
}

//Position Rolodex
function RolodexPosition() {
    var leftPos = (win.width() < iWidthLimit) ? 0 : win.width() - rolodex.width() - 5;

    rolodex.css('left', leftPos);
    win.width() > iWidthLimit ? rolodex.show() : rolodex.css('display', 'none');
}

//Resize Rolodex
function RolodexResize() {
    var newHeight = win.height() - $('#header').height();
    rolodex.css('height', newHeight);
    $('#divRightPanelInner').css('height', newHeight - 90);

    var newWidth = (win.width() < iWidthLimit) ? win.width() : $('#divRightPanel').width()+20;
    rolodex.css('width', newWidth);
}