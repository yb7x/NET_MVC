using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    public class AdminLoginDataDTO
    {
        public long Id { get; set; }
        public string Name { get; set; }

        public string PhoneNum { get; set; }

        public string Email { get; set; }

        public string RoleName { get; set; }

    }
}
