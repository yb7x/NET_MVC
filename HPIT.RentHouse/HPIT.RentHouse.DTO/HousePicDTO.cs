using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 房源图片
    /// </summary>
    public class HousePicDTO
    {
        public long Id { get; set; }
        public long HouseId { get; set; }

        public string Url { get; set; }

        public string ThumbUrl { get; set; }
    }
}
