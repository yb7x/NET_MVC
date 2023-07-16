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
        private IIdNameService _idNameService;
        public HouseController(IHouseService houseService, IRegionsService regionsService, ICommunitiesService communitiesService, IAttachmentsService attachmentsService, IIdNameService idNameService)
        {
            _houseService = houseService;
            _regionsService = regionsService;
            _communitiesService = communitiesService;
            _attachmentsService = attachmentsService;
            _idNameService = idNameService;
        }

        #endregion

        /// <summary>
        /// 房屋信息主页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(long TypeId = 0)
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
        public ActionResult GetHouseList(long TypeId, int start, int length, string Community)
        {
            int count = 0;
            var model = _houseService.GetListHouse(TypeId, start, length, ref count, Community);
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
        /// 房源信息
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public ActionResult DeleteBatch(long[] ids)
        {
            return Json(_houseService.DeleteBatch(ids));
        }

        /// <summary>
        /// 房屋信息（户型、房屋状态、房屋类型、装修类型）
        /// </summary>
        /// <param name="typeName"></param>
        /// <returns></returns>
        public List<SelectListItem> IsName(EnumTypeName.TypeName typeName)
        {
            return _idNameService.GetIdName(typeName).Select(a => new SelectListItem()
            {
                Value = a.Id.ToString(),
                Text = a.Name
            }).ToList();
        }

        /// <summary>
        /// 添加页面显示
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [ValidateInput(false)]
        public ActionResult Add()
        {
            RegionsDDL(); // 区域信息
            ViewBag.RoomTypeId = IsName(EnumTypeName.TypeName.户型);
            ViewBag.StatusId = IsName(EnumTypeName.TypeName.房屋状态);
            ViewBag.TypeId = IsName(EnumTypeName.TypeName.房屋类型);
            ViewBag.DecorateStatusId = IsName(EnumTypeName.TypeName.装修状态);
            return View(_attachmentsService.GetAttachmentsList());
        }

        /// <summary>
        /// 添加功能
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        // 标记可以识别 HTML 标记，为了能使用富文本
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Add(HouseAddDTO dto)
        {
            return Json(_houseService.Add(dto));
        }

        /// <summary>
        /// 修改页面
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [ValidateInput(false)]
        public ActionResult Edit(long id)
        {
            RegionsDDL();
            ViewBag.RoomTypeIds = IsName(EnumTypeName.TypeName.户型);
            ViewBag.StatusIds = IsName(EnumTypeName.TypeName.房屋状态);
            ViewBag.TypeIds = IsName(EnumTypeName.TypeName.房屋类型);
            ViewBag.DecorateStatusIds = IsName(EnumTypeName.TypeName.装修状态);
            return View(_houseService.GetEdit(id));
        }

        /// <summary>
        /// 修改功能
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [ValidateInput(false), HttpPost]
        public ActionResult Edit(HouseEditDTO dto)
        {
            return Json(_houseService.Edit(dto));
        }
    }
}