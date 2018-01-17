#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.presentation;

import java.beans.PropertyEditorSupport;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ${package}.business.DataTablesRequest;
import ${package}.business.GenericResponseBody;
import ${package}.business.GenericResponseBody.GenericResponseBodyState;
import ${package}.business.RoleService;
import ${package}.business.UserService;
import ${package}.business.model.Role;
import ${package}.business.model.User;
import ${package}.common.spring.session.SessionService;

@Controller
@RequestMapping("/administration/user")
public class AdministrationUserController {
  
   @Autowired
   private SessionService sessionService;

   @Autowired
   private UserService userService;

   @Autowired
   private RoleService roleService;

   @InitBinder
   protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
      binder.registerCustomEditor(Role.class, "roles", new PropertyEditorSupport() {
         @Override
         public void setAsText(String text) {
            Role role = roleService.findByPK(Long.parseLong(text));
            setValue(role);
         }
      });
   }

   @RequestMapping("/list")
   public String elenco() {
      return "administration.user.list";
   }

   @RequestMapping("/findallpaginated")
   public @ResponseBody GenericResponseBody findAllPaginated(@ModelAttribute DataTablesRequest dataTablesRequest) {
     return new GenericResponseBody(GenericResponseBodyState.SUCCESS, userService.findAllPaginated(dataTablesRequest));
   }

   @RequestMapping(value = "/create", method = { RequestMethod.GET })
   public String showCreate(Model model) {
      model.addAttribute("user", new User());
      model.addAttribute("availableRoles", roleService.findAll());
      return "administration.user.create";
   }

   @RequestMapping(value = "/create", method = { RequestMethod.POST })
   public String create(@ModelAttribute User user) {
      user.setPassword(DigestUtils.md5Hex(user.getPassword()));
      userService.create(user);
      return "redirect:/administration/user/list?success=true";
   }

   @RequestMapping(value = "/update", method = { RequestMethod.GET })
   public String showUpdate(@RequestParam("id") Long id, Model model) {
      User persistentUser = userService.findByPK(id);
      model.addAttribute("user", persistentUser);
      model.addAttribute("availableRoles", roleService.findAll());
      return "administration.user.update";
   }

   @RequestMapping(value = "/update", method = { RequestMethod.POST })
   public String update(@ModelAttribute User user) {
      User persistentUser = userService.findByPK(user.getId());
      boolean expireUserSession = !user.isActive() || !CollectionUtils.isEqualCollection(user.getRoles(), persistentUser.getRoles());
      persistentUser.setFirstname(user.getFirstname());
      persistentUser.setLastname(user.getLastname());
      persistentUser.setEmail(user.getEmail());
      persistentUser.setRoles(user.getRoles());
      persistentUser.setActive(user.isActive());
      persistentUser.setPasswordExpired(user.isPasswordExpired());
      userService.update(persistentUser);
      
      if (expireUserSession){
         // expire user session
         sessionService.expireUserSession(persistentUser);
      }else{
         // update user information without expiring her session
         sessionService.updateUserSession(persistentUser);
      }
      
      return "redirect:/administration/user/list?success=true";
   }

   @RequestMapping(value = "/delete", method = { RequestMethod.GET })
   public String showDelete(@RequestParam("id") Long id, Model model) {
      User persistentUser = userService.findByPK(id);
      model.addAttribute("user", persistentUser);
      model.addAttribute("availableRoles", roleService.findAll());
      return "administration.user.delete";
   }

   @RequestMapping(value = "/delete", method = { RequestMethod.POST })
   public String delete(@ModelAttribute User user) {
      userService.delete(user);
      sessionService.expireUserSession(user);
      return "redirect:/administration/user/list?success=true";
   }

   @RequestMapping(value = "/expire/session", method = { RequestMethod.GET })
   public String expireSession(@RequestParam("id") Long id, Model model) {
      sessionService.expireUserSession(userService.findByPK(id));
      return "redirect:/administration/user/list?success=true";
   }
  

}
