using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service.Entities;
using HPIT.RentHouse.Common;
using Newtonsoft.Json;
using System.Web.Security;
using System.Web;

namespace HPIT.RentHouse.Service
{
    public class AdminUsersService : IAdminUsersService
    {
        /// <summary>
        /// 登录密码验证
        /// </summary>
        /// <param name="dto">用户输入的账户密码</param>
        /// <returns>true false</returns>
        public bool AdminLogin(AdminLoginDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                var model = bs.Get(a => a.PhoneNum == dto.PhoneNum);
                if (model != null)
                {
                    // 验证密码
                    // 用户输入的密码加盐加密后再对比表中数据
                    // 使用 Common 中的 CalcMD5()方法对输入的数据进行 MD5加密加盐 后对比表中加密加盐的数据
                    if (CommonHelper.CalcMD5(dto.Password + model.PasswordSalt) == model.PasswordHash)
                    {
                        // 添加 Cook 信息
                        var role = model.T_Roles.FirstOrDefault();
                        AdminLoginDataDTO dataDto = new AdminLoginDataDTO()
                        {
                            Email = model.Email,
                            Id = model.Id,
                            Name = model.Name,
                            RoleName = role.Name,
                            PhoneNum = model.PhoneNum,
                        };
                        // 把数据加密储存在 cookie 中
                        SaveUserData(dataDto, dto.IsRemember);

                        // 成功
                        return true;
                    }
                    else
                    {
                        // 失败
                        return false;
                    }
                }
                else
                {
                    // 失败
                    return false;
                }
            }
        }

        /// <summary>
        /// 用户数据保存到Cookie中，用于Forms身份验证和授权
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <param name="isRemember">是否长时间验证</param>
        public void SaveUserData(AdminLoginDataDTO dto, bool isRemember)
        {
            // 把用户数据转化为  JSON 格式
            string userData = JsonConvert.SerializeObject(dto);
            FormsAuthenticationTicket tickt = new FormsAuthenticationTicket(2, "LoginName", DateTime.Now, DateTime.Now.AddDays(1), false, userData);
            // 加密
            string cookieEncrypt = FormsAuthentication.Encrypt(tickt);
            // 创建 cookie
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, cookieEncrypt);
            cookie.Path = FormsAuthentication.FormsCookiePath;
            // 设置 cookie 是否为长时间验证
            if (isRemember)
            {
                cookie.Expires = DateTime.Now.AddHours(6);
            }
            // 获取当前上下文对象来保存 cookies
            HttpContext context = HttpContext.Current;
            // 把现有的储存的 cookie 移除
            context.Response.Cookies.Remove(FormsAuthentication.FormsCookieName);
            // 响应到客户端
            context.Response.Cookies.Add(cookie);
        }

        /// <summary>
        /// 查询所有管理员信息
        /// </summary>
        /// <returns>实体对象（Id、Name、PhoneNum、Email）</returns>
        public List<AdminListDTO> GetAdminList()
        {
            // 创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                List<AdminListDTO> list = bs.GetList(a => true).Select(a => new AdminListDTO()
                {
                    Name = a.Name,
                    Email = a.Email,
                    PhoneNum = a.PhoneNum,
                    Id = a.Id
                }).ToList();
                return list;
            }
        }
    }
}
