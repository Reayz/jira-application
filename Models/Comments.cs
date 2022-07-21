namespace JiraApplication.Models
{
    public class Comments
    {
        public List<Comment> AllComments { get; set; }
        public Comments()
        {
            AllComments = new List<Comment>();
        }
    }

    public class Comment
    {
        public int CommentID { get; set; }
        public int TenantID { get; set; }
        public int IssueID { get; set; }
        public string CommentText { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
    }
}
