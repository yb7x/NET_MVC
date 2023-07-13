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
        /// 显示列表数据（这个带分页带查询）
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        List<RolesListDTO> GetRolesList(int start, int length, ref int count, string Name);

        /// <summary>
        /// 查询所有的 Roles 信息
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        List<RolesListDTO> GetRolesList();

        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult RolesAdd(RolesAddDTO dto);

        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        GetRolesEditDTO RolesGetEdit(long id);

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult RolesEdit(RolesEditDTO dto);

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        AjaxResult RolesDelete(long id);

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        AjaxResult RolesDelete(long[] ids);
    }
}
