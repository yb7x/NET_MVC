using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    public interface IRolesService : IServiceSupport
    {
        /// <summary>
        /// 显示列表数据，附加搜索
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        List<RolesListDTO> GetRolesList(string Name);

        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult RolesAdd(RolesAddDTO dto);
    }
}
