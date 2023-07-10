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
    /// 所有城市
    /// </summary>
    public class CitysService : ICitysService
    {
        /// <summary>
        /// 查询所有城市信息，可能用于下拉城市列表
        /// </summary>
        /// <returns></returns>
        public List<CitylistDTO> GetCityList()
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Cities> bs = new BaseService<T_Cities>(db);
                // 查询所有数据
                return bs.GetOrderBy(a => true, b => b.Id, false).Select(a => new CitylistDTO()
                {
                    Id = a.Id,
                    Name = a.Name
                }).ToList();
            }
        }
    }
}
