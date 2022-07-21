function getIssue() {
    var issueNumber = $("#issueNumber").val();
    if (!issueNumber) {
        $("#wrongIssueNumber").css("display", "block");
        return;
    }

    if (issueNumber.trim() !== purifyText(issueNumber)) {
        showErrorNotification("Please check Issue Number. It contains potentially dangerous scripts.");
        return;
    }

    $.ajax({
        url: verifyIssueNumberURl,
        type: 'POST',
        async: true,
        contentType: 'application/json;',
        data: JSON.stringify({
            IssueNo: issueNumber
        }),
        success: function (res) {
            if (res) {
                window.location.href = "/Issue/OpenIssue?issueKey=" + res;
            } else {
                $("#wrongIssueNumber").css("display", "block");
            }
        },
        error: function (res) {
            alert("Something went wrong!");
        }
    });
}

function issueNumberChanged() {
    $("#wrongIssueNumber").css("display", "none");
}

function saveIssueBtnClicked() {
    var issueID = $("#exitingIssueID").val();
    var issueType = $('#issueType :selected').text();
    var title = $("#title").val();
    var description = $("#description").val();
    var priority = $('#priority :selected').text();

    if (title.trim() === "") {
        showErrorNotification("Issue title can't be empty. Please enter a title.");
        return;
    }
    if (description.trim() === "") {
        showErrorNotification("Issue description can't be empty. Please enter a description.");
        return;
    }
    if (title.trim() !== purifyText(title)) {
        showErrorNotification("Please check Issue Title. It contains potentially dangerous scripts.");
        return;
    }
    if (description.trim() !== purifyText(description)) {
        showErrorNotification("Please check Issue Description. It contains potentially dangerous scripts.");
        return;
    }

    var command = "Add";
    if (issueID != "0") {
        command = "Edit";
    }

    $.ajax({
        url: "/Issue/SaveIssue",
        type: 'POST',
        async: true,
        contentType: 'application/json;',
        data: JSON.stringify({
            IssueID: issueID,
            IssueType: issueType,
            Title: title,
            Description: description,
            Priority: priority,
            CommentText: command
        }),
        success: function (res) {
            if (res) {
                $("#create-issue-modal-container .modal#create-issue-modal").modal("hide");
                window.location.href = "/Issue/OpenIssue?issueKey=" + res;
            } else {
                alert("Something went wrong!");
            }
        },
        error: function () {
            alert("Something went wrong!");
        }
    });
}

function closeIssueBtnClicked() {
    bootbox.confirm({
        title: "Confirm",
        size: "medium",
        message: "This will not create an issue. Do you want to continue? (OK = Yes, Cancel = No)",
        callback: function (result) {
            if (result) {
                $("#create-issue-modal-container .modal#create-issue-modal").modal("hide");
            }
        }
    });
}


function addCommentBtnClicked() {
    var commentText = $("#commentTextbox").val();
    var issueID = $("#issueID").val();

    if (commentText.trim() === "") {
        showErrorNotification("Comment can't be empty. Please enter some text.");
        return;
    }
    if (commentText.trim() !== purifyText(commentText)) {
        showErrorNotification("Please check the comment. It contains potentially dangerous scripts.");
        return;
    }

    $.ajax({
        url: "/Issue/AddComment",
        type: 'POST',
        async: true,
        contentType: 'application/json;',
        data: JSON.stringify({
            IssueID: issueID,
            CommentText: commentText
        }),
        success: function (res) {
            if (res) {
                $("#commentTextbox").val("");
                $(".mainCommentsDiv").html(res);
            } else {
                alert("Something went wrong!");
            }
        },
        error: function () {
            alert("Something went wrong!");
        }
    });
}


function editIssueBtnClicked() {
    var issueKey = $("#issueKey").val();

    $.ajax({
        url: "/Issue/GetIssueDetails",
        type: 'POST',
        async: true,
        contentType: 'application/json;',
        data: JSON.stringify({
            IssueNo: issueKey
        }),
        success: function (res) {
            if (res) {
                $("#create-issue-modal-container").html(res);
                $("#create-issue-modal-container .modal#create-issue-modal").modal("show");
            } else {
                alert("Something went wrong!");
            }
        },
        error: function () {
            alert("Something went wrong!");
        }
    });
}
