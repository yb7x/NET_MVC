using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using CodeCarvings.Piczard.Filters.Watermarks;
using CodeCarvings.Piczard;
using System.IO;

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
        private IHousePicService _housePicService;
        public HouseController(IHouseService houseService, IRegionsService regionsService, ICommunitiesService communitiesService, IAttachmentsService attachmentsService, IIdNameService idNameService, IHousePicService housePicService)
        {
            _houseService = houseService;
            _regionsService = regionsService;
            _communitiesService = communitiesService;
            _attachmentsService = attachmentsService;
            _idNameService = idNameService;
            _housePicService = housePicService;
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

        /// <summary>
        /// 上传图片==视图
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult UploadImg(long id)
        {
            return View();
        }

        /// <summary>
        /// 上传图片==功能
        /// </summary>
        /// <param name="houseId"></param>
        /// <param name="file"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult UploadImg(long houseId, HttpPostedFileBase file)
        {
            //month月，minute
            string md5 = CommonHelper.CalcMD5(file.InputStream);
            string ext = Path.GetExtension(file.FileName);
            // 大图路径
            string path = "/upload/house/" + DateTime.Now.ToString("yyyy/MM/dd") + "/" + md5 + ext;// /upload/2017/07/07/afadsfa.jpg
            // 缩略图地址
            string thumbPath = "/upload/house/" + DateTime.Now.ToString("yyyy/MM/dd") + "/" + md5 + "_thumb" + ext;
            string fullPath = HttpContext.Server.MapPath("~" + path);//d://22/upload/2017/07/07/afadsfa.jpg
            string thumbFullPath = HttpContext.Server.MapPath("~" + thumbPath);
            new FileInfo(fullPath).Directory.Create();//尝试创建可能不存在的文件夹

            file.InputStream.Position = 0;//指针复位
                                          //file.SaveAs(fullPath);//SaveAs("d:/1.jpg");
                                          //缩略图
            ImageProcessingJob jobThumb = new ImageProcessingJob();
            jobThumb.Filters.Add(new FixedResizeConstraint(200, 200));//缩略图尺寸200*200
            jobThumb.SaveProcessedImageToFileSystem(file.InputStream, thumbFullPath);

            file.InputStream.Position = 0;//指针复位

            //水印
            ImageWatermark imgWatermark = new ImageWatermark(HttpContext.Server.MapPath("~/images/watermark.jpg"));
            imgWatermark.ContentAlignment = System.Drawing.ContentAlignment.BottomRight;//水印位置
            imgWatermark.Alpha = 50;//透明度，需要水印图片是背景透明的png图片
            ImageProcessingJob jobNormal = new ImageProcessingJob();
            jobNormal.Filters.Add(imgWatermark);//添加水印
            jobNormal.Filters.Add(new FixedResizeConstraint(600, 600));
            jobNormal.SaveProcessedImageToFileSystem(file.InputStream, fullPath);

            // 图片添加到数据表中
            HousePicDTO dto = new HousePicDTO()
            {
                HouseId = houseId,
                ThumbUrl = thumbPath,
                Url = path
            };
            return Json(_housePicService.AddHousePic(dto));
        }

        /// <summary>
        /// 图片查看
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        public ActionResult LookImg(long houseId)
        {
            return View(_housePicService.GetHousePicList(houseId));
        }

        /// <summary>
        /// 批量删除图片信息
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult LookImg(long[] houseId)
        {
            return Json(_housePicService.DeleteBatch(houseId)); 
        }

    }
}