using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    /// <summary>
    /// 用户管理接口
    /// </summary>
    public interface IUserAdminService:IServiceSupport
    {
        /// <summary>
        /// 列表显示
        /// </summary>
        /// <returns></returns>
        List<UserAdminListDTO> GetList(int start, int length, ref int count, string Name);



        /// <summary>
        /// 添加管理员用户
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult Add(UserAdminAddDTO dto);

        /// <summary>
        /// 修改管理员用户=查询信息
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        UserAdminGetEditDTO GetEdit(long id);

        /// <summary>
        /// 修改管理员用户==修改
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult Edit(UserAdminEditDTO dto);

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        AjaxResult Delete(long id);

        /// <summary>
        /// 多个删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        AjaxResult DeleteBatch(long[] ids);
    }
}
