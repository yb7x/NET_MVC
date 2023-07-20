using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO.UIDTO
{
    /// <summary>
    /// 预约信息 DTO
    /// </summary>
    public class HouseUiAppointmentsAddDTO
    {
        /// <summary>
        /// 预约者姓名
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 预约者电话
        /// </summary>
        public string PhoneNum { get; set; }
        /// <summary>
        /// 预约看房时间
        /// </summary>
        public DateTime VisitDate { get; set; }
        /// <summary>
        /// 房屋编号
        /// </summary>
        public long HouseId { get; set; }
    }
}
