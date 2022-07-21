using System.ComponentModel.DataAnnotations;

namespace JiraApplication.Models
{
    public class AppCredential
    {
        public int TenantID { get; set; }
        public int UserID { get; set; }
        [Required]
        public string UserName { get; set; }
        public string ConnectionKey { get; set; }
        public string DBName { get; set; }
        public string Password { get; set; }
    }
}
