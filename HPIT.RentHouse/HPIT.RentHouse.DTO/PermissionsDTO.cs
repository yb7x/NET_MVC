using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace HPIT.RentHouse.DTO
{
    public class PermissionsDTO
    {
        public long Id { get; set; }

        public string Description { get; set; }

        public string Name { get; set; }
    }
}
