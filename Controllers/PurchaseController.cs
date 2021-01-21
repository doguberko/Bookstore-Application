using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LibrarySystem.Models.ENTITY;

namespace LibrarySystem.Controllers
{
    public class PurchaseController : Controller
    {
        LibraryManagementSystemEntities3 db = new LibraryManagementSystemEntities3();
        // GET: Purchase
        public ActionResult Index()
        {
            var values = db.PURCHASE.ToList();
            return View(values);

        }
        [HttpGet]
        public ActionResult SellBook()
        {
            List<SelectListItem> bookid = (from i in db.BOOK.ToList()
                                           select new SelectListItem
                                           {
                                               Text = i.Book_Name,
                                               Value = i.Book_ID.ToString()
                                           }).ToList();
            ViewBag.book_id = bookid;

            List<SelectListItem> userid = (from i in db.USERS.ToList()
                                           select new SelectListItem
                                           {
                                               Text = i.User_Name + ' ' + i.User_Lastname,
                                               Value = i.User_ID.ToString()
                                           }).ToList();
            ViewBag.user_id = userid;
            return View();
        }
        [HttpPost]
        public ActionResult SellBook(PURCHASE p)
        {
            var bookidd = db.BOOK.Where(ba => ba.Book_ID == p.BOOK.Book_ID).FirstOrDefault();
            var useridd = db.USERS.Where(bk => bk.User_ID == p.USERS.User_ID).FirstOrDefault();

            p.BOOK = bookidd;
            p.USERS = useridd;
            db.PURCHASE.Add(p);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult DeletePurchase(int id)
        {
            var purc = db.PURCHASE.Find(id);
            db.PURCHASE.Remove(purc);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}