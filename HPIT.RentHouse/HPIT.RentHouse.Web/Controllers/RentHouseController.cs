using HPIT.RentHouse.Common;
using HPIT.RentHouse.IService.IUIService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HPIT.RentHouse.Web.Controllers
{
    public class RentHouseController : Controller
    {
        #region 依赖注入

        private ICitysUiService _citysUiService;
        private IHouseUiService _houseUiService;

        
        public RentHouseController(ICitysUiService citysUiService, IHouseUiService houseUiService)
        {
            _citysUiService = citysUiService;
            _houseUiService = houseUiService;
        }

        #endregion

        /// <summary>
        /// 主页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(long cityId = 1)
        {
            ViewBag.Citys = _citysUiService.GetCityList();
            ViewBag.cId = _citysUiService.GetCityList().FirstOrDefault().Id;
            if (cityId > 0)
            {
                ViewBag.CityName = _citysUiService.GetCityList().FirstOrDefault(a => a.Id == cityId).Name;
            }
            else
            {
                ViewBag.CityName = _citysUiService.GetCityList().FirstOrDefault().Name;
            }
            return View();
        }

        /// <summary>
        /// 获取房源信息
        /// </summary>
        /// <param name="cityId">城市 Id</param>
        /// <param name="start">页码</param>
        /// <param name="KeyWord">搜索的内容</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetHouseUi(int start, string KeyWord, long cityId = 1)
        {
            // 每次显示 6 行数据
            return Json(_houseUiService.GetHouseUi(cityId, start, 6, KeyWord));
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        public ActionResult GetHouseMessage(long houseId)
        {
            return View();
        }



    }
}