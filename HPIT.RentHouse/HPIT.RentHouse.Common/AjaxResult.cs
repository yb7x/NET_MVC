using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Common
{
    /// <summary>
    /// 枚举
    /// </summary>
    public enum ResultState
    {
        Error,
        Success
    }
    /// <summary>
    /// AJAX类，用来显示结果（使用构造器赋予值）
    /// </summary>
    public class AjaxResult
    {
        public ResultState State { get; set; }
        public string Message { get; set; }
        public AjaxResult(ResultState state, string message)
        {
            this.State = state;
            this.Message = message;
        }
    }
}
