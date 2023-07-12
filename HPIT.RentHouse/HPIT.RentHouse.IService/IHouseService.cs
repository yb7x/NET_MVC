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
        List<HouseListDTO> GetListHouse(int start, int length, ref int count, string Community);
    }
}
