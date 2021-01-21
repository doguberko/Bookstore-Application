using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LibrarySystem.Models.ENTITY;

namespace LibrarySystem.Controllers
{
    public class UserController : Controller
    {
        LibraryManagementSystemEntities3 db = new LibraryManagementSystemEntities3();
        // GET: User
        public ActionResult Index()
        {
            var values = db.USERS.ToList();

            return View(values);
            
        }

        [HttpGet]
        public ActionResult AddUser()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddUser(USERS a)
        {
            if (!ModelState.IsValid)
            {
                return View(AddUser());
            }
            db.USERS.Add(a);
            db.SaveChanges();
            return RedirectToAction("Index");

        }
        public ActionResult DeleteUser(int id)
        {
            var ad = db.USERS.Find(id);
            db.USERS.Remove(ad);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult GetUser(int id)
        {
            var ad = db.USERS.Find(id);
            return View("GetUser", ad);

        }

        public ActionResult UpdateUser(USERS p)
        {
            var ad = db.USERS.Find(p.User_ID);
            ad.User_ID = p.User_ID;
            ad.User_Name = p.User_Name;
            ad.User_Lastname = p.User_Lastname;
            ad.User_Nickname = p.User_Nickname;
            ad.User_Mail = p.User_Mail;
            ad.User_Password = p.User_Password;
            ad.User_Phone = p.User_Phone;
            
            db.SaveChanges();
            return RedirectToAction("Index");

        }
    }
}