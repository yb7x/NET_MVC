using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HPIT.RentHouse.Common;

namespace HPIT.RentHouse.Admin.Controllers
{
    public class HouseController : Controller
    {
        #region 依赖注入

        private IHouseService _houseService;
        public HouseController(IHouseService houseService)
        {
            _houseService = houseService;
        }

        #endregion

        /// <summary>
        /// 房屋信息主页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 房屋信息查询
        /// </summary>
        /// <param name="start"></param>
        /// <param name="length"></param>
        /// <param name="count"></param>
        /// <param name="Community"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetHouseList(int start, int length, string Community)
        {
            int count = 0;
            var model = _houseService.GetListHouse(start, length, ref count, Community);
            return Json(new { recordsTotal = count, recordsFiltered = count, data = model });
        }
    }
}