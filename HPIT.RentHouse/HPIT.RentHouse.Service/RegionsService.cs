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
    /// 区域
    /// </summary>
    public class RegionsService : IRegionsService
    {
        /// <summary>
        /// 区域信息
        /// </summary>
        /// <returns></returns>
        public List<RegionsHouseDTO> GetRegions(long CityId)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Regions> bs = new BaseService<T_Regions>(db);
                // 通过城市编号获取当前区域信息
                return bs.GetList(a => a.CityId == CityId).Select(a => new RegionsHouseDTO()
                {
                 Id = a.Id,
                 Name = a.Name,
                 CityId = a.CityId
                }).ToList();
            }
        }
    }
}
