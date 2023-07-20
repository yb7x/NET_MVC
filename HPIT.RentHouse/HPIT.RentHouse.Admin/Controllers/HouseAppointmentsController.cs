using HPIT.RentHouse.Admin.Filters;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService.IUIService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HPIT.RentHouse.Admin.Controllers
{
    [Authorize]
    public class HouseAppointmentsController : Controller
    {
        #region 依赖注入

        private IHouseUiAppointmentsService _houseUiAppointmentsService;
        public HouseAppointmentsController(IHouseUiAppointmentsService houseUiAppointmentsService)
        {
            _houseUiAppointmentsService = houseUiAppointmentsService;
        }

        #endregion

        /// <summary>
        /// 预约看房管理
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 预约看房 列表显示
        /// </summary>
        /// <param name="start"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult HouseAppointmentsList(int start, int length)
        {
            int count = 0;
            var list = _houseUiAppointmentsService.HouseAppointmentsList(start, length, ref count);
            return Json(new { recordsTotal = count, recordsFiltered = count, data = list });
        }

        /// <summary>
        /// 抢单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Follow(long id)
        {
            var user = User as MyFormsPrincipal<AdminLoginDataDTO>;
            return Json(_houseUiAppointmentsService.Follow(id, user.userData.Id));
        }

    }
}