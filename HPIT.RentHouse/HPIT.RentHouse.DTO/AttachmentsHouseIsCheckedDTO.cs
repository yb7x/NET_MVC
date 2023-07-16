using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 包含是否选中的房屋配置
    /// </summary>
    public class AttachmentsHouseIsCheckedDTO
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string IconName { get; set; }
        public bool IsChecked { get; set; }
    }
}
