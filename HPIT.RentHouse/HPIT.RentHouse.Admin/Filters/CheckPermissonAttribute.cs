using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace HPIT.RentHouse.Admin.Filters
{
    /// <summary>
    /// 权限管理特性
    /// </summary>
    public class CheckPermissonAttribute : AuthorizeAttribute
    {
        private string permissionName { get; set; }
        
        public CheckPermissonAttribute(string _permissionName)
        {
            permissionName = _permissionName;
        }
        // 重写父类中的方法
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            // 获取当前用户
            var user = filterContext.HttpContext.User as MyFormsPrincipal<AdminLoginDataDTO>;
            // 获取当前用户编号
            long userId = user.userData.Id;
            // 创建一次性依赖注入
            IPermissionsService _permission = DependencyResolver.Current.GetService<IPermissionsService>();
            // 接口调用方法，根据当前用户 Id 查询当前所有的权限
            List<PermissionsDTO> list = _permission.GetPermissionsList(userId);
            // 判断当前用户的是否有这个权限（页面特性给的权限与查询到的当前用户的权限进行对比，注意只能找到第一个角色，因为上面调用的方法只找到第一个角色的所有权限）
            if (!list.Any(a => a.Name == permissionName))
            {
                // 没有权限返回信息
                string Message = $"{user.userData.Name}没有【{permissionName}】的权限!";
                // 判断当前请求是 AJAX 还是 页面显示
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    // AJAX 返回AjaxResult 信息 AJAX
                    filterContext.Result = new JsonResult() { Data = new AjaxResult(ResultState.Error, Message) };
                }
                else
                {
                    // 返回文本信息
                    filterContext.Result = new ContentResult() { Content = Message };
                }
            }
        }
    }
}