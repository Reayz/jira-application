using System.ComponentModel.DataAnnotations;

namespace JiraApplication.Models
{
    public class Dashboard
    {
        public List<Issue> Issues { get; set; }
        public Dashboard()
        {
            Issues = new List<Issue>();
        }
    }

    public class Issue
    {
        public int TenantID { get; set; }
        public int ProjectID { get; set; }
        public int IssueID { get; set; }
        public string IssueType { get; set; }

        [Required]
        [Display(Name = "Issue Key")]
        public string IssueNo { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string SprintName { get; set; }
        public string Assignee { get; set; }
        public string Status { get; set; }      
        public string Priority { get; set; }
        public string CommentText { get; set; }
        public string CreatedBy { get; set; }      
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}
