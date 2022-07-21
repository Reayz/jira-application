function logInBtnClicked() {
    var userName = $("#userName").val();
    var password = $("#password").val();

    if (userName.trim() !== purifyText(userName)) {
        showErrorNotification("Please check User Name. It contains potentially dangerous scripts.");
        return;
    }

    if (password.trim() !== purifyText(password)) {
        showErrorNotification("Please check Password. It contains potentially dangerous scripts.");
        return;
    }

    $.ajax({
        url: verifyUserURl,
        type: 'POST',
        async: true,
        contentType: 'application/json;',
        data: JSON.stringify({
            userName: userName,
            password: password
        }),
        success: function (res) {
            if (res) {
                window.location.href = dashboardURL;
            } else {
                $("#wrongCred").css("display", "block");
            }
        },
        error: function (res) {
            alert("Something went wrong!");
        }
    });
}

function credentialChanged() {
    $("#wrongCred").css("display", "none");
}

