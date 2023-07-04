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
        /// 添加权限信息
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns>Ajax true:1 false:0</returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult AddPermissions(PermissionsDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 创建添加对象
                T_Permissions model = new T_Permissions()
                {
                    Description = dto.Description,
                    CreateDateTime = DateTime.Now,
                    IsDeleted = false,
                    Name = dto.Name
                };
                if (bs.Add(model) > 0)
                {
                    return new AjaxResult(ResultState.Success, "添加成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "添加失败");
                }
            }
        }

        /// <summary>
        /// 查询要修改权限信息，
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns>PermissionsDTO 类型</returns>
        public PermissionsDTO EditGetPermissions(long id)
        {
            // 1、创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 2、创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 执行操作，投射
                return bs.GetList(a => a.Id == id).Select(a => new PermissionsDTO()
                {
                    Description = a.Description,
                    Id = a.Id,
                    Name = a.Name
                }).FirstOrDefault();
            }
        }

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
