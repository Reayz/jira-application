using JiraApplication.Models;
using JiraApplication.Repository;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace JiraApplication.Controllers
{
    [SessionCheck]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IDBRepository _iDBRepository;
        private readonly IConfiguration _configuration;
        private readonly HttpContext _httpContext;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public HomeController(  ILogger<HomeController> logger, 
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
        
        public IActionResult Dashboard()
        {
            Dashboard model = new Dashboard();
            model.Issues = _iDBRepository.GetAllIssues().ToList();
            ViewBag.ProjectName = _iDBRepository.GetProjectName();
            return View(model);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
