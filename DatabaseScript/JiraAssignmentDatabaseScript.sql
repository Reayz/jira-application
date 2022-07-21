
-- Design a database for a Jira application
-- Project
-- - Task
-- - Comment
-- - Assignee
-- - Description
-- - Workflow
-- Discussion on 31 March 2022


USE master;
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'JiraApp')
BEGIN
	DROP DATABASE JiraApp;
END
GO

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'JiraApp')
BEGIN
	CREATE DATABASE JiraApp;
END
GO

USE JiraApp;
GO

CREATE TABLE "AppUser"(
    "UserID" INT IDENTITY (1, 1),
    "TenantID" INT NOT NULL,
    "UserName" NVARCHAR(255) NOT NULL,
    "FirstName" NVARCHAR(255) NOT NULL,
    "LastName" NVARCHAR(255) NOT NULL,
    "Email" NVARCHAR(255) NOT NULL,
    "Phone" NVARCHAR(255) NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "AppUser" ADD CONSTRAINT "users_userid_primary" PRIMARY KEY("UserID");

---------------- Insert some dummy data	---------------------
INSERT INTO AppUser(TenantID, UserName, FirstName, LastName, Email, Phone, CreatedDate, CreatedBy)
VALUES (100, 'Reayz', 'Reajul', 'Haque', 'reayz77@yahoo.com', '01738081339', '05-23-2022', 'System');

INSERT INTO AppUser(TenantID, UserName, FirstName, LastName, Email, Phone, CreatedDate, CreatedBy)
VALUES (101, 'Rajib', 'Rajib', 'Paul', 'rajib7@yahoo.com', '01738081333', '06-23-2022', 'System');

INSERT INTO AppUser(TenantID, UserName, FirstName, LastName, Email, Phone, CreatedDate, CreatedBy)
VALUES (100, 'Polash', 'Polash', 'Roy', 'polash7@yahoo.com', '01738081330', '06-23-2022', 'System');



CREATE TABLE "AppCredential"(
    "id" INT IDENTITY (1, 1),
    "TenantID" int NOT NULL,
    "UserID" int NOT NULL,
    "UserName" NVARCHAR(255) NOT NULL,
    "Password" NVARCHAR(255) NOT NULL,
    "Email" NVARCHAR(255) NOT NULL,
    "ConnectionKey" NVARCHAR(255) NULL,
    "DBName" NVARCHAR(255) NULL,
    "SubdomainName" NVARCHAR(255) NULL
);

ALTER TABLE "AppCredential" ADD CONSTRAINT "credentials_id_primary" PRIMARY KEY("id");

INSERT INTO AppCredential(TenantID, UserID, UserName, Password, Email, ConnectionKey, DBName, SubdomainName)
VALUES (100, 1, 'Reayz', 'Reayz7', 'reayz77@yahoo.com', 'Key1', 'JiraApp', 'enosis.jira.com');

INSERT INTO AppCredential(TenantID, UserID, UserName, Password, Email, ConnectionKey, DBName, SubdomainName)
VALUES (101, 2, 'Rajib', 'Rajib7', 'rajib7@yahoo.com', 'Key1', 'JiraApp', 'enosis.jira.com');

INSERT INTO AppCredential(TenantID, UserID, UserName, Password, Email, ConnectionKey, DBName, SubdomainName)
VALUES (100, 3, 'Polash', 'Polash7', 'polash7@yahoo.com', 'Key1', 'JiraApp', 'enosis.jira.com');


CREATE TABLE "AllCredentialHistory"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "UserID" INT NOT NULL,
    "Password" NVARCHAR(255) NOT NULL,
    "UpdatedDate" DATETIME NOT NULL
);

ALTER TABLE "AllCredentialHistory" ADD CONSTRAINT "allcredentialhistory_id_primary" PRIMARY KEY("id");


CREATE TABLE "Role"(
    "RoleID" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "RoleName" NVARCHAR(255) NOT NULL
);

ALTER TABLE "Role" ADD CONSTRAINT "role_roleid_primary" PRIMARY KEY("RoleID");

INSERT INTO Role(TenantID, RoleName)
VALUES (100, 'Developer');


CREATE TABLE "TenantGroup"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ClientName" NVARCHAR(255) NOT NULL,
	"ConnectionKey" NVARCHAR(255) NULL,
    "DBName" NVARCHAR(255) NULL,
    "SubdomainName" NVARCHAR(255) NULL
);

ALTER TABLE "TenantGroup" ADD CONSTRAINT "tenantgroup_id_primary" PRIMARY KEY("id");

INSERT INTO TenantGroup(TenantID, ClientName, ConnectionKey, DBName, SubdomainName)
VALUES (100, 'Reayz', 'Key1', 'JiraApp', 'enosis.jira.com');

INSERT INTO TenantGroup(TenantID, ClientName, ConnectionKey, DBName, SubdomainName)
VALUES (101, 'Rajib', 'Key1', 'JiraApp', 'enosis.jira.com');


CREATE TABLE "RoleAssginment"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "UserID" INT NOT NULL,
    "RoleID" INT NOT NULL,
    "AssignedDate" DATETIME NOT NULL,
    "AssignedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "RoleAssginment" ADD CONSTRAINT "roleassginment_id_primary" PRIMARY KEY("id");

INSERT INTO RoleAssginment(TenantID, UserID, RoleID, AssignedDate, AssignedBy)
VALUES (100, 1, 1, '05-23-2022', 'System');

	
CREATE TABLE "Project"(
    "ProjectID" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectKey" NVARCHAR(255) NOT NULL,
    "ProjectName" NVARCHAR(255) NOT NULL,
    "ProjectType" NVARCHAR(255) NOT NULL,
    "Owner" NVARCHAR(255) NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "Project" ADD CONSTRAINT "projects_projectid_primary" PRIMARY KEY("ProjectID");
	
INSERT INTO Project(TenantID, ProjectKey, ProjectName, ProjectType, Owner, CreatedDate, CreatedBy)
VALUES (100, 'Key', 'Omnigo', 'Developer', 'Reayz', '05-23-2022', 'System');

INSERT INTO Project(TenantID, ProjectKey, ProjectName, ProjectType, Owner, CreatedDate, CreatedBy)
VALUES (101, 'PKey', 'Matrix', 'Developer', 'Rajib', '05-23-2022', 'System');


CREATE TABLE "ProjectRole"(
    "ProjectRoleID" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectRoleName" NVARCHAR(255) NOT NULL
);

ALTER TABLE "ProjectRole" ADD CONSTRAINT "projectrole_projectroleid_primary" PRIMARY KEY("ProjectRoleID");

INSERT INTO ProjectRole(TenantID, ProjectRoleName)
VALUES (100, 'Developer');

INSERT INTO ProjectRole(TenantID, ProjectRoleName)
VALUES (101, 'Developer');


CREATE TABLE "ProjectAssignment"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectID" INT NOT NULL,
    "UserID" INT NOT NULL,
    "ProjectRoleID" INT NOT NULL,
    "AssignedDate" DATETIME NOT NULL,
    "AssginedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "ProjectAssignment" ADD CONSTRAINT "projectassignment_id_primary" PRIMARY KEY("id");

INSERT INTO ProjectAssignment(TenantID, ProjectID, UserID, ProjectRoleID, AssignedDate, AssginedBy)
VALUES (100, 1, 1, 1, '05-23-2022', 'System');

INSERT INTO ProjectAssignment(TenantID, ProjectID, UserID, ProjectRoleID, AssignedDate, AssginedBy)
VALUES (101, 2, 2, 2, '05-23-2022', 'System');

INSERT INTO ProjectAssignment(TenantID, ProjectID, UserID, ProjectRoleID, AssignedDate, AssginedBy)
VALUES (100, 1, 3, 1, '05-23-2022', 'System');


CREATE TABLE "Sprint"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectID" INT NOT NULL,
    "SprintName" NVARCHAR(255) NOT NULL,
    "StartDate" DATETIME NULL,
    "EndDate" DATETIME NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "Sprint" ADD CONSTRAINT "sprint_id_primary" PRIMARY KEY("id");
	
INSERT INTO Sprint(TenantID, ProjectID, SprintName, CreatedDate, CreatedBy)
VALUES (100, 1, 'Sprint-1', '05-23-2022', 'System');

INSERT INTO Sprint(TenantID, ProjectID, SprintName, CreatedDate, CreatedBy)
VALUES (101, 2, 'Sprint-101', '05-23-2022', 'System');


CREATE TABLE "Issue"(
    "IssueID" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectID" INT NOT NULL,
    "SprintID" INT NULL,
    "EpicLinkID" INT NULL,
    "ParentID" INT NULL,
    "IssueNo" NVARCHAR(255) NOT NULL,
    "IssueType" NVARCHAR(255) NOT NULL,
    "Title" NVARCHAR(255) NOT NULL,
    "Description" NVARCHAR(MAX) NULL,
    "Status" NVARCHAR(255) NOT NULL,
    "Priority" NVARCHAR(255) NOT NULL,
    "Labels" NVARCHAR(255) NULL,
    "Assignee" NVARCHAR(255) NULL,
    "Developer" NVARCHAR(255) NULL,
    "QA" NVARCHAR(255) NULL,
    "Estimation" NVARCHAR(255) NULL,
    "CustomColumn1" NVARCHAR(255) NULL,
    "CustomColumn2" NVARCHAR(255) NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL,
    "ModifiedDate" DATETIME NULL,
    "ModifiedBy" NVARCHAR(255) NULL
);

ALTER TABLE "Issue" ADD CONSTRAINT "issue_issueid_primary" PRIMARY KEY("IssueID");

INSERT INTO Issue(TenantID, ProjectID, SprintID, IssueNo, IssueType, Title, Description, Status, Priority, Assignee, CreatedDate, CreatedBy)
VALUES (100, 1, 1, 'Key-1', 'Feature', 'Title Title Title Title Title Title 01', 'Issue Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description 01', 'In Progress', 'Medium', 'Reayz', '05-23-2022', 'System');

INSERT INTO Issue(TenantID, ProjectID, SprintID, IssueNo, IssueType, Title, Description, Status, Priority, Assignee, CreatedDate, CreatedBy)
VALUES (100, 1, 1, 'Key-2', 'Bug', 'Title Title Title Title Title Title 02', 'Issue Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description 02', 'Dev Done', 'Low', 'Reayz', '05-21-2022', 'System');

INSERT INTO Issue(TenantID, ProjectID, SprintID, IssueNo, IssueType, Title, Description, Status, Priority, Assignee, CreatedDate, CreatedBy)
VALUES (100, 1, 1, 'Key-3', 'Blocker', 'Title Title Title Title Title Title 03', 'Issue Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description 03', 'Dev Ready', 'High', 'Reayz', '05-20-2022', 'System');

INSERT INTO Issue(TenantID, ProjectID, SprintID, IssueNo, IssueType, Title, Description, Status, Priority, Assignee, CreatedDate, CreatedBy)
VALUES (101, 2, 2, 'PKey-1', 'Feature', 'Title Title Title Title Title Title 01', 'Issue Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description 01', 'In Progress', 'Medium', 'Rajib', '05-23-2022', 'System');
	

CREATE TABLE "IssueHistory"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "IssueID" INT NOT NULL,
    "UpdatedField" NVARCHAR(255) NOT NULL,
    "OldValue" NVARCHAR(255) NOT NULL,
    "NewValue" NVARCHAR(255) NOT NULL,
    "UpdatedDate" DATETIME NOT NULL,
    "UpdatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "IssueHistory" ADD CONSTRAINT "issuehistory_id_primary" PRIMARY KEY("id");


CREATE TABLE "KeyTracker"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectID" INT NOT NULL,
    "LookupKey" NVARCHAR(255) NOT NULL,
    "NextKey" int NOT NULL
);

ALTER TABLE "KeyTracker" ADD CONSTRAINT "keytracker_id_primary" PRIMARY KEY("id");

------------  DML Script for initial data ---------
INSERT INTO KeyTracker(TenantID, ProjectID, LookupKey, NextKey)
VALUES (100, 1, 'IssueKey', '4');

INSERT INTO KeyTracker(TenantID, ProjectID, LookupKey, NextKey)
VALUES (101, 2, 'IssueKey', '2');


CREATE TABLE "IssueComment"(
    "CommentID" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "IssueID" INT NOT NULL,
    "CommentText" NVARCHAR(MAX) NOT NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL,
    "ModifiedDate" DATETIME NULL,
    "ModifiedBy" NVARCHAR(255) NULL
);

ALTER TABLE "IssueComment" ADD CONSTRAINT "issuecomment_id_primary" PRIMARY KEY("CommentID");

INSERT INTO IssueComment(TenantID, IssueID, CommentText, CreatedDate, CreatedBy)
VALUES (100, 1, 'This is a comment1. This is a comment. This is a comment. This is a comment. This is a comment. ', '05-23-2022', 'System');

INSERT INTO IssueComment(TenantID, IssueID, CommentText, CreatedDate, CreatedBy)
VALUES (100, 1, 'This is a comment2. This is a comment. This is a comment. This is a comment. This is a comment. ', '05-23-2022', 'System');

INSERT INTO IssueComment(TenantID, IssueID, CommentText, CreatedDate, CreatedBy)
VALUES (100, 1, 'This is a comment3. This is a comment. This is a comment. This is a comment. This is a comment. ', '05-23-2022', 'System');

INSERT INTO IssueComment(TenantID, IssueID, CommentText, CreatedDate, CreatedBy)
VALUES (101, 4, 'This is a comment3. This is a comment. This is a comment. This is a comment. This is a comment. This is a comment. This is a comment. This is a comment. This is a comment.', '05-23-2022', 'System');


CREATE TABLE "Attachment"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "IssueID" INT NOT NULL,
    "CommentID" INT NULL,
    "AttachmentType" NVARCHAR(255) NOT NULL,
    "FileContent" VARBINARY(MAX) NOT NULL,
    "AttachedDate" DATETIME NOT NULL,
    "AttachedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "Attachment" ADD CONSTRAINT "attachment_id_primary" PRIMARY KEY("id");

CREATE TABLE "CustomField"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectID" INT NOT NULL,
    "FieldName" NVARCHAR(255) NOT NULL,
    "FieldType" NVARCHAR(255) NOT NULL,
    "Description" NVARCHAR(255) NOT NULL,
    "DefaultValue" NVARCHAR(255) NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "CustomField" ADD CONSTRAINT "customfield_id_primary" PRIMARY KEY("id");
	
CREATE TABLE "CustomFieldValue"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "IssueID" INT NOT NULL,
    "FieldID" INT NOT NULL,
    "FieldValue" NVARCHAR(255) NOT NULL,
    "ValueSetDate" DATETIME NOT NULL,
    "ValueSetBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "CustomFieldValue" ADD CONSTRAINT "customfieldvalue_id_primary" PRIMARY KEY("id");

CREATE TABLE "WorkflowAssignment"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "ProjectID" INT NOT NULL,
    "TemplateID" INT NOT NULL,
    "AssignDate" DATETIME NOT NULL,
    "AssignBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "WorkflowAssignment" ADD CONSTRAINT "workflowassignment_id_primary" PRIMARY KEY("id");
	
CREATE TABLE "WorkflowTemplate"(
    "TemplateID" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "TemplateName" NVARCHAR(255) NOT NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "WorkflowTemplate" ADD CONSTRAINT "workflowtemplate_templateid_primary" PRIMARY KEY("TemplateID");
	
CREATE TABLE "WorkflowStatus"(
    "TemplateID" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "StatusID" INT NOT NULL,
    "StatusText" NVARCHAR(255) NOT NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "WorkflowStatus" ADD CONSTRAINT "workflowstatus_statusid_primary" PRIMARY KEY("StatusID");
	
CREATE TABLE "WorkflowTransition"(
    "id" INT IDENTITY (1, 1),
	"TenantID" INT NOT NULL,
    "StatusFromID" INT NOT NULL,
    "StatusToID" INT NOT NULL,
    "Action" NVARCHAR(255) NOT NULL,
    "CreatedDate" DATETIME NOT NULL,
    "CreatedBy" NVARCHAR(255) NOT NULL
);

ALTER TABLE "WorkflowTransition" ADD CONSTRAINT "workflowtransition_id_primary" PRIMARY KEY("id");



ALTER TABLE "AppCredential" ADD CONSTRAINT "credentials_userid_foreign" FOREIGN KEY("UserID") REFERENCES "AppUser"("UserID");

ALTER TABLE "AllCredentialHistory" ADD CONSTRAINT "allcredentialhistory_userid_foreign" FOREIGN KEY("UserID") REFERENCES "AppUser"("UserID");

ALTER TABLE "RoleAssginment" ADD CONSTRAINT "roleassginment_userid_foreign" FOREIGN KEY("UserID") REFERENCES "AppUser"("UserID");
	
ALTER TABLE "RoleAssginment" ADD CONSTRAINT "roleassginment_roleid_foreign" FOREIGN KEY("RoleID") REFERENCES "Role"("RoleID");

ALTER TABLE "ProjectAssignment" ADD CONSTRAINT "projectassignment_userid_foreign" FOREIGN KEY("UserID") REFERENCES "AppUser"("UserID");
	
ALTER TABLE "ProjectAssignment" ADD CONSTRAINT "projectassignment_projectid_foreign" FOREIGN KEY("ProjectID") REFERENCES "Project"("ProjectID");

ALTER TABLE "ProjectAssignment" ADD CONSTRAINT "projectassignment_projectroleid_foreign" FOREIGN KEY("ProjectRoleID") REFERENCES "ProjectRole"("ProjectRoleID");

ALTER TABLE "Issue" ADD CONSTRAINT "issue_projectid_foreign" FOREIGN KEY("ProjectID") REFERENCES "Project"("ProjectID");

ALTER TABLE "IssueHistory" ADD CONSTRAINT "issuehistory_issueid_foreign" FOREIGN KEY("IssueID") REFERENCES "Issue"("IssueID");

ALTER TABLE "KeyTracker" ADD CONSTRAINT "KeyTracker_projectid_foreign" FOREIGN KEY("ProjectID") REFERENCES "Project"("ProjectID");

ALTER TABLE "IssueComment" ADD CONSTRAINT "issuecomment_issueid_foreign" FOREIGN KEY("IssueID") REFERENCES "Issue"("IssueID");
	
ALTER TABLE "Attachment" ADD CONSTRAINT "attachment_issueid_foreign" FOREIGN KEY("IssueID") REFERENCES "Issue"("IssueID");

ALTER TABLE "Attachment" ADD CONSTRAINT "attachment_commentid_foreign" FOREIGN KEY("CommentID") REFERENCES "IssueComment"("CommentID");
	
ALTER TABLE "Sprint" ADD CONSTRAINT "sprint_projectid_foreign" FOREIGN KEY("ProjectID") REFERENCES "Project"("ProjectID");
	
ALTER TABLE "CustomField" ADD CONSTRAINT "customfield_projectid_foreign" FOREIGN KEY("ProjectID") REFERENCES "Project"("ProjectID");

ALTER TABLE "CustomFieldValue" ADD CONSTRAINT "customfieldvalue_fieldid_foreign" FOREIGN KEY("FieldID") REFERENCES "CustomField"("id");
	
ALTER TABLE "CustomFieldValue" ADD CONSTRAINT "customfieldvalue_issueid_foreign" FOREIGN KEY("IssueID") REFERENCES "Issue"("IssueID");
	
ALTER TABLE "WorkflowAssignment" ADD CONSTRAINT "workflowassignment_projectid_foreign" FOREIGN KEY("ProjectID") REFERENCES "Project"("ProjectID");

ALTER TABLE "WorkflowAssignment" ADD CONSTRAINT "workflowassignment_templateid_foreign" FOREIGN KEY("TemplateID") REFERENCES "WorkflowTemplate"("TemplateID");

ALTER TABLE "WorkflowStatus" ADD CONSTRAINT "workflowstatus_templateid_foreign" FOREIGN KEY("TemplateID") REFERENCES "WorkflowTemplate"("TemplateID");

ALTER TABLE "WorkflowTransition" ADD CONSTRAINT "workflowtransition_statusfromid_foreign" FOREIGN KEY("StatusFromID") REFERENCES "WorkflowStatus"("StatusID");

ALTER TABLE "WorkflowTransition" ADD CONSTRAINT "workflowtransition_statustoid_foreign" FOREIGN KEY("StatusToID") REFERENCES "WorkflowStatus"("StatusID");


-------------- Store Procedure (SP) -------------------

CREATE PROCEDURE [dbo].[GetUser]
@UserName AS NVARCHAR(255),
@Password AS NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON
	SELECT TenantID, UserID, UserName, ConnectionKey, DBName FROM AppCredential WHERE UserName = @UserName AND Password = @Password COLLATE Latin1_General_bin
	SET NOCOUNT OFF
END
GO

CREATE PROCEDURE [dbo].[GetAllIssues]
@TenantID AS NUMERIC,
@ProjectID AS NUMERIC
AS
BEGIN
	SET NOCOUNT ON

	SELECT Issue.TenantID, Issue.ProjectID, IssueID, IssueType, IssueNo, Title, Description, SprintName, Assignee, Status, Priority, Issue.CreatedBy, Issue.CreatedDate, Issue.ModifiedDate, Issue.ModifiedBy
	FROM Issue 
	LEFT OUTER JOIN Sprint
	ON Issue.TenantID = Sprint.TenantID AND Issue.SprintID = Sprint.id
	WHERE Issue.TenantID = @TenantID AND Issue.ProjectID = @ProjectID

	SET NOCOUNT OFF
END
GO

CREATE PROCEDURE [dbo].[GetIssueByKey]
@TenantID AS NUMERIC,
@Key AS NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON

	SELECT Issue.TenantID, Issue.ProjectID, IssueID, IssueType, IssueNo, Title, Description, SprintName, Assignee, Status, Priority, Issue.CreatedBy, Issue.CreatedDate, Issue.ModifiedDate, Issue.ModifiedBy
	FROM Issue 
	LEFT OUTER JOIN Sprint
	ON Issue.TenantID = Sprint.TenantID AND Issue.SprintID = Sprint.id
	WHERE Issue.TenantID = @TenantID AND Issue.IssueNo = @Key

	SET NOCOUNT OFF
END
GO

CREATE PROCEDURE [dbo].[GetAllComments]
@TenantID AS NUMERIC,
@IssueID AS NUMERIC
AS
BEGIN
	SET NOCOUNT ON

	SELECT [CommentID]
      ,[TenantID]
      ,[IssueID]
      ,[CommentText]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[ModifiedDate]
      ,[ModifiedBy]
	FROM [JiraApp].[dbo].[IssueComment] WHERE TenantID = @TenantID AND IssueID = @IssueID ORDER BY CreatedDate DESC

	SET NOCOUNT OFF
END
GO

CREATE PROCEDURE [dbo].[SaveIssue]
@TenantID AS NUMERIC,
@ProjectID AS NUMERIC,
@IssueID AS NUMERIC,
@IssueType AS NVARCHAR(50),
@Title AS NVARCHAR(MAX),
@Description AS NVARCHAR(MAX),
@Priority AS NVARCHAR(50),
@Action AS NVARCHAR(50),
@UserID AS NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON

	IF @Action = 'Add'
	BEGIN
		DECLARE @NextKey AS VARCHAR(100), @NewKey AS VARCHAR(100)

		SELECT @NextKey = P.ProjectKey + '-' + CAST(KT.NextKey AS VARCHAR(10))
		FROM KeyTracker KT WITH (NOLOCK)
		INNER JOIN Project P  WITH (NOLOCK)
		ON KT.TenantID = P.TenantID AND KT.ProjectID = P.ProjectID
		WHERE KT.TenantID = @TenantID AND KT.ProjectID = @ProjectID AND KT.LookupKey = 'IssueKey'

		INSERT INTO Issue(TenantID, ProjectID, IssueNo, IssueType, Title, Description, Priority, Status, CreatedDate, CreatedBy)
		VALUES (@TenantID, @ProjectID, @NextKey, @IssueType, @Title, @Description, @Priority, 'Backlog', GETDATE(), @UserID)

		UPDATE KeyTracker 
		SET NextKey = NextKey + 1
		WHERE TenantID = @TenantID AND ProjectID = @ProjectID AND LookupKey = 'IssueKey'

		SELECT @NextKey
	END
	ELSE
	BEGIN
		UPDATE Issue 
		SET IssueType = @IssueType,
			Title = @Title,
			Description = @Description,
			Priority = @Priority,
			ModifiedDate = GETDATE(),
			ModifiedBy = @UserID
		WHERE TenantID = @TenantID AND ProjectID = @ProjectID AND IssueID = @IssueID
		SELECT IssueNo FROM Issue WHERE TenantID = @TenantID AND ProjectID = @ProjectID AND IssueID = @IssueID
	END

	SET NOCOUNT OFF
END
GO

CREATE PROCEDURE [dbo].[GetProjectID]
@TenantID AS NUMERIC,
@UserID AS NUMERIC
AS
BEGIN
	SET NOCOUNT ON
	SELECT ProjectID FROM ProjectAssignment WHERE TenantID = @TenantID AND UserID = @UserID
	SET NOCOUNT OFF
END
GO

CREATE PROCEDURE [dbo].[AddComment]
@TenantID AS NUMERIC,
@IssueID AS NUMERIC,
@CommentText AS NVARCHAR(MAX),
@UserID AS NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO IssueComment(TenantID, IssueID, CommentText, CreatedDate, CreatedBy)
	VALUES (@TenantID, @IssueID, @CommentText, GETDATE(), @UserID)

	RETURN 0
	SET NOCOUNT OFF
END
GO

CREATE PROCEDURE [dbo].[GetProjectInfo]
@TenantID AS NUMERIC,
@UserID AS NUMERIC
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ProjectID AS VARCHAR(100)
	SELECT @ProjectID = ProjectID 
	FROM ProjectAssignment WHERE TenantID = @TenantID AND UserID = @UserID

	SELECT ProjectID, TenantID, ProjectKey, ProjectName, Owner 
	FROM Project WHERE TenantID = @TenantID AND ProjectID = @ProjectID

	SET NOCOUNT OFF
END
GO

------------------------------------- Some useful DML Script --------------------------------------
UPDATE Issue
SET Title = 'Issue Title 01 - Lorem Ipsum is simply dummy text of the printing and typesetting industry' 
WHERE IssueID = 1

UPDATE Issue
SET Description = 'Issue Description 01. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.' 
WHERE IssueID = 1

select * from Issue


