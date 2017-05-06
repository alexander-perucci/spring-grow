#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<form:form modelAttribute="user" id="user_form" action="${symbol_dollar}{pageContext.request.contextPath}${symbol_dollar}{requestScope.action}" class="form-horizontal form-label-left" data-parsley-validate="data-parsley-validate"  method="POST">
   <form:hidden path="id" />
   <div class="form-group">
      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="username"><spring:message code="user.username" /></label>
      <div class="col-md-9 col-sm-9 col-xs-12">
         <form:input path="username" type="text" name="username" class="form-control" disabled="true" />
      </div>
   </div>
   <div class="form-group">
      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="firstname"><spring:message code="user.firstname" /><span class="required">*</span> </label>
      <div class="col-md-9 col-sm-9 col-xs-12">
         <form:input path="firstname" type="text" name="firstname" data-parsley-trigger="focusout" required="required" class="form-control" />
      </div>
   </div>
   <div class="form-group">
      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="lastname"><spring:message code="user.lastname" /><span class="required">*</span> </label>
      <div class="col-md-9 col-sm-9 col-xs-12">
         <form:input path="lastname" type="text" name="lastname" data-parsley-trigger="focusout" required="required" class="form-control" />
      </div>
   </div>
   <div class="form-group">
      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email"><spring:message code="user.email" /><span class="required">*</span> </label>
      <div class="col-md-9 col-sm-9 col-xs-12">
         <spring:message code="user.email.already.exists" var="emailAlreadyExists" />
         <form:input path="email" type="email" name="email" data-parsley-trigger="focusout" data-parsley-remote-validator="remote-validator-email" data-parsley-remote-message="${symbol_dollar}{emailAlreadyExists}" data-parsley-remote="${symbol_dollar}{pageContext.request.contextPath}/utility/user/check/email?email={value}&user_id=${symbol_dollar}{user.id}" class="form-control custom-parsley-success" required="required" />
      </div>
   </div>
   <div class="form-group margin_top_20">
      <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3 col-sm-offset-3">
         <form:button type="reset" class="btn btn-default">
            <spring:message code="common.reset" />
         </form:button>
         <form:button type="submit" class="btn btn-success">
            <spring:message code="common.update" />
         </form:button>
      </div>
   </div>
</form:form>

