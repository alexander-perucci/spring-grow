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
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="col-md-12 col-sm-12 col-xs-12">
          <div class="col-middle">
            <div class="text-center text-center">
              <h1 class="error-number">403</h1>
              <h2><spring:message code="common.failure.accessdenied" /></h2>
              <p><spring:message code="common.failure.accessdenied.message" /> <a href="${symbol_dollar}{pageContext.request.contextPath}/welcome"><spring:message code="common.home" /></a>
              </p>
            </div>
          </div>
        </div>
        <!-- /page content -->
      </div>
    </div>
  </body>
</html>