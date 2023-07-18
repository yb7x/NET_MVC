using HPIT.RentHouse.DTO.UIDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService.IUIService
{
    /// <summary>
    /// 客户端需要的城市接口
    /// </summary>
    public interface ICitysUiService:IServiceSupport
    {
        /// <summary>
        /// 获取所有城市信息
        /// </summary>
        /// <returns></returns>
        List<CityUiListDTO> GetCityList();
    }
}
