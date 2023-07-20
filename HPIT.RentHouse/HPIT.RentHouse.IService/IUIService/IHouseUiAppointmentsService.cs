using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.DTO.UIDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService.IUIService
{
    /// <summary>
    /// 看房预约 接口
    /// </summary>
    public interface IHouseUiAppointmentsService : IServiceSupport
    {
        /// <summary>
        /// 添加 看房预约信息 UI
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult Add(HouseUiAppointmentsAddDTO dto);

        /// <summary>
        /// 预约房源列表 
        /// </summary>
        /// <returns></returns>
        List<HouseAppointmentsListDTO> HouseAppointmentsList(int start, int length, ref int count);

        /// <summary>
        /// 抢单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        AjaxResult Follow(long id, long adminUserId);
    }
}
 