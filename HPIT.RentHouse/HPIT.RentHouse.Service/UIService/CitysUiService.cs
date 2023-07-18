using HPIT.RentHouse.DTO.UIDTO;
using HPIT.RentHouse.IService.IUIService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Service.UIService
{
    /// <summary>
    /// Ui需要的城市信息
    /// </summary>
    public class CitysUiService : ICitysUiService
    {
        public List<CityUiListDTO> GetCityList()
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Cities> bs = new BaseService<T_Cities>(db);
                return bs.GetList(a => true).Select(a => new CityUiListDTO()
                {
                    Id = a.Id,
                    Name = a.Name
                }).ToList();
            }
        }
    }
}
