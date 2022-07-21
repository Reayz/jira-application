using JiraApplication.Models;
using JiraApplication.Repository;
using Microsoft.AspNetCore.Mvc;

namespace JiraApplication.Controllers
{
    public class LoginController : Controller
    {
        private readonly IDBRepository _iDBRepository;
        private readonly IConfiguration _configuration;
        private readonly HttpContext _httpContext;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public LoginController( IDBRepository iDBRepository, 
                                IConfiguration configuration,
                                IHttpContextAccessor httpContextAccessor)
        {
            _iDBRepository = iDBRepository;
            _httpContextAccessor = httpContextAccessor;
            _httpContext = httpContextAccessor.HttpContext;
            _configuration = configuration;
        }

        public ActionResult Login()
        {
            return View();
        }

        public ActionResult LogOut()
        {
            _httpContext.Session.SetString("IsAuthenticated", "");
            _httpContext.Session.SetString("CurrentUserName", "");
            _httpContext.Session.SetInt32("CurrentUserID", 0);
            _httpContext.Session.SetInt32("CurrentTenantID", 0);
            _httpContext.Session.SetInt32("CurrentUserProjectID", 0);
            return RedirectToAction("Login", "Login");
        }

        [HttpPost]
        public ActionResult VerifyUser([FromBody] AppCredential userData)
        {
            AppCredential model = _iDBRepository.GetUserInfo(userData.UserName, userData.Password);
            if (model != null)
            {
                _httpContext.Session.SetString("IsAuthenticated", "True");
                _httpContext.Session.SetString("CurrentUserName", model.UserName);
                _httpContext.Session.SetInt32("CurrentUserID", model.UserID);
                _httpContext.Session.SetInt32("CurrentTenantID", model.TenantID);
                return Json(true);
            }
            else
            {
                return Json(false);
            }
        }

        public ActionResult Unauthorized()
        {
            return View();
        }
    }
}
