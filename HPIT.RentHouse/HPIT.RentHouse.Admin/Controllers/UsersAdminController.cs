using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HPIT.RentHouse.Admin.Controllers
{
    public class UsersAdminController : Controller
    {
        #region 依赖注入

        private IUserAdminService _userAdminService;
        private ICitysService _citysService; // 城市信息
        private IRolesService _rolesService; // 角色信息

        public UsersAdminController(IUserAdminService userAdminService, ICitysService citysService, IRolesService rolesService)
        {
            _userAdminService = userAdminService;
            _citysService = citysService;
            _rolesService = rolesService;
        }

        #endregion

        /// <summary>
        /// 主页面视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 列表显示带查询
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        public ActionResult GetList(int start, int length, string Name)
        {
            int count = 0;
            var list = _userAdminService.GetList(start, length, ref count, Name);
            return Json(new { recordsTotal = list.Count, recordsFiltered = list.Count, data = list });
        }

        /// <summary>
        /// 城市信息下拉框
        /// </summary>
        public void GetDdl()
        {
            ViewBag.DDL = _citysService.GetCityList().Select(a => new SelectListItem()
            {
                Value = a.Id.ToString(),
                Text = a.Name,
            }).ToList();
        }

        /// <summary>
        /// 添加视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Add()
        {
            GetDdl();
            // 角色信息返回给前台
            return View(_rolesService.GetRolesList());
        }

        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Add(UserAdminAddDTO dto)
        {
            if (ModelState.IsValid)
            {
                // 验证成功
                return Json(_userAdminService.Add(dto));
            }
            else
            {
                // 验证失败则报错
                return Json(new AjaxResult(ResultState.Error, MVCHelper.GetValidMsg(ModelState)));
            }
        }

        /// <summary>
        /// 修改==查询信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(long id)
        {
            GetDdl();
            return View(_userAdminService.GetEdit(id));
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Edit(UserAdminEditDTO dto)
        {
            GetDdl();
            return Json(_userAdminService.Edit(dto));
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Delete(long id)
        {
            return Json(_userAdminService.Delete(id));
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteBatch(long[] ids)
        {
            return Json(_userAdminService.DeleteBatch(ids));
        }
    }
}