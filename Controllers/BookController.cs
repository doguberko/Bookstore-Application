using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LibrarySystem.Models.ENTITY;

namespace LibrarySystem.Controllers
{
    public class BookController : Controller
    {
        LibraryManagementSystemEntities3 db = new LibraryManagementSystemEntities3();
        // GET: Book
        public ActionResult Index(string p)
        {

            var books = from b in db.BOOK select b;
            if (!string.IsNullOrEmpty(p))
            {
                books = books.Where(x => x.Book_Name.Contains(p));
            }
           // var books = db.BOOK.ToList();

            return View(books.ToList());
        }
        [HttpGet]
        public ActionResult AddBook()
        {
            List<SelectListItem> bookcatg = (from i in db.CATEGORY.ToList()
                                           select new SelectListItem
                                           {
                                               Text = i.Category_Name,
                                               Value = i.Category_ID.ToString()
                                           }).ToList();
            ViewBag.book_catg = bookcatg;

            List<SelectListItem> bookaut = (from i in db.AUTHORS.ToList()
                                            select new SelectListItem
                                            {
                                                Text = i.Author_Name + ' ' + i.Author_Lastname,
                                                Value = i.Author_ID.ToString()
                                            }).ToList();
            ViewBag.book_aut = bookaut;
            return View();
        }
        [HttpPost]
        public ActionResult AddBook(BOOK b)
        {
            var bookct = db.CATEGORY.Where(bk => bk.Category_ID == b.CATEGORY.Category_ID).FirstOrDefault();
            var bookau = db.AUTHORS.Where(ba => ba.Author_ID == b.AUTHORS.Author_ID).FirstOrDefault();
            b.CATEGORY = bookct;
            b.AUTHORS = bookau;
            db.BOOK.Add(b);
            db.SaveChanges();
            return RedirectToAction("Index");
            
        }
        public ActionResult DeleteBook(int id)
        {
            var book = db.BOOK.Find(id);
            db.BOOK.Remove(book);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult GetBook(int id)
        {
            var bk = db.BOOK.Find(id);
            List<SelectListItem> bookcatg = (from i in db.CATEGORY.ToList()
                                             select new SelectListItem
                                             {
                                                 Text = i.Category_Name,
                                                 Value = i.Category_ID.ToString()
                                             }).ToList();
            ViewBag.book_catg = bookcatg;

            List<SelectListItem> bookaut = (from i in db.AUTHORS.ToList()
                                            select new SelectListItem
                                            {
                                                Text = i.Author_Name + ' ' + i.Author_Lastname,
                                                Value = i.Author_ID.ToString()
                                            }).ToList();
            ViewBag.book_aut = bookaut;
            return View("GetBook", bk);

        }

        public ActionResult UpdateBook(BOOK b)
        {
            var book = db.BOOK.Find(b.Book_ID);
            book.Book_Name = b.Book_Name;
            book.Book_Page = b.Book_Page;
            book.Book_Publisher = b.Book_Publisher;
            book.Book_Year = b.Book_Year;
            book.Book_Price = b.Book_Price;
            var bctg = db.CATEGORY.Where(ct => ct.Category_ID == b.CATEGORY.Category_ID).FirstOrDefault();
            var baut = db.AUTHORS.Where(au => au.Author_ID == b.AUTHORS.Author_ID).FirstOrDefault();
            book.CATEGORY = bctg;
            book.AUTHORS=baut;
            db.SaveChanges();
            return RedirectToAction("Index");


        }

    }
}