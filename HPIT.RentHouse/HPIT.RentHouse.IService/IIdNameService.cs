using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    /// <summary>
    /// 数据字典表接口（户型、房屋状态、房屋类型、装修类型）
    /// </summary>
    public interface IIdNameService : IServiceSupport
    {
        /// <summary>
        /// 获取房屋样式信息
        /// </summary>
        /// <returns></returns>
        List<IdNameListDTO> GetIdName(EnumTypeName.TypeName typeName);
    }
}
