using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HPIT.RentHouse.Admin.Controllers
{
    public class RolesController : Controller
    {
        #region 依赖注入

        public IRolesService _rolesService;
        public IPermissionsService _permissionsService;

        public RolesController(IRolesService rolesService, IPermissionsService permissionsService)
        {
            _rolesService = rolesService;
            _permissionsService = permissionsService;
        }

        #endregion
        // GET: Roles
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 查询信息并显示
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        public ActionResult GetRolesList(string Name)
        {
            var list = _rolesService.GetRolesList(Name);
            return Json(new { recordsTotal = list.Count, recordsFiltered = list.Count, data = list });
        }

        /// <summary>
        /// 添加视图并显示所有权限信息
        /// </summary>
        /// <returns></returns>
        public ActionResult Add()
        {
            return View(_permissionsService.GetPermissionsList(null));
        }

        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Add(RolesAddDTO dto)
        {
            return Json(_rolesService.RolesAdd(dto));
        }
    }
}