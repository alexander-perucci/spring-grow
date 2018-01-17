#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title><spring:message code="common.application.name" /></title>

<link rel="icon" type="image/ico" href="${symbol_dollar}{pageContext.request.contextPath}/static/favicon.ico" />

<%@include file="../layout/layout_css.jsp"%>

<%-- jQuery - leave here because enables the use of ${symbol_dollar} on jsp pages that they use ${symbol_dollar}(document).ready(function() {...}); --%>
<script src="${symbol_dollar}{pageContext.request.contextPath}/static/gentelella/vendors/jquery/dist/jquery.min.js"></script>

<%-- Application --%>
<script src="${symbol_dollar}{pageContext.request.contextPath}/static/application.js"></script>

</head>

<body class="login">
   <div id="languages"><span class="bfh-languages" data-language="en_US" data-flags="true">
      <a href="?lang=en"><i class="glyphicon flag-US"></i> English</span></a> <a href="?lang=it"><i class="glyphicon flag-IT"></i> Italiano</span></a>
   </div>
   <div>
      <a class="hiddenanchor" id="signup"></a> <a class="hiddenanchor" id="signin"></a> <a class="hiddenanchor" id="forgot"></a>

      <div class="login_wrapper">
         <div class="animate form signin_form">
            <section class="login_content">
               <form action="${symbol_dollar}{pageContext.request.contextPath}/j_spring_security_check" data-parsley-validate="data-parsley-validate" method="post">
                  <h1>
                     <spring:message code="common.signin" />
                  </h1>
                  <div>
                     <input type="text" name="j_username" placeholder="<spring:message code='user.username' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <input type="password" name="j_password" placeholder="<spring:message code='user.password' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <button class="btn btn-theme btn-block" type="submit">
                        <i class="fa fa-lock"></i>
                        <spring:message code="common.signin" />
                     </button>
                  </div>
                  <div class="clearfix"></div>

                  <div class="separator">
                     <p class="change_link text-align-left float-left">
                        <spring:message code="common.new.member" />
                        <a href="${symbol_pound}signup"> <spring:message code="common.signup" />
                        </a>
                     </p>
                     <p class="text-align-right">
                        <a href="${symbol_pound}forgot"> <i class="fa fa-lock"></i> <spring:message code="user.password.restore" />
                        </a>
                     </p>

                     <div class="clearfix"></div>

                     <br />

                     <div>
                        <h1>
                           <i class="fa fa-users"></i>
                           <spring:message code="common.application.name" />
                        </h1>
                        <p><%@include file="../common/copyright.jsp"%></p>
                     </div>
                  </div>
               </form>
            </section>
         </div>

         <div class="animate form signup_form">
            <section class="login_content">
               <form action="${symbol_dollar}{pageContext.request.contextPath}/utility/user/create" data-parsley-validate="data-parsley-validate" method="POST">
                  <h1>
                     <spring:message code="common.signup" />
                  </h1>
                  <div>
                     <input id="username" name="username" type="text" data-parsley-trigger="focusout" data-parsley-remote-validator="remote-validator-username" data-parsley-remote-message="<spring:message code='user.username.already.exists'/>" data-parsley-remote="${symbol_dollar}{pageContext.request.contextPath}/utility/user/check/username?username={value}&considerAuthentication=false" placeholder="<spring:message code='user.username' />" required="required" class="form-control custom-parsley-success" />
                  </div>
                  <div>
                     <input id="firstname" name="firstname" type="text" placeholder="<spring:message code='user.firstname' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <input id="lastname" name="lastname" type="text" placeholder="<spring:message code='user.lastname' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <input id="email" name="email" type="email" data-parsley-trigger="focusout" data-parsley-remote-validator="remote-validator-email" data-parsley-remote-message="<spring:message code='user.email.already.exists'/>" data-parsley-remote="${symbol_dollar}{pageContext.request.contextPath}/utility/user/check/email?email={value}&considerAuthentication=false" placeholder="<spring:message code='user.email' />" required="required" class="form-control custom-parsley-success" />
                  </div>
                  <div>
                     <input id="password" name="password" type="password" placeholder="<spring:message code='user.password' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <input id="confirmPassword" name="confirmPassword" type="password" data-parsley-trigger="focusout" data-parsley-equalto="${symbol_pound}password" placeholder="<spring:message code='user.password.repeat' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <button class="btn btn-theme btn-block" type="submit">
                        <spring:message code="common.signup" />
                     </button>
                  </div>

                  <div class="clearfix"></div>

                  <div class="separator">
                     <p class="change_link">
                        <spring:message code="common.already.member" />
                        <a href="${symbol_pound}signin"> <spring:message code="common.signin" />
                        </a>
                     </p>

                     <div class="clearfix"></div>
                     <br />

                     <div>
                        <h1>
                           <i class="fa fa-users"></i>
                           <spring:message code="common.application.name" />
                        </h1>
                        <p><%@include file="../common/copyright.jsp"%></p>
                     </div>
                  </div>
               </form>
            </section>
         </div>

         <div class="animate form forgot_form">
            <section class="login_content">
               <form action="${symbol_dollar}{pageContext.request.contextPath}/utility/user/reset/password" data-parsley-validate="data-parsley-validate" method="POST">
                  <h1>
                     <spring:message code="user.password.reset" />
                  </h1>
                  <div>
                     <input id="username" name="username" type="text" placeholder="<spring:message code='user.username' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <input id="newpassword" name="password" type="password" placeholder="<spring:message code='user.password.new' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <input id="confirmPassword" name="confirmPassword" type="password" data-parsley-trigger="focusout" data-parsley-equalto="${symbol_pound}newpassword" placeholder="<spring:message code='user.password.repeat' />" required="required" class="form-control" />
                  </div>
                  <div>
                     <button class="btn btn-theme btn-block" type="submit">
                        <i class="fa fa-lock"></i>
                        <spring:message code="common.reset" />
                     </button>
                  </div>

                  <div class="clearfix"></div>

                  <div class="separator">
                     <p class="change_link">
                        <spring:message code="common.already.member" />
                        <a href="${symbol_pound}signin"> <spring:message code="common.signin" />
                        </a>
                     </p>

                     <div class="clearfix"></div>
                     <br />

                     <div>
                        <h1>
                           <i class="fa fa-users"></i>
                           <spring:message code="common.application.name" />
                        </h1>
                        <p><%@include file="../common/copyright.jsp"%></p>
                     </div>
                  </div>
               </form>
            </section>
         </div>
      </div>
   </div>

   <%@include file="../layout/layout_javascript.jsp"%>

   <script type="text/javascript">
      ${symbol_dollar}(document).ready(function() {
         switch("${symbol_dollar}{not empty param.failure ? param.failure : ''}") {
         case 'badCredentials':
   			showMessage("error", "<spring:message code='common.error' />", "<spring:message code='common.failure.badcredentials.message' />");
           	break;
         case 'userDisabled':
           	showMessage("error", "<spring:message code='common.error' />", "<spring:message code='common.failure.userdisabled.message' />");
           	break;
         case 'sessionAuthentication':
           	showMessage("error", "<spring:message code='common.error' />", "<spring:message code='common.failure.sessionauthentication.message' />");
           	break;
     	 }
      });
   </script>
</body>
</html>