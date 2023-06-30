namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_AdminLogs : BaseEntity
    {

        public long AdminUserId { get; set; }

        [Required]
        public string Message { get; set; }
        public virtual T_AdminUsers T_AdminUsers { get; set; }
    }
}
