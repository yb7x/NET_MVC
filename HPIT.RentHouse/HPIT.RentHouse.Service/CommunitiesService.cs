using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Service
{
    /// <summary>
    /// 小区
    /// </summary>
    public class CommunitiesService : ICommunitiesService
    {
        /// <summary>
        /// 通过当前区域获取小区
        /// </summary>
        /// <param name="RegionId">区域Id</param>
        /// <returns></returns>
        public List<CommunitiesHouseDTO> GetCommunities(long RegionId)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Communities> bs = new BaseService<T_Communities>(db);
                // 根据区域Id查询小区信息
                return bs.GetOrderBy(a => a.RegionId == RegionId, a => a.Id, false).Select(a => new CommunitiesHouseDTO()
                {
                    Id = a.Id,
                    RegionId = a.RegionId,
                    Name = a.Name
                }).ToList();
            }
        }
    }
}
