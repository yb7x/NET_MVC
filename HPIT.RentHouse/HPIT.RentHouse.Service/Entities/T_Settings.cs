namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_Settings : BaseEntity
    {

        [Required]
        [StringLength(1024)]
        public string Name { get; set; }

        [Required]
        public string Value { get; set; }

    }
}
