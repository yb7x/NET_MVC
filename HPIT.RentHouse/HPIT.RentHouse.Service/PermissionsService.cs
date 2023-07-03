using HPIT.RentHouse.Common;
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
    public class PermissionsService : IPermissionsService
    {
           /// <summary>
           /// 查询所有权限信息，若为空条件，则查询所有的
           /// </summary>
           /// <param name="Description">查询条件</param>
           /// <returns></returns>
        public List<PermissionsDTO> GetPermissionsList(string Description)
        {
            // 1、创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 2、创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 3、查询(使用 Common 中的 ParameterExpression 类中的 Lambda 扩展方法)
                var lambda = PredicateExtensions.True<T_Permissions>(); // 返回所有数据
                if (!string.IsNullOrWhiteSpace(Description))
                {
                    lambda = lambda.And(a => a.Description.Contains(Description));
                }
                return bs.GetList(lambda).Select(a => new PermissionsDTO()
                {
                    Id = a.Id,
                    Description = a.Description,
                    Name = a.Name
                }).ToList();
            }
        }
    }
}
