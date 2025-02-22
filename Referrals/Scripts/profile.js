$(document).ready(function () {

    $('#profile-professions-category').change(function () {
        GetSubCategories($(this).val());
    });

    $('#profile-professions-subcategory').change(function () {
        if ($(this).val() > 0) {
            $('#profile-professions-addtolist').css('visibility', 'visible');
        }
        else {
            $('#profile-professions-addtolist').css('visibility', 'hidden');
        }
    });

    $('#profile-professions-addtolist').click(function () {
        var subCat = $('#profile-professions-subcategory option:selected');
        $('#profile-professions-acct').prepend("<option value='" + subCat.val() + "'>" + subCat.text() + "</option>");
    });

    $('#profile-professions-removefromlist').click(function () {
        $('#profile-professions-acct option:selected').remove();
    });

    $('#profile-locations-add').click(function () {
        var city = $('#profile-location-city').val();
        var stateVal = $('#profile-location-state option:selected').val();
        var countryVal = $('#profile-location-country option:selected').val();
        var stateText = $('#profile-location-state option:selected').text();
        var countryText = $('#profile-location-country option:selected').text();

        $('#profile-locations-acct').prepend("<option value='" + city + '|' + stateVal + '|' + countryVal + "'>" + city + ', ' + stateText + ', ' + countryText + "</option>");

    });

    $('#profile-locations-remove').click(function(){
        $('#profile-locations-acct option:selected').remove();
    });

    $('#btnSaveProfile').click(function () {
        $('#profile-professions-acct option').prop("selected", true);
        $('#profile-locations-acct option').prop("selected", true);

        $('#procMsg').text('Updating Account, please wait...');
        $('#modalProcessing').modal('show');
        setTimeout(function () {
            $('#frmProfile').submit();
        }, 3000);
    });

    $('#btnViewProfile,#btnEditProfile').click(function () {
        $('#procMsg').text('Loading Account...');
        $('#modalProcessing').modal('show');
    });

});

function GetSubCategories(parent)
{
    //Show searching bar
    $('#profile-professions-addtolist').css('visibility', 'hidden');
    $('#profile-professions-subcategory').css('visibility', 'hidden');
    $('#divGetSubCategoriesLoading').show();

    //Show bar for at least 3 seconds
    setTimeout(function () {

        console.log('sending ajax');

        //Run ajax
        $.ajax({
            type: "GET",
            url: "/account/getcategories/",
            data: "parent=" + parent
        })
        .fail(function (response) {
            $('#divGetSubCategoriesLoading').hide();

            console.log('fail');
            console.log("response.statusText: " + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            $('#divGetSubCategoriesLoading').hide();
            $('#profile-professions-subcategory').html(response);
            $('#profile-professions-subcategory').css('visibility', 'visible');
            
            console.log('done');
            console.log(response);
        });

    }, 3000);
}