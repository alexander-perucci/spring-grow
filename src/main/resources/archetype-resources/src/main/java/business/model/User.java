#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "user")
public class User extends BaseModel implements java.io.Serializable {
   private static final long serialVersionUID = 1788538906029959745L;

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "user_id")
   private Long id;

   @Column(name = "first_name", nullable = false, length = 45)
   private String firstname;

   @Column(name = "last_name", nullable = false, length = 45)
   private String lastname;

   @Column(name = "username", nullable = false, unique = true, length = 32)
   private String username;

   @Column(name = "password", nullable = false, length = 32)
   private String password;

   @Column(name = "email", nullable = true, unique = true, length = 50)
   private String email;
   
   @Column(name = "active", nullable = false)
   private boolean active = true;

   @Column(name = "password_expired", nullable = false)
   private boolean passwordExpired = false;

   @Lob
   @Column(name = "picture", nullable = true)
   private byte[] picture;

   @JsonIgnore
   @ManyToMany(fetch = FetchType.EAGER)
   @JoinTable(name = "user_role", joinColumns = { @JoinColumn(name = "user_id") }, inverseJoinColumns = {
         @JoinColumn(name = "role_id") })
   private Set<Role> roles = new HashSet<Role>();

   public Long getId() {
      return id;
   }

   public void setId(Long id) {
      this.id = id;
   }

   public String getFirstname() {
      return firstname;
   }

   public void setFirstname(String firstname) {
      this.firstname = firstname;
   }

   public String getLastname() {
      return lastname;
   }

   public void setLastname(String lastname) {
      this.lastname = lastname;
   }

   public String getUsername() {
      return username;
   }

   public void setUsername(String username) {
      this.username = username;
   }

   public String getPassword() {
      return password;
   }

   public void setPassword(String password) {
      this.password = password;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public boolean isActive() {
      return active;
   }

   public void setActive(boolean active) {
      this.active = active;
   }

   public boolean isPasswordExpired() {
      return passwordExpired;
   }

   public void setPasswordExpired(boolean passwordExpired) {
      this.passwordExpired = passwordExpired;
   }

   public byte[] getPicture() {
      return picture;
   }

   public void setPicture(byte[] picture) {
      this.picture = picture;
   }

   public Set<Role> getRoles() {
      return roles;
   }

   public void setRoles(Set<Role> roles) {
      this.roles = roles;
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
      User other = (User) obj;
      if (id == null) {
         if (other.id != null)
            return false;
      } else if (!id.equals(other.id))
         return false;
      return true;
   }

   @Override
   public String toString() {
      return "User [id=" + id + ", username=" + username + ", email=" + email + "]";
   }
}
