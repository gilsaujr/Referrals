$(document).ready(function () {

    //Add new account to database
    $('#btnSignUpSend').click(function () {
        CreateAccount();
    });

    //Ok button click
    $('#btnOK').click(function () {
        //window.location = "/home/dashboard/";
    });

    //Sign In button click
    $('#btnSignIn').click(function () {
        Login();
    });

    //Enter key is pressed in password field
    $('#txtLoginEmail, #txtLoginPassword').keypress(function (event) {
        if (event.which == 13) {
            Login();
        }
    });

    //Set focus to field
    var focusField = $.trim($('#txtLoginEmail').val()) == '' ? $('#txtLoginEmail') : $('#txtLoginPassword');
    focusField.focus();
    
});

//Login
function Login() {
    var email = $('#txtLoginEmail').val();
    var password = $('#txtLoginPassword').val();

    //Show Dialog Box
    $('#procMsg').text('Logging in, please wait...');
    $('#modalProcessing').modal('show');

    //Show dialog for at least 2 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/account/signin",
            data: { email: email, password: password }
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('Your username/password combination is invalid. ' + response.statusText);
            $('#modalOk').modal('show');

            console.log('fail');
            console.log('response.statusText: ' + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {

                //Redirect to dashboard
                window.location = "/home/dashboard";
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text(response.MessageForUser);
                $('#modalOk').modal('show');
            }

            console.log('done');
            console.log('response.Success: ' + response.Success);
            console.log('response.DynObject: ' + response.ReturnObject);
            console.log('response.MessageForLog: ' + response.MessageForLog);
            console.log('response.MessageForUser: ' + response.MessageForUser);
        });

    }, 3000);
}

//Create Account
function CreateAccount() {
    var firstname = $('#signup-firstname').val();
    var lastname = $('#signup-lastname').val();
    var phone = $('#signup-phone').val();
    var email = $('#signup-email').val();
    var password = $('#signup-password').val();

    //Show Dialog Box
    $('#signupform').modal('hide');
    $('#procMsg').text('Creating account, please wait...');
    $('#modalProcessing').modal('show');

    //Show dialog for at least 2 seconds
    setTimeout(function () {

        //Run ajax
        $.ajax({
            type: "POST",
            url: "/account/signup",
            data: { Firstname: firstname, Lastname: lastname, Phone: phone, Email: email, Password: password }
        })
        .fail(function (response) {
            $('#modalProcessing').modal('hide');
            $('#okMsg').text('There was an error creating the account. ' + response.statusText);
            $('#modalOk').modal('show');

            console.log('fail');
            console.log('response.statusText: ' + response.statusText);
            console.log("response.responseText: " + response.responseText);
        })
        .done(function (response) {

            if (response.Success) {

                //Redirect to dashboard
                window.location = "/home/dashboard";
            }
            else {
                $('#modalProcessing').modal('hide');
                $('#okMsg').text('There was an error creating the account.');
                $('#modalOk').modal('show');
            }

            console.log('done');
            console.log('response.Success: ' + response.Success);
            console.log('response.ReturnObject: ' + response.ReturnObject);
            console.log('response.MessageForLog: ' + response.MessageForLog);
            console.log('response.MessageForUser: ' + response.MessageForUser);
        });

    }, 3000);
}