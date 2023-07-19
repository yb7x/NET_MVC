using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    /// <summary>
    /// 区域接口
    /// </summary>
    public interface IRegionsService : IServiceSupport
    {
        /// <summary>
        /// 获取所有区域信息（根据所在城市查询到区域）
        /// </summary>
        /// <returns></returns>
        List<RegionsHouseDTO> GetRegions(long CityId);
    }
}
