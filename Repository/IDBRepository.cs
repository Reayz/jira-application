using JiraApplication.Models;

namespace JiraApplication.Repository
{
    public interface IDBRepository
    {
        AppCredential GetUserInfo(string userName, string password);

        IEnumerable<Issue> GetAllIssues();

        Issue GetIssueByKey(string key);

        IEnumerable<Comment> GetAllComments(int issueID);

        string SaveIssue(Issue issue);

        int AddComment(int issueID, string commentText);
        string GetProjectName();

    }
}
