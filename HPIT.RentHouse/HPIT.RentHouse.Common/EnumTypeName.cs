using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Common
{
    /// <summary>
    /// 枚举类 => 对T_IdNames表枚举（户型、房屋状态、房屋类型、装修类型）
    /// </summary>
    public class EnumTypeName
    {
        /// <summary>
        /// 枚举这四个固定对象
        /// </summary>
        public enum TypeName
        {
            户型,
            房屋状态,
            房屋类型,
            装修状态
        }
    }
}
