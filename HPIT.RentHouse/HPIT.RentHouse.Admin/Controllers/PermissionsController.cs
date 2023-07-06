using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HPIT.RentHouse.Common;

namespace HPIT.RentHouse.Admin.Controllers
{
    public class PermissionsController : Controller
    {
        #region 依赖注入

        private IPermissionsService _permissionsService;

        public PermissionsController(IPermissionsService permissionsService)
        {
            _permissionsService = permissionsService;
        }

        #endregion
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// 查询所有数据显示
        /// </summary>
        /// <param name="Description"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetPermissionsList(string Description)
        {
            List<PermissionsDTO> List =  _permissionsService.GetPermissionsList(Description);
            return Json(new { recordsTotal = List.Count, recordsFiltered  = List.Count, data = List});
        }

        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(PermissionsDTO dto)
        {
            // 返回AjaxResult类型
            return Json(_permissionsService.AddPermissions(dto));
        }

        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id">Id</param>
        /// <returns></returns>
        public ActionResult Edit(long id)
        {
            return View(_permissionsService.EditGetPermissions(id));
        }

        /// <summary>
        /// 查询后修改
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Edit(PermissionsDTO dto)
        {
            // 使用接口调用修改方法
            return Json(_permissionsService.EditPermissions(dto));
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Delete(long id)
        {
            // 使用接口调用修改方法
            return Json(_permissionsService.DeletePermissions(id));
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="b">数组</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteBatch(long[] b)
        {
            return Json(_permissionsService.DeleteBatchPermissions(b));
        }
    }
}