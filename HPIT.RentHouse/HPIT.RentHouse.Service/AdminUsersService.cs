using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service.Entities;
using HPIT.RentHouse.Common;

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
