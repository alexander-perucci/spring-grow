#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.presentation;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ${package}.business.UserService;
import ${package}.business.model.User;
import ${package}.common.spring.security.AuthenticationHolder;
import ${package}.common.spring.session.SessionService;

@Controller
@RequestMapping("/settings")
public class SettingsController {
   @Autowired
   private SessionService sessionService;
   
   @Autowired
   private UserService userService;

   @RequestMapping(value = "/account", method = { RequestMethod.GET })
   public String showUpdateAccount(Model model) {
      User user = new AuthenticationHolder().getAuthenticatedUser();
      model.addAttribute("user", user);
      return "settings.account";
   }

   @RequestMapping(value = "/account", method = { RequestMethod.POST })
   public String updateAccount(@ModelAttribute User user) {
      User persistentUser = userService.findByPK(user.getId());
      persistentUser.setFirstname(user.getFirstname());
      persistentUser.setLastname(user.getLastname());
      persistentUser.setEmail(user.getEmail());
      userService.update(persistentUser);
      
      // update user information without expiring her session
      sessionService.updateUserSession(persistentUser);
      
      return "redirect:/settings/account?success=true";
   }

   @RequestMapping(value = "/password", method = { RequestMethod.GET })
   public String showUpdatePassword(Model model) {
      User user = new AuthenticationHolder().getAuthenticatedUser();
      model.addAttribute("user", user);
      return "settings.password";
   }

   @RequestMapping(value = "/password", method = { RequestMethod.POST })
   public String updatePassword(@ModelAttribute User user, @RequestParam String newPassword) {
      User persistentUser = userService.findByPK(user.getId());
      persistentUser.setPassword(DigestUtils.md5Hex(newPassword));
      userService.update(persistentUser);

      // update user information without expiring her session
      sessionService.updateUserSession(persistentUser);

      return "redirect:/settings/password?success=true";
   }
}
