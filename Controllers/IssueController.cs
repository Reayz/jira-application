using JiraApplication.Models;
using JiraApplication.Repository;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace JiraApplication.Controllers
{
    [SessionCheck]
    public class IssueController : Controller
    {
        private readonly ILogger<IssueController> _logger;
        private readonly IDBRepository _iDBRepository;
        private readonly IConfiguration _configuration;
        private readonly HttpContext _httpContext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public IssueController(ILogger<IssueController> logger,
                                IDBRepository iDBRepository,
                                IConfiguration configuration,
                                IHttpContextAccessor httpContextAccessor)
        {
            _logger = logger;
            _iDBRepository = iDBRepository;
            _httpContextAccessor = httpContextAccessor;
            _httpContext = httpContextAccessor.HttpContext;
            _configuration = configuration;
        }

        public IActionResult OpenIssue(string issueKey = "")
        {
            if (string.IsNullOrEmpty(issueKey))
            {
                issueKey = "";
            }

            Issue issue = _iDBRepository.GetIssueByKey(issueKey);
            Comments comments = new Comments();
            if (issue != null)
            {
                comments = GetIssueComments(issue.IssueID);
            }
            var tupleModel = new Tuple<Issue, Comments>(issue, comments);
            return View(tupleModel);
        }

        public ActionResult CreateIssue(Issue givenIssue)
        {
            return PartialView("CreateIssue", givenIssue);
        }

        public ActionResult SaveIssue([FromBody] Issue givenIssue)
        {

            try
            {
                string issueKey = _iDBRepository.SaveIssue(givenIssue);
                return Json(issueKey);
            }
            catch(Exception e)
            {
                return Json(false);
            }
        }

        [HttpPost]
        public ActionResult VerifyIssueNumber([FromBody] Issue givenIssue)
        {
            Issue issue = _iDBRepository.GetIssueByKey(givenIssue.IssueNo);
            if (issue != null)
            {
                return Json(issue.IssueNo);
            }
            else
            {
                return Json(false);
            }
        }

        public ActionResult LoadComments(int issueID)
        {
            return PartialView("Comments", GetIssueComments(issueID));
        }

        private Comments GetIssueComments(int issueID)          
        {
            Comments comments = new Comments();
            comments.AllComments = _iDBRepository.GetAllComments(issueID).ToList();
            return comments;
        }

        public ActionResult AddComment([FromBody] Issue issue)
        {
            try
            {
                _iDBRepository.AddComment(issue.IssueID, issue.CommentText);
                return LoadComments(issue.IssueID);
            }
            catch (Exception e)
            {
                return Json(false);
            }
        }

        public ActionResult GetIssueDetails([FromBody] Issue givenIssue)
        {
            try
            {
                Issue issue = _iDBRepository.GetIssueByKey(givenIssue.IssueNo);
                return CreateIssue(issue);
            }
            catch (Exception e)
            {
                return Json(false);
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
