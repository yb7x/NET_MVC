using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO.UIDTO
{
    /// <summary>
    /// 搜索需要返回的信息
    /// </summary>
    public class HouseUiSearchVoidDTO
    {
        /// <summary>
        /// 房屋编号
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// 区域
        /// </summary>
        public string RegionsName { get; set; }

        /// <summary>
        /// 小区名
        /// </summary>
        public string Community { get; set; }

        /// <summary>
        /// 地段
        /// </summary>
        public string Address { get; set; }

        /// <summary>
        /// 租金
        /// </summary>
        public int MonthRent { get; set; }

        /// <summary>
        /// 房型
        /// </summary>
        public string RoomTypeName { get; set; }

        /// <summary>
        /// 装修
        /// </summary>
        public string DecorateStatusName { get; set; }

        /// <summary>
        /// 房屋面积
        /// </summary>
        public decimal Area { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public long TypeId { get; set; }

        public string TypeName { get; set; }

        /// <summary>
        /// 小区编号
        /// </summary>
        public long DecorateStatusId { get; set; }

        /// <summary>
        /// 户型类型
        /// </summary>
        public long RoomTypeId { get; set; }

        /// <summary>
        /// 缩略图地址
        /// </summary>
        public string ThumbUrl { get; set; }
    }
}
