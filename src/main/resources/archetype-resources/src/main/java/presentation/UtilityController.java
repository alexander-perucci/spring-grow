#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.presentation;

import java.io.IOException;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ${package}.business.AvatarRequest;
import ${package}.business.BusinessException;
import ${package}.business.GenericResponseBody;
import ${package}.business.GenericResponseBody.GenericResponseBodyState;
import ${package}.business.UserService;
import ${package}.business.model.Role;
import ${package}.business.model.User;
import ${package}.common.spring.security.AuthenticationHolder;
import ${package}.common.utility.Utility;

@Controller
@RequestMapping("/utility")
public class UtilityController {

   @Autowired
   private UserService userService;

   @RequestMapping(value = "/user/create", method = { RequestMethod.POST })
   public String userCreate(@ModelAttribute User user) {
      String originalPassword = user.getPassword();
      Role userRole = new Role();
      userRole.setId(Role.USER_ROLE_ID);
      user.getRoles().add(userRole);
      user.setActive(true);
      user.setPassword(DigestUtils.md5Hex(originalPassword));
      userService.create(user);

      return "redirect:/login";
   }

   @RequestMapping(value = "/user/reset/password", method = { RequestMethod.POST })
   public String userResetPassword(@ModelAttribute User user) {
      String originalPassword = user.getPassword();
      User persistentUser = userService.findByUsername(user.getUsername());
      persistentUser.setPassword(DigestUtils.md5Hex(originalPassword));
      persistentUser.setPasswordExpired(false);
      userService.update(persistentUser);

      return "redirect:/login";
   }

   @RequestMapping("/user/check/username")
   public @ResponseBody GenericResponseBody userCheckUsername(@RequestParam("username") String username,
         @RequestParam(value = "user_id", required = false) Long userId) {
      try {
         User persistentUserByUsername = userService.findByUsername(username);
         if (userId != null && persistentUserByUsername.equals(userService.findByPK(userId))) {
            return new GenericResponseBody(GenericResponseBodyState.SUCCESS);
         }

         return new GenericResponseBody(GenericResponseBodyState.ERROR);

      } catch (BusinessException e) {
         return new GenericResponseBody(GenericResponseBodyState.SUCCESS);
      }
   }

   @RequestMapping("/user/check/email")
   public @ResponseBody GenericResponseBody userCheckEmail(@RequestParam("email") String email,
         @RequestParam(value = "user_id", required = false) Long userId) {
      try {
         User persistentUserByUsername = userService.findByEmail(email);
         if (userId != null && persistentUserByUsername.equals(userService.findByPK(userId))) {
            return new GenericResponseBody(GenericResponseBodyState.SUCCESS);
         }

         return new GenericResponseBody(GenericResponseBodyState.ERROR);

      } catch (BusinessException e) {
         return new GenericResponseBody(GenericResponseBodyState.SUCCESS);
      }
   }

   @RequestMapping(value = "/user/avatar/show", produces = { "image/*" })
   public @ResponseBody byte[] userAvatarShow() throws IOException {
      User authenticatedUser = new AuthenticationHolder().getAuthenticatedUser();
      User persistentUser = userService.findByPK(authenticatedUser.getId());

      if (persistentUser.getPicture() == null || persistentUser.getPicture().length == 0) {
         return null;
      }

      return persistentUser.getPicture();
   }

   @RequestMapping(value = "/user/avatar/update", method = RequestMethod.POST, consumes = { "multipart/form-data" })
   public @ResponseBody GenericResponseBody userAvatarUpdate(@RequestPart("avatar_data") AvatarRequest avatarRequest,
         @RequestPart("avatar_file") MultipartFile file) {
      User authenticatedUser = new AuthenticationHolder().getAuthenticatedUser();
      User persistentUser = userService.findByPK(authenticatedUser.getId());

      try {
         persistentUser.setPicture(Utility.cropImage(file.getBytes(), avatarRequest.getX().intValue(),
               avatarRequest.getY().intValue(), avatarRequest.getWidth().intValue(),
               avatarRequest.getHeight().intValue(), avatarRequest.getScaleX() == -1 ? true : false,
               avatarRequest.getScaleY() == -1 ? true : false, avatarRequest.getRotate()));
      } catch (BusinessException | IOException e) {
         return new GenericResponseBody(GenericResponseBodyState.ERROR);
      }

      userService.update(persistentUser);

      return new GenericResponseBody(GenericResponseBodyState.SUCCESS);
   }
   
   
   

}
