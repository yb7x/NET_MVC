using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace HPIT.RentHouse.Service
{
    /// <summary>
    /// 用户管理=实现接口
    /// </summary>
    public class UserAdminService : IUserAdminService
    {
        /// <summary>
        /// 添加管理员用户
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public AjaxResult Add(UserAdminAddDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建需要操作的表对象
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers> (db);
                BaseService<T_Roles> rbs = new BaseService<T_Roles> (db);
                // 要保存的数据转化类型
                // 这里要保存加密加盐后的密码，需要调用 Common 层的 CreateVerifyCode 来产生随机的 5 位数盐码，使用 CalcMD5 方法来加密密码并储存
                // 获取随机盐码
                var passwords = CommonHelper.CreateVerifyCode(5);
                // 密码结合盐码一起加密
                var password = CommonHelper.CalcMD5((dto.Password + passwords));
                T_AdminUsers adminUsers = new T_AdminUsers()
                {
                    Name = dto.Name,
                    PasswordSalt = passwords,
                    CityId = dto.CityId,
                    Email = dto.Email,
                    CreateDateTime = DateTime.Now,
                    IsDeleted = false,
                    PhoneNum = dto.PhoneNum,
                    PasswordHash = password
                };
                // 添加操作并判断添加状态
                if (bs.Add(adminUsers) > 0)
                {
                    // 继续添加相应的角色表
                    for (int i = 0; i < dto.RolesId.Length; i++)
                    {
                        // 循环遍历出每一个值
                        var id = dto.RolesId[i];
                        // 通过这个Id查询到角色信息
                        T_Roles roles = rbs.Get(a => a.Id == id);
                        // 添加角色信息到用户表中(通过导航属性向关系表添加数据)
                        adminUsers.T_Roles.Add(roles);
                    }
                    db.SaveChanges();
                    return new AjaxResult(ResultState.Success, "添加成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "添加失败！");
                }
                
            }
        }


        /// <summary>
        /// 修改管理员用户
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public UserAdminGetEditDTO GetEdit(long id)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 实例化要操作的表
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers> (db);
                BaseService<T_Roles> rbs = new BaseService<T_Roles> (db);
                // 查询数据
                T_AdminUsers model = bs.Get(a => a.Id == id);
                // 与返回类型匹配
                UserAdminGetEditDTO dto = new UserAdminGetEditDTO()
                {
                    Id = id,
                    Name = model.Name,
                    Email = model.Email,
                    CityId = model.CityId,
                    PhoneNum = model.PhoneNum
                };
                // 先获取所有 Roles（角色） 信息
                List<T_Roles> roles = rbs.GetList(a => true).ToList();
                // 获取当前对象的 Roles
                var role = model.T_Roles;
                // 为 dto.RolesId 开辟空间
                dto.RolesId = new List<UserAdminRolesDTO>();
                // 循环遍历出所有 选中 的角色信息
                foreach (var item in roles)
                {
                    UserAdminRolesDTO urdto = new UserAdminRolesDTO()
                    {
                        Id = item.Id,
                        Name = item.Name,
                        IsChecked = role.Any(a => a.Id == item.Id) // 判断当前 Id 是否匹配当前这行数据的 Id ，匹配则返回 true 否则 false
                    };
                    // 添加到 需要显示的数据中
                    dto.RolesId.Add(urdto);
                }
                return dto;
            }
        }

        /// <summary>
        /// 修改管理员用户信息
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public AjaxResult Edit(UserAdminEditDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                BaseService<T_Roles> rbs = new BaseService<T_Roles>(db);
                // 查询要修改的数据
                T_AdminUsers model = bs.Get(a => a.Id == dto.Id);
                // 这里要注意密码的修改，先加盐，后加密
                string salt = CommonHelper.CreateVerifyCode(5);
                string passWord = CommonHelper.CalcMD5((dto.Password + salt));
                // 修改数据
                model.Name = dto.Name;
                model.Email = dto.Email;
                model.CityId = dto.CityId;
                model.PhoneNum = dto.PhoneNum;
                model.PasswordSalt = salt;
                model.PasswordHash = passWord;
                // 判断修改状态并修改 Roles 表状态
                if (bs.Update(model))
                {
                    // 先清除角色信息,通过导航属性
                    model.T_Roles.Clear();
                    for (int i = 0; i < dto.RolesId.Length; i++)
                    {
                        // 查询当前角色信息 编号
                        long id = dto.RolesId[i];
                        // 查找信息
                        T_Roles role = rbs.Get(a => a.Id == id);
                        // 添加到表中
                        model.T_Roles.Add(role);
                    }
                    db.SaveChanges();
                    return new AjaxResult(ResultState.Success, "修改成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "修改失败！");
                }
            }
        }

        /// <summary>
        /// 列表显示，带查询
        /// </summary>
        /// <param name="Name">用户名</param>
        /// <returns></returns>
        public List<UserAdminListDTO> GetList(string Name)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                // 查询所有的数据
                var where = PredicateExtensions.True<T_AdminUsers>();
                // 条件
                if (!string.IsNullOrWhiteSpace(Name))
                {
                    where = where.And(a => a.Name.Contains(Name));
                }
                return bs.GetOrderBy(where, a => a.Id, false).Select(a => new UserAdminListDTO()
                {
                    CityName = a.T_Cities.Name,
                    Email = a.Email,
                    Id = a.Id,
                    LoginErrorTimes = a.LoginErrorTimes,
                    Name = a.Name,
                    PhoneNum = a.PhoneNum,
                }).ToList();
            }
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public AjaxResult Delete(long id)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                // 查询要删除的信息
                T_AdminUsers model = bs.Get(a => a.Id == id);
                // 调用删除方法，并判断状态
                if (model != null)
                {
                    // 清除 roles 表数据
                    model.T_Roles.Clear();
                    if (bs.Delete(model))
                    {
                        return new AjaxResult(ResultState.Success, "删除成功！");
                    }
                    else
                    {
                        return new AjaxResult(ResultState.Error, "删除失败！");
                    }
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "该用户已删除！");
                }
            }
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public AjaxResult DeleteBatch(long[] ids)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                // 循环遍历数据
                for (int i = 0; i < ids.Length; i++)
                {
                    // 依次遍历要删除的数据
                    long id = ids[i];
                    T_AdminUsers model = bs.Get(a => a.Id == id);
                    // 删除这个数据并清除预支对应的关系
                    model.T_Roles.Clear();
                    bs.Delete(model);
                }
                return new AjaxResult(ResultState.Success, "批量删除成功！");
            }
        }
    }
}
