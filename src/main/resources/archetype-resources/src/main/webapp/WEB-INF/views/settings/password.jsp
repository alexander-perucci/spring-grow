#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<form:form modelAttribute="user" id="user_form" action="${symbol_dollar}{pageContext.request.contextPath}${symbol_dollar}{requestScope.action}" class="form-horizontal form-label-left"  data-parsley-validate="data-parsley-validate" method="POST">
   <form:hidden path="id" />
   <div class="form-group">
      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="password"><spring:message code="user.password" /></label>
      <div class="col-md-9 col-sm-9 col-xs-12">
         <form:input path="password" type="password" class="form-control" disabled="true"/>
      </div>
   </div>
   <div class="form-group">
      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="newPassword"><spring:message code="user.password.new" /><span class="required">*</span> </label>
      <div class="col-md-9 col-sm-9 col-xs-12">
         <input id="newPassword" name="newPassword" type="password" data-parsley-trigger="focusout" required="required" class="form-control" />
      </div>
   </div>
   <div class="form-group">
      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="confirmPassword"><spring:message code="user.password.repeat" /><span class="required">*</span> </label>
      <div class="col-md-9 col-sm-9 col-xs-12">
         <input id="confirmPassword" name="confirmPassword" type="password" data-parsley-trigger="focusout" data-parsley-equalto="${symbol_pound}newPassword" required="required" class="form-control" />
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