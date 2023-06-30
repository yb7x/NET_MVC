namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_HousePics : BaseEntity
    {

        public long HouseId { get; set; }

        [Required]
        [StringLength(1024)]
        public string Url { get; set; }

        [Required]
        [StringLength(1024)]
        public string ThumbUrl { get; set; }


        public virtual T_Houses T_Houses { get; set; }
    }
}
