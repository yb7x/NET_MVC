using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;

namespace HPIT.RentHouse.Admin.Controllers
{
    [Authorize]
    public class HouseController : Controller
    {
        #region 依赖注入

        private IHouseService _houseService;
        private ICommunitiesService _communitiesService;
        private IRegionsService _regionsService;
        private IAttachmentsService _attachmentsService;
        public HouseController(IHouseService houseService, IRegionsService regionsService, ICommunitiesService communitiesService, IAttachmentsService attachmentsService)
        {
            _houseService = houseService;
            _regionsService = regionsService;
            _communitiesService = communitiesService;
            _attachmentsService = attachmentsService;
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

        /// <summary>
        /// 区域下拉框
        /// </summary>
        /// <returns></returns>
        public void RegionsDDL()
        {
            var user = User as MyFormsPrincipal<AdminLoginDataDTO>;
            long cityId = (long)user.userData.CityId;
            ViewBag.RegionsDDL = _regionsService.GetRegions(cityId).Select(a => new SelectListItem()
            {
                Value = a.Id.ToString(),
                Text = a.Name
            }).ToList();
        }

        /// <summary>
        /// 根据区域获取小区
        /// </summary>
        /// <param name="RegionId"></param>
        /// <returns></returns>
        public ActionResult GetCommunities(long RegionId)
        {
            return Json(_communitiesService.GetCommunities(RegionId));
        }

        /// <summary>
        /// 删除房源信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(long id)
        {
            return Json(_houseService.Delete(id));
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public ActionResult DeleteBatch(long[] ids)
        {
            return Json(_houseService.DeleteBatch(ids));
        }

        /// <summary>
        /// 添加页面
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public ActionResult Add()
        {
            RegionsDDL(); // 区域信息
            return View(_attachmentsService.GetAttachmentsList());
        }
    }
}