using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Service
{
    /// <summary>
    /// 房屋配置
    /// </summary>
    public class AttachmentsService : IAttachmentsService
    {
        public List<AttachmentsHouseDTO> GetAttachmentsList()
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Attachments> bs = new BaseService<T_Attachments>(db);
                return bs.GetOrderBy(a => true, a => a.Id, false).Select(a => new AttachmentsHouseDTO()
                {
                    Id = a.Id,
                    Name = a.Name,
                    IconName = a.IconName
                }).ToList();
            }
        }
    }
}
