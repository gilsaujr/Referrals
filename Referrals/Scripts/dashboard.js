$(document).ready(function () {

    $('#btnReferralModules, #btnRolodexModules, #btnJobModules, #btnFindProfModules, #btnProfileModules, #btnMessageModules, #btnNotificationModules').click(function () {
        $('#referralModules, #rolodexModules, #jobModules, #findProfModules, #profileModules, #messageModules, #notificationModules').hide();
        $($(this).attr('data-toggle')).show();
        window.location = $(this).attr('data-toggle');
    });

});