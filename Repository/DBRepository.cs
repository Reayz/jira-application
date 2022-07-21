using JiraApplication.DBContexts;
using JiraApplication.Models;

namespace JiraApplication.Repository
{
    public class DBRepository : IDBRepository
    {
        private readonly IDapperDBContext _dapperDBContext;
        private readonly IConfiguration _configuration;
        private readonly HttpContext _httpContext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public DBRepository(IDapperDBContext dapperDBContext,
                            IConfiguration configuration,
                            IHttpContextAccessor httpContextAccessor)
        {
            _dapperDBContext = dapperDBContext;
            _httpContextAccessor = httpContextAccessor;
            _httpContext = httpContextAccessor.HttpContext;
            _configuration = configuration;
        }

        private int GetTenantID()
        {
            int tenantID = 0;
            try
            {
                tenantID = (int)_httpContext.Session.GetInt32("CurrentTenantID");
            }
            catch
            {
                tenantID = 0;
            }
            return tenantID;
        }

        private int GetUserID()
        {
            int userID = 0;
            try
            {
                userID = (int)_httpContext.Session.GetInt32("CurrentUserID");
            }
            catch
            {
                userID = 0;
            }
            return userID;
        }

        private int GetProjectID()
        {
            int projectID = 0;
            try
            {
                projectID = (int)_httpContext.Session.GetInt32("CurrentUserProjectID");
            }
            catch
            {
                projectID = 0;
            }

            if (projectID == 0)
            {
                Project project = _dapperDBContext.GetInfo<Project>(new
                {
                    TenantID = GetTenantID(),
                    UserID = GetUserID()
                }, "GetProjectInfo");
                projectID = project.ProjectID;

                _httpContext.Session.SetInt32("CurrentUserProjectID", project.ProjectID);
                _httpContext.Session.SetString("CurrentUserProjectName", project.ProjectName);
            }

            return projectID;
        }

        private string GetUserName()
        {
            return _httpContext.Session.GetString("CurrentUserName");
        }

        public string GetProjectName()
        {
            return _httpContext.Session.GetString("CurrentUserProjectName");
        }

        public virtual AppCredential GetUserInfo(string userName, string password)
        {
            return _dapperDBContext.GetInfo<AppCredential>(new
            {
                UserName = userName,
                Password = password
            }, "GetUser");
        }

        public IEnumerable<Issue> GetAllIssues()
        {
            return _dapperDBContext.GetInfoList<Issue>(new
            {
                TenantID = GetTenantID(),
                ProjectID = GetProjectID()
            }, "GetAllIssues");
        }

        public virtual Issue GetIssueByKey(string key)
        {
            return _dapperDBContext.GetInfo<Issue>(new
            {
                TenantID = GetTenantID(),
                Key = key
            }, "GetIssueByKey");
        }

        public IEnumerable<Comment> GetAllComments(int issueID)
        {
            return _dapperDBContext.GetInfoList<Comment>(new
            {
                TenantID = GetTenantID(),
                IssueID = issueID
            }, "GetAllComments");
        }

        public virtual string SaveIssue(Issue issue)
        {
            return _dapperDBContext.GetInfo<string>(new
            {
                TenantID = GetTenantID(),
                ProjectID = GetProjectID(),
                IssueID = issue.IssueID,
                IssueType = issue.IssueType,
                Title = issue.Title,
                Description = issue.Description,
                Priority = issue.Priority,
                Action = issue.CommentText,
                UserID = GetUserName()
            }, "SaveIssue");
        }

        public virtual int AddComment(int issueID, string commentText)
        {
            return _dapperDBContext.GetInfo<int>(new
            {
                TenantID = GetTenantID(),
                IssueID = issueID,
                CommentText = commentText,
                UserID = GetUserName()
            }, "AddComment");
        }

    }
}
