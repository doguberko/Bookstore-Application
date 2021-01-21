using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LibrarySystem.Models.ENTITY;
using System.Web.Security;

namespace LibrarySystem.Controllers
{
    public class LoginController : Controller
    {
        LibraryManagementSystemEntities3 db = new LibraryManagementSystemEntities3();
        // GET: Login
        public ActionResult Log()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Log(ADMIN a)
        {
            var login = db.ADMIN.FirstOrDefault(x => x.Admin_Mail == a.Admin_Mail && x.Admin_Pass == a.Admin_Pass);
            if (login != null)
            {
                FormsAuthentication.SetAuthCookie(login.Admin_Mail, false);
                return RedirectToAction("Index", "Homepage");
            }
            else { return View(); }
            
        }
    }
}