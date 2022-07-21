using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Newtonsoft.Json;


namespace JiraApplication.Models
{
    public class SessionCheckAttribute : TypeFilterAttribute
    {
        public SessionCheckAttribute(bool ignore = false) : base(typeof(SessionCheck))
        {
            Arguments = new object[] { ignore };
        }
    }

    public class SessionCheck : IAuthorizationFilter
    {
        private readonly bool _ignore;
        public SessionCheck(bool ignore = false)
        {
            _ignore = ignore;
        }

        public void OnAuthorization(AuthorizationFilterContext filterContext)
        {
            if (_ignore)
            {
                return;
            }

            var session = filterContext.HttpContext.Session;
            bool isAjax = (filterContext.HttpContext.Request.Headers["X-Requested-With"] == "XMLHttpRequest");
            if (isAjax)
            {
                if (session.GetString("IsAuthenticated") == null || session.GetString("IsAuthenticated") != "True")
                {
                    var resObj = new
                    {
                        success = false,
                        error = "TIMEOUT"
                    };

                    filterContext.Result = new JsonResult(JsonConvert.SerializeObject(resObj, Formatting.Indented));
                }
            }
            else
            {
                if (session.GetString("IsAuthenticated") == null || session.GetString("IsAuthenticated") != "True")
                {
                    RouteValueDictionary redirectTargetDictionary = new RouteValueDictionary();
                    redirectTargetDictionary.Add("action", "Unauthorized");
                    redirectTargetDictionary.Add("controller", "Login");
                    filterContext.Result = new RedirectToRouteResult(redirectTargetDictionary);
                }
            }
        }
    }
}
