#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.common.spring.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import ${package}.business.BusinessException;
import ${package}.business.UserService;
import ${package}.business.model.User;

public class UserDetailsServiceImpl implements UserDetailsService {
  
   
   @Autowired
   private UserService userService;

   @Override
   public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
      User user;
      try {
         user = userService.findByUsername(username);
      } catch (BusinessException e) {
         throw new UsernameNotFoundException("User not found.");
      }

      if (user == null) {
         throw new UsernameNotFoundException("User not found.");
      }

      return new UserDetailsImpl(user);
   }
   
   

}
