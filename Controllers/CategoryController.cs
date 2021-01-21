using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LibrarySystem.Models.ENTITY;
namespace LibrarySystem.Controllers
{
    public class CategoryController : Controller
    {
        LibraryManagementSystemEntities3 db = new LibraryManagementSystemEntities3();
        // GET: Category
        public ActionResult Index()
        {

            var values = db.CATEGORY.ToList();

            return View(values);
        }
        [HttpGet]
        public ActionResult AddCategory()
        {
            return View();
        }
        public ActionResult AddCategory(CATEGORY ct)
        {
            db.CATEGORY.Add(ct);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult DeleteCategory(int id)
        {
            var aut = db.CATEGORY.Find(id);
            db.CATEGORY.Remove(aut);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}