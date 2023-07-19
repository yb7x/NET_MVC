using HPIT.RentHouse.DTO.UIDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService.IUIService
{
    /// <summary>
    /// Ui 房源接口
    /// </summary>
    public interface IHouseUiService : IServiceSupport
    {
        /// <summary>
        /// 获取房源信息
        /// </summary>
        /// <returns></returns>
        List<HouseUiListDTO> GetHouseUi(long cityId, int start, int length, string KeyWord);

        /// <summary>
        /// 显示房源信息，点击显示
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        HouseUiLookDTO GetHouseMessage(long houseId);

        /// <summary>
        /// 房源搜索
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        List<HouseUiSearchVoidDTO> Search(HouseUiSearchDTO dto);
    }
}
