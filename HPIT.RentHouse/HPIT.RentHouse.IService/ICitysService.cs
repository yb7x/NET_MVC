using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    /// <summary>
    /// 所有城市接口
    /// </summary>
    public interface ICitysService:IServiceSupport
    {
        /// <summary>
        /// 获取所有城市信息
        /// </summary>
        /// <returns></returns>
        List<CitylistDTO> GetCityList();
    }
}
