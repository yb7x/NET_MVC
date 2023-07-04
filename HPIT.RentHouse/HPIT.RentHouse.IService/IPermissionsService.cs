using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HPIT.RentHouse.Common;

namespace HPIT.RentHouse.IService
{
    public interface IPermissionsService:IServiceSupport
    {
        /// <summary>
        /// 查询权限
        /// </summary>
        /// <returns></returns>
        List<PermissionsDTO> GetPermissionsList(string Description);

        /// <summary>
        /// 添加权限
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult AddPermissions(PermissionsDTO dto);

        /// <summary>
        /// 修改权限
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns></returns>
        PermissionsDTO EditGetPermissions(long id);
    }
}
