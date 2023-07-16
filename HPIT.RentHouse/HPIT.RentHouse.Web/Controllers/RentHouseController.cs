using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HPIT.RentHouse.Web.Controllers
{
    public class RentHouseController : Controller
    {
        /// <summary>
        /// 主页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }
    }
}