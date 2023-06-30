using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HPIT.RentHouse.DTO;

namespace HPIT.RentHouse.IService
{
    public interface IAdminUsersService : IServiceSupport
    {
        /// <summary>
        /// 查询所有管理员信息
        /// </summary>
        /// <returns></returns>
        List<AdminListDTO> GetAdminList();

        /// <summary>
        /// 管理员登陆
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        bool AdminLogin(AdminLoginDTO dto);
    }
}
