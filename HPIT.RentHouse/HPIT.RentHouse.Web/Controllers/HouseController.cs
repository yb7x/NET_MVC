using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO.UIDTO;
using HPIT.RentHouse.IService;
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
        private IRegionsService _regionsService;
        private ICitysService _citysService;
        public HouseController(IHouseUiService houseUiService, IRegionsService regionsService, ICitysService citysService)
        {
            _houseUiService = houseUiService;
            _regionsService = regionsService;
            _citysService = citysService;
        }

        #endregion

        /// <summary>
        /// 查看房间具体信息 == 视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(long houseId)
        {
            ViewBag.ServerIP = CommonHelper.GetServerIP(); // 获取地址
            return View(_houseUiService.GetHouseMessage(houseId));
        }


        /// <summary>
        /// 房源搜索 == 视图
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public ActionResult Search(HouseUiSearchDTO dto)
        {
            ViewBag.ServerIP = CommonHelper.GetServerIP(); // 获取地址
            // 保存城市Id
            var citys = _citysService.GetCityList();
            if (dto.CityId > 0)
            {
                // 转换类型
                ViewBag.Regin = _regionsService.GetRegions(Convert.ToInt32(dto.CityId));
                ViewBag.CityName = citys.FirstOrDefault(a => a.Id == dto.CityId).Name;
            }
            else
            {
                // 给 cityId 一个默认值
                ViewBag.Regin = _regionsService.GetRegions(citys.FirstOrDefault(a => a.Id == 1).Id);
                ViewBag.CityName = citys.FirstOrDefault(a => a.Id == 1).Name;
                // dto.cityId 赋予初始值
                dto.CityId = citys.FirstOrDefault(a => a.Id == 1).Id;
            }

            // 月租金
            if (!string.IsNullOrWhiteSpace(dto.MouthRent))
            {
                string[] str = dto.MouthRent.Split('-');
                // 小值
                if (str[0] != "*")
                {
                    dto.StartMouthRent = Convert.ToInt32(str[0]);
                }
                // 大值
                if (str[1] != "*")
                {
                    dto.EndMouthRent = Convert.ToInt32(str[1]);
                }
            }

            var list = _houseUiService.Search(dto);
            return View(list);
        }
    }
}