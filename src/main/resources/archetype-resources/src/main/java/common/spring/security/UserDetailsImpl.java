#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.common.spring.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import ${package}.business.model.Role;
import ${package}.business.model.User;

public class UserDetailsImpl implements UserDetails {
   private static final long serialVersionUID = 8851321994996179060L;
   private User user;

   public UserDetailsImpl(User user) {
      super();
      this.user = user;
   }

   @Override
   public Collection<GrantedAuthority> getAuthorities() {
      List<GrantedAuthority> result = new ArrayList<GrantedAuthority>();
      for (Role role : user.getRoles()) {
         result.add(new GrantedAuthorityImpl(role));
      }
      return result;
   }

   @Override
   public String getPassword() {
      return this.user.getPassword();
   }

   @Override
   public String getUsername() {
      return user.getUsername();
   }
   
   @Override
   public boolean isAccountNonExpired() {
      return true;
   }

   @Override
   public boolean isAccountNonLocked() {
      return true;
   }

   @Override
   public boolean isCredentialsNonExpired() {
      return !user.isPasswordExpired();
   }

   @Override
   public boolean isEnabled() {
      return user.isActive();
   }

   @Override
   public String toString() {
      return "UserDetailsImpl [username=" + this.user.getUsername() + "]";
   }

   public User getUser() {
      return this.user;
   }
   
   public User setUser(User user) {
      return this.user = user;
   }

   @Override
   public int hashCode() {
      final int prime = 31;
      int result = 1;
      result = prime * result + ((user == null) ? 0 : user.hashCode());
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
      UserDetailsImpl other = (UserDetailsImpl) obj;
      if (user == null) {
         if (other.user != null)
            return false;
      } else if (!user.equals(other.user))
         return false;
      return true;
   }
   
   
}
