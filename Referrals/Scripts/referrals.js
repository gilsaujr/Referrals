$(document).ready(function () {

    //Ratings
    $('.referralsrating').click(function () {
        
        //Send person's name & id to modal
        var id = $(this).attr('data-id');
        var name = $(this).attr('data-name').toUpperCase();

        $('#referrals-rating-accountId').val(id);
        $('#referrals-rating-name').text(name);
    });

    //Send Message
    $('.referralsmessage').click(function () {

        //Send person's name & id to modal
        var id = $(this).attr('data-id');
        var name = $(this).attr('data-name').toUpperCase();

        $('#referrals-message-accountId').val(id);
        $('#referrals-message-name').text(name);
    });

    //Send Nudge for Reward
    $('.referralssendnudge').click(function () {

        //Send person's name & id to modal
        var id = $(this).attr('data-id');
        var name = $(this).attr('data-name').toUpperCase();

        sendNudgeForReward(id, name);
    });

    //Send Reward
    $('.referralssendreward').click(function () {

        //Send person's name & id to modal
        var id = $(this).attr('data-id');
        var name = $(this).attr('data-name').toUpperCase();

        $('#referrals-sendreward-accountid').val(id);
        $('#referrals-sendreward-name').text(name.toUpperCase());
    });

    $('#btnSendReward').click(function () {
        sendReward();
    });

    //View Email
    $('.referralsviewemail').click(function () {
        $('#referrals-viewemail-sent').text($(this).attr('data-sent'));
        $('#referrals-viewemail-from').text($(this).attr('data-from'));
        $('#referrals-viewemail-to').text($(this).attr('data-to'));
        $('#referrals-viewemail-subject').text($(this).attr('data-subject'));
        $('#referrals-viewemail-body').text($(this).attr('data-body'));
    });

    //Read Review
    $('.referralsreadmore').click(function () {

        //Send person's name & id to modal
        var id = $(this).attr('data-id');
        var name = $(this).attr('data-name').toUpperCase();

        $('#referrals-readmore-name').text(name);
    });

    //Send Nudge for Reward
    $('.referralsarchive').click(function () {

        //Send person's name & id to modal
        var id = $(this).attr('data-id');
        var name = $(this).attr('data-name');

        archiveReferral(id, name);
    });

    $('#tab1-link').click(function () {
        markReferralsAsRead(1);
    });

    $('#tab2-link').click(function () {
        markReferralsAsRead(2);
    });

    $('#tab3-link').click(function () {
        markReferralsAsRead(3);
    });
});

function markReferralsAsRead(referralType) {

    //Run ajax
    $.ajax({
        type: "POST",
        url: "/messages/update",
        data: { referralType: referralType }
    })
    .fail(function (response) {
        console.log(response.responseText);
    })
    .done(function (response) {
        console.log(response);
    });
}

function sendReward() {

    var id = $('#referrals-sendreward-accountid').val();
    var name = $('#referrals-sendreward-name').text();
    
    //Show Dialog Box
    $('#referralsSendReward').modal('hide');
    $('#procMsg').text('Sending Reward to ' + name + ', ' + id + '...');
    $('#modalProcessing').modal('show');

    //Show dialog for at least 3 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/referrals/sendreward/",
            data: null
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('There was an error sending the Reward.');
            $('#modalOk').modal('show');

            console.log('fail');
            console.log('response.statusText: ' + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {
                //Hide Dialog Box
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('Nudge was sent successfully!');
                $('#modalOk').modal('show');
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('There was an error sending the Reward.');
                $('#modalOk').modal('show');
            }

            console.log('done');
            console.log('response.Success: ' + response.Success);
            console.log('response.DynObject: ' + response.DynObject);
            console.log('response.MessageForLog: ' + response.MessageForLog);
            console.log('response.MessageForUser: ' + response.MessageForUser);
        });

    }, 3000);

}

function sendNudgeForReward(id, name) {

    //Show Dialog Box
    $('#procMsg').text('Sending Nudge to ' + name + ', ' + id + '...');
    $('#modalProcessing').modal('show');

    //Show dialog for at least 3 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/referrals/sendnudge/",
            data: null
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('There was an error sending the Nudge.');
            $('#modalOk').modal('show');

            console.log('fail');
            console.log('response.statusText: ' + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {
                //Hide Dialog Box
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('Nudge was sent successfully!');
                $('#modalOk').modal('show');
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('There was an error sending the Nudge.');
                $('#modalOk').modal('show');
            }

            console.log('done');
            console.log('response.Success: ' + response.Success);
            console.log('response.DynObject: ' + response.DynObject);
            console.log('response.MessageForLog: ' + response.MessageForLog);
            console.log('response.MessageForUser: ' + response.MessageForUser);
        });

    }, 3000);

}

function archiveReferral(id, name) {

    //Show Dialog Box
    $('#procMsg').html('ARCHIVING REFERRAL<br/><br/>' + name);
    $('#modalProcessing').modal('show');

    //Show dialog for at least 3 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/referrals/sendreward/",
            data: null
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('There was an error archiving the Referral.');
            $('#modalOk').modal('show');

            console.log('fail');
            console.log('response.statusText: ' + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {
                //Hide Dialog Box
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('Referral was archived successfully!');
                $('#modalOk').modal('show');
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('There was an error archiving the Referral.');
                $('#modalOk').modal('show');
            }

            console.log('done');
            console.log('response.Success: ' + response.Success);
            console.log('response.DynObject: ' + response.DynObject);
            console.log('response.MessageForLog: ' + response.MessageForLog);
            console.log('response.MessageForUser: ' + response.MessageForUser);
        });

    }, 5000);

}