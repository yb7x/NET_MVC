using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    public interface IPermissionsService:IServiceSupport
    {
        /// <summary>
        /// 查询权限
        /// </summary>
        /// <returns></returns>
        List<PermissionsDTO> GetPermissionsList(string Description);
    }
}
