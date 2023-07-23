using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    public class HouseAppointmentListDTO
    {
        public long Id { get; set; }
        public long? UserId { get; set; }
        /// <summary>
        /// 姓名
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 电话
        /// </summary>
        public string PhoneNum { get; set; }
        /// <summary>
        /// 预约时间
        /// </summary>
        public DateTime VisitDate { get; set; }
        /// <summary>
        /// 房源编号
        /// </summary>
        public long HouseId { get; set; }

        public string Status { get; set; }

        public long? FollowAdminUserId { get; set; }
        public string FollowAdminUserName { get; set; }

        public DateTime? FollowDateTime { get; set; }
        public string RegionName { get; set; }
        public string CommunityName { get; set; }
        public string HouseAddress { get; set; }
        public DateTime CreateDateTime { get; set; }
    }
}
