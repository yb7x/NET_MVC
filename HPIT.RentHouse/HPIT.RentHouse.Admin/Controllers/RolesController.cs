using HPIT.RentHouse.Admin.Filters;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using System.Web.Mvc;

namespace HPIT.RentHouse.Admin.Controllers
{
    [Authorize, CheckPermisson("rolesAdmin")]
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
        /// <summary>
        /// 主页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 查询信息并显示
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        public ActionResult GetRolesList(int start, int length, string Name)
        {
            int count = 0;
            var list = _rolesService.GetRolesList(start, length, ref count, Name);
            return Json(new { recordsTotal = count, recordsFiltered = count, data = list });
        }

        /// <summary>
        /// 添加视图并显示所有权限信息
        /// </summary>
        /// <returns></returns>
        public ActionResult Add()
        {
            return View(_permissionsService.GetPermissionsList());
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

        /// <summary>
        /// 修改页面，显示要修改的信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(long id)
        {
            return View(_rolesService.RolesGetEdit(id));
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Edit(RolesEditDTO dto)
        {
            return Json(_rolesService.RolesEdit(dto));
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(long id)
        {
            return Json(_rolesService.RolesDelete(id));
        }


        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public ActionResult DeleteBatch(long[] ids)
        {
            return Json(_rolesService.RolesDelete(ids));
        }
    }
}