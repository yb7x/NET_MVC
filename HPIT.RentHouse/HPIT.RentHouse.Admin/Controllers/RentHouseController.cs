using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime;
using System.Web;
using System.Web.Mvc;
using CaptchaGen;
using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service;


namespace HPIT.RentHouse.Admin.Controllers
{
    public class RentHouseController : Controller
    {
        #region 依赖注入使用

        private IAdminUsersService _adminUsersService;
        public RentHouseController(IAdminUsersService adminUsersService)
        {
            _adminUsersService = adminUsersService;
        }

        #endregion
        
        /// <summary>
        /// 登录视图
        /// </summary>
        /// <returns></returns>
        public ActionResult Login()
        {
            return View();
        }

        /// <summary>
        /// 登录功能
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Login(AdminLoginDTO dto)
        {
            // 实体验证
            if (ModelState.IsValid)
            {
                // 验证验证码
                // 都转化为小写
                if (dto.VerCode.ToString().ToLower() == Session["code"].ToString().ToLower())
                {
                    // 判断手机号、密码验证是否通过
                    if (_adminUsersService.AdminLogin(dto))
                    {

                        return Json(new AjaxResult(ResultState.Success, "登陆成功"));
                    }
                    else
                    {
                        return Json(new AjaxResult(ResultState.Error, "手机号或密码输入有误输入有误"));
                    }
                }
                else
                {
                    // 验证失败
                    return Json(new AjaxResult(ResultState.Error, "验证码输入有误"));
                }
            }
            else
            {
                // 登陆失败
                return Json(new AjaxResult(ResultState.Error, MVCHelper.GetValidMsg(ModelState)));
            }
        }

        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 验证码随机生成
        /// </summary>
        /// <returns>图片文件类型</returns>
        public ActionResult Getvc()
        {
            // 1、生成图像 包含四个字符串类型(在CommonHelper中找到随机生成数的方法)
            string code = CommonHelper.CreateVerifyCode(4);
            // 保存信息 到 Session 以便验证验证码
            Session["code"] = code;
            // 2、图文文件流
            MemoryStream fs = ImageFactory.GenerateImage(code, 40, 80, 16, 8);
            // 3、输出图片类型文件
            return File(fs, "image/jpeg");
        }
    }
}