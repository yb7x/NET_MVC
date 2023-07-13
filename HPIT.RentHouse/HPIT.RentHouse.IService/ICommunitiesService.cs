using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    /// <summary>
    /// 小区接口
    /// </summary>
    public interface ICommunitiesService : IServiceSupport
    {
        /// <summary>
        /// 根据 区域 查询 小区
        /// </summary>
        /// <param name="RegionId"></param>
        /// <returns></returns>
        List<CommunitiesHouseDTO> GetCommunities(long RegionId);
    }
}
