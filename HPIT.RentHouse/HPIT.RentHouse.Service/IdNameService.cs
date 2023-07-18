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
    /// <summary>
    /// 所有房屋信息（户型、房屋状态、房屋类型、装修类型）
    /// </summary>
    public class IdNameService : IIdNameService
    {
        /// <summary>
        /// 模拟缓存机制，静态对象内容常驻内存中
        /// </summary>
        public static List<IdNameListDTO> IdNameList = null;

        /// <summary>
        /// 构造器给模拟的缓存机制赋值
        /// </summary>
        public IdNameService() 
        {
            // 如果为空则需要查询数据
            if (IdNameList == null)
            {
                // 创建上下文对象，查询需要的数据
                using (RentHouseEntity db = new RentHouseEntity())
                {
                    BaseService<T_IdNames> bs = new BaseService<T_IdNames>(db);
                    // 获取所有所需要的数据放到内存中，需要使用哪个，就从内存中拿出来那个
                    List<IdNameListDTO> list = bs.GetList(a => true).Select(a => new IdNameListDTO()
                    {
                        Id = a.Id,
                        Name = a.Name,
                        TypeName  =  a.TypeName
                    }).ToList();
                    IdNameList = list; // 给字段赋值
                }
            }
        }

        /// <summary>
        /// 根据传进来的枚举对象来查询信息
        /// </summary>
        /// <param name="typeName"></param>
        /// <returns></returns>
        public List<IdNameListDTO> GetIdName(EnumTypeName.TypeName typeName)
        {
            // 转换枚举类型为字符串类型
            string tn = typeName.ToString();
            return IdNameList.Where(a => a.TypeName == tn).ToList();
        }

        /// <summary>
        /// 通过 编号 获取对应名称的（户型、房屋状态、房屋类型、装修类型）
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public string GetName(long id)
        {
            return IdNameList.FirstOrDefault(a => a.Id == id).Name;
        }
    }
}
