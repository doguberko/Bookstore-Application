using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LibrarySystem.Models.ENTITY;

namespace LibrarySystem.Controllers
{
    public class AuthorController : Controller
    {
        LibraryManagementSystemEntities3 db = new LibraryManagementSystemEntities3();

        // GET: Author
        public ActionResult Index()
        {
            var values = db.AUTHORS.ToList();
            return View(values);
        }

        [HttpGet]
        public ActionResult AddAuthor()
        {
            return View();
        }
        public ActionResult AddAuthor(AUTHORS aut)
        {
            db.AUTHORS.Add(aut);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult DeleteAuthor(int id)
        {
            var aut = db.AUTHORS.Find(id);
            db.AUTHORS.Remove(aut);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult GetAuthor(int id)
        {
            var aut = db.AUTHORS.Find(id);
            return View("GetAuthor", aut);

        }

        public ActionResult UpdateAuthor(AUTHORS p)
        {
            var aut = db.AUTHORS.Find(p.Author_ID);
            aut.Author_Name = p.Author_Name;
            aut.Author_Lastname = p.Author_Lastname;
            db.SaveChanges();
            return RedirectToAction("Index");

        }
    }
}