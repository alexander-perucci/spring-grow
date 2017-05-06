#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "role")
public class Role extends BaseModel implements java.io.Serializable {
   private static final long serialVersionUID = -5400383771991397808L;
   
   public static final Long ADMINISTRATOR_ROLE_ID = 1L;
   public static final Long USER_ROLE_ID = 2L;

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "role_id")
   private Long id;

   @Column(name = "name", nullable = false, length = 64)
   private String name;

   @Column(name = "description", nullable = true, columnDefinition="TEXT")
   private String description;

   public Long getId() {
      return id;
   }

   public void setId(Long id) {
      this.id = id;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public String getDescription() {
      return description;
   }

   public void setDescription(String description) {
      this.description = description;
   }

   @Override
   public int hashCode() {
      final int prime = 31;
      int result = 1;
      result = prime * result + ((id == null) ? 0 : id.hashCode());
      return result;
   }

   @Override
   public boolean equals(Object obj) {
      if (this == obj)
         return true;
      if (obj == null)
         return false;
      if (getClass() != obj.getClass())
         return false;
      Role other = (Role) obj;
      if (id == null) {
         if (other.id != null)
            return false;
      } else if (!id.equals(other.id))
         return false;
      return true;
   }

   @Override
   public String toString() {
      return "Role [id=" + id + ", name=" + name + "]";
   }

}
