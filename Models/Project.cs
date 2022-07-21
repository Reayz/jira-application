namespace JiraApplication.Models
{
    public class Project
    {
        public int ProjectID { get; set; }
        public int TenantID { get; set; }
        public string ProjectKey { get; set; }
        public string ProjectName { get; set; }
        public string Owner { get; set; }
    }
}
