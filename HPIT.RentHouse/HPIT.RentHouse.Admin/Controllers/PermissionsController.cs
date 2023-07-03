using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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
    }
}