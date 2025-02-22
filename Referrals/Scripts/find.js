$(document).ready(function () {

    $('#find-professions-category').change(function () {
        GetSubCategories($(this).val());
    });

});

function GetSubCategories(parent)
{
    //Show searching bar
    $('#find-professions-subcategory').css('visibility', 'hidden');
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
            $('#find-professions-subcategory').html(response);
            $('#find-professions-subcategory').css('visibility', 'visible');
            
            console.log('done');
            console.log(response);
        });

    }, 3000);
}