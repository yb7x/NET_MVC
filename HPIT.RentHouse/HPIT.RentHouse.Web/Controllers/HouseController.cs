using HPIT.RentHouse.Common;
using HPIT.RentHouse.IService.IUIService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HPIT.RentHouse.Web.Controllers
{
    public class HouseController : Controller
    {
        #region 依赖注入

        private IHouseUiService _houseUiService;
        public HouseController(IHouseUiService houseUiService)
        {
            _houseUiService = houseUiService;
        }

        #endregion

        /// <summary>
        /// 查看房间具体信息==视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(long houseId)
        {
            ViewBag.ServerIP = CommonHelper.GetServerIP();
            return View(_houseUiService.GetHouseMessage(houseId));
        }
    }
}