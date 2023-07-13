using HPIT.RentHouse.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.IService
{
    /// <summary>
    /// 房屋配置信息接口
    /// </summary>
    public interface IAttachmentsService : IServiceSupport
    {
        /// <summary>
        /// 查询所有的配置信息名称
        /// </summary>
        /// <returns></returns>
        List<AttachmentsHouseDTO> GetAttachmentsList();
    }
}
