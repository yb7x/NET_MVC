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
    /// 房源图片
    /// </summary>
    public interface IHousePicService : IServiceSupport
    {
        /// <summary>
        /// 上传房源图片
        /// </summary>
        /// <returns></returns>
        AjaxResult AddHousePic(HousePicDTO dto);

        /// <summary>
        /// 查看图片信息
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        List<HousePicDTO> GetHousePicList(long houseId);

        /// <summary>
        /// 批量删除图片信息
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        AjaxResult DeleteBatch(long[] houseId);
    }
}
