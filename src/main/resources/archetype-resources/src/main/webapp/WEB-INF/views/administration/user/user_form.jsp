#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@page import="java.util.Base64"%>
<%@page import="${package}.business.model.User"%>
<%@page import="${package}.business.model.Role"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="user_javascript.jsp"%>

<div class="row">
   <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
         <div class="x_title">
            <h2>
               <c:choose>
                  <c:when test="${symbol_dollar}{requestScope.view_type == 'update'}">
                     <spring:message code="user.update" />
                  </c:when>
                  <c:when test="${symbol_dollar}{requestScope.view_type == 'create'}">
                     <spring:message code="user.create" />
                  </c:when>
                  <c:when test="${symbol_dollar}{requestScope.view_type == 'delete'}">
                     <spring:message code="user.delete" />
                  </c:when>
               </c:choose>
            </h2>
            <ul class="nav navbar-right panel_toolbox">
               <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
            </ul>
            <div class="clearfix"></div>
         </div>
         <div class="x_content">

            <br />
            <form:form modelAttribute="user" id="user_form" action="${symbol_dollar}{pageContext.request.contextPath}${symbol_dollar}{requestScope.action}" class="form-horizontal form-label-left" method="POST">
               <form:hidden path="id" />
               <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="username"><spring:message code="user.username" /> <span class="required">*</span> </label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                     <spring:message code="user.username.already.exists" var="usernameAlreadyExists" />
                     <form:input path="username" type="text" data-parsley-trigger="focusout" data-parsley-remote-validator="remote-validator-username" data-parsley-remote-message="${symbol_dollar}{usernameAlreadyExists}" data-parsley-remote="${symbol_dollar}{pageContext.request.contextPath}/utility/user/check/username?username={value}&user_id=${symbol_dollar}{user.id}" required="required" class="form-control custom-parsley-success" />
                  </div>
               </div>
               <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="firstname"><spring:message code="user.firstname" /> <span class="required">*</span> </label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                     <form:input path="firstname" type="text" required="required" class="form-control" />
                  </div>
               </div>
               <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="lastname"><spring:message code="user.lastname" /> <span class="required">*</span> </label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                     <form:input path="lastname" type="text" name="lastname" required="required" class="form-control" />
                  </div>
               </div>
               <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email"><spring:message code="user.email" /> <span class="required">*</span> </label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                     <spring:message code="user.email.already.exists" var="emailAlreadyExists" />
                     <form:input path="email" type="email" data-parsley-trigger="focusout" data-parsley-remote-validator="remote-validator-email" data-parsley-remote-message="${symbol_dollar}{emailAlreadyExists}" data-parsley-remote="${symbol_dollar}{pageContext.request.contextPath}/utility/user/check/email?email={value}&user_id=${symbol_dollar}{user.id}" required="required" class="form-control custom-parsley-success" />
                  </div>
               </div>
               <c:choose>
                  <c:when test="${symbol_dollar}{requestScope.view_type == 'create'}">
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="password"><spring:message code="user.password" /> <span class="required">*</span> </label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                           <form:input path="password" type="password" required="required" class="form-control" />
                        </div>
                     </div>
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="password"><spring:message code="user.password.repeat" /> <span class="required">*</span> </label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                           <input id="confirmPassword" name="confirmPassword" type="password" data-parsley-trigger="focusout" data-parsley-equalto="${symbol_pound}password" required="required" class="form-control" />
                        </div>
                     </div>
                  </c:when>
               </c:choose>

               <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="roles"><spring:message code="user.roles" /> <span class="required">*</span></label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                     <select id="roles" name="roles" multiple="multiple" data-parsley-validate-if-empty="true" data-parsley-errors-container="${symbol_pound}sel_error" data-parsley-class-handler=".select2-selection" required="required" class="select2_multiple form-control">
                        <%
                           List<Long> roles = new ArrayList<Long>();
                              for (Role role : ((User) pageContext.findAttribute("user")).getRoles()) {
                                 roles.add(role.getId());
                              }

                              for (Role role : (List<Role>) pageContext.findAttribute("availableRoles")) {
                                 if (roles.contains(role.getId())) {
                                    out.print(
                                          "<option value=${symbol_escape}"" + role.getId() + "${symbol_escape}" selected=${symbol_escape}"selected${symbol_escape}">" + role.getName() + "</option>");
                                 } else {
                                    out.print("<option value=${symbol_escape}"" + role.getId() + "${symbol_escape}">" + role.getName() + "</option>");
                                 }
                              }
                        %>
                     </select>
                     <div id="sel_error"></div>
                  </div>
               </div>

               <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="active"><spring:message code="user.active" /></label>
                  <div class="col-md-9 col-sm-9 col-xs-12">
                     <form:checkbox path="active" data-parsley-excluded="true" class="form-control js-switch" />
                  </div>
               </div>

               <c:choose>
                  <c:when test="${symbol_dollar}{requestScope.view_type == 'update'}">
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="password"><spring:message code="user.password.reset" /></label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                           <form:checkbox path="passwordExpired" data-parsley-excluded="true" class="form-control js-switch" />
                        </div>
                     </div>
                  </c:when>
               </c:choose>

               <div class="ln_solid"></div>
               <div class="form-group">
                  <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3 col-sm-offset-3">
                     <c:choose>
                        <c:when test="${symbol_dollar}{requestScope.view_type == 'create' or requestScope.view_type == 'update'}">
                           <form:button type="reset" class="btn btn-default">
                              <spring:message code="common.reset" />
                           </form:button>
                        </c:when>
                     </c:choose>

                     <a href="${symbol_dollar}{pageContext.request.contextPath}${symbol_dollar}{requestScope.action_cancel}" class="btn btn-info"><spring:message code="common.cancel" /></a>

                     <c:choose>
                        <c:when test="${symbol_dollar}{requestScope.view_type == 'create'}">
                           <form:button type="submit" class="btn btn-success">
                              <spring:message code="common.create" />
                           </form:button>
                        </c:when>
                        <c:when test="${symbol_dollar}{requestScope.view_type == 'update'}">
                           <form:button type="submit" class="btn btn-success">
                              <spring:message code="common.update" />
                           </form:button>
                        </c:when>
                        <c:when test="${symbol_dollar}{requestScope.view_type == 'delete'}">
                           <form:button type="submit" class="btn btn-danger">
                              <spring:message code="common.delete" />
                           </form:button>
                        </c:when>
                     </c:choose>
                  </div>
               </div>
            </form:form>
         </div>
      </div>
   </div>
</div>