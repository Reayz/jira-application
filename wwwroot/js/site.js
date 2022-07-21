$(document).ready(function () {
    $(document).on('click', '.createIssueBtn', function (e) {
        e.preventDefault();
        $.ajax({
            url: "/Issue/CreateIssue",
            type: 'POST',
            async: true,
            contentType: 'application/json;',
            data: JSON.stringify({}),
            success: function (partialView) {
                $("#create-issue-modal-container").html(partialView);
                $("#create-issue-modal-container .modal#create-issue-modal").modal("show");
            },
            error: function () {
                alert("Something went wrong!");
            }
        });
    });
});

function purifyText(strHTML) {
    var rtn = "";
    strHTML = DOMPurify.sanitize(strHTML.trim(), { USE_PROFILES: { html: false, mathMl: false, svg: false } });
    rtn = strHTML.toString()
        .replace(/&amp;/g, "&")
        .replace(/&quot;/g, "\"")
        .replace(/&lt;/g, "<")
        .replace(/&gt;/g, ">")
        .replace(/&rsquo;/g, "'")
        .replace(/&apos;/g, "'")
        .replace(/&#/g, "");
    return rtn;
}

function showSuccessNotification(message, options) {
    toastr.options = {
        "positionClass": "toast-top-right",
        "timeOut": "8000",
    };

    if (options != null) {
        toastr.options = Object.assign(toastr.options, options);;
    }

    return toastr.success(message);
}

function showErrorNotification(message, options) {
    toastr.options = {
        "positionClass": "toast-top-right",
        "timeOut": "10000",
    };

    if (options != null) {
        toastr.options = Object.assign(toastr.options, options);
    }

    message = !!message ? message : "An error occured while loading the request."

    return toastr.error(message);
}

function showWarningNotification(message, options) {
    toastr.options = {
        "positionClass": "toast-top-right",
        "timeOut": "10000",
    };

    if (options != null) {
        toastr.options = Object.assign(toastr.options, options);
    }

    return toastr.warning(message);
}
