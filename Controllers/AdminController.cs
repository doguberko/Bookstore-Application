using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LibrarySystem.Models.ENTITY;

namespace LibrarySystem.Controllers
{
    
    public class AdminController : Controller
    {
        // GET: Admin
        LibraryManagementSystemEntities3 db = new LibraryManagementSystemEntities3();
        public ActionResult Index()
        {
            var values = db.ADMIN.ToList();

            return View(values);
        }
        [HttpGet]
        public ActionResult AddAdmin()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddAdmin(ADMIN a)
        {
            if (!ModelState.IsValid)
            {
                return View(AddAdmin());
            }
            db.ADMIN.Add(a);
            db.SaveChanges();
            return RedirectToAction("Index");

        }
        public ActionResult DeleteAdmin(int id)
        {
            var ad = db.ADMIN.Find(id);
            db.ADMIN.Remove(ad);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult GetAdmin(int id)
        {
            var ad = db.ADMIN.Find(id);
            return View("GetAdmin", ad);

        }

        public ActionResult UpdateAdmin(ADMIN p)
        {
            var ad = db.ADMIN.Find(p.Admin_ID);
            ad.Admin_ID = p.Admin_ID;
            ad.Admin_Name = p.Admin_Name;
            ad.Admin_Lastname = p.Admin_Lastname;
            db.SaveChanges();
            return RedirectToAction("Index");

        }
    }   
}