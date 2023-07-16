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
    /// 房屋管理接口
    /// </summary>
    public interface IHouseService : IServiceSupport
    {
        /// <summary>
        /// 所有房屋信息
        /// </summary>
        /// <param name="Community"></param>
        /// <returns></returns>
        List<HouseListDTO> GetListHouse(long TypeId, int start, int length, ref int count, string Community);

        /// <summary>
        /// 删除房屋信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        AjaxResult Delete(long id);

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        AjaxResult DeleteBatch(long[] ids);


        /// <summary>
        /// 添加
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult Add(HouseAddDTO dto);

        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        HouseGetEditDTO GetEdit(long id);

        /// <summary>
        /// 修改功能
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        AjaxResult Edit(HouseEditDTO dto);
    }
}
