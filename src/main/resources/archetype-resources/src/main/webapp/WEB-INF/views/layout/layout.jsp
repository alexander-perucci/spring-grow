#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<tiles:importAttribute scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title><spring:message code="common.application.name" /></title>

<link rel="icon" type="image/ico" href="${symbol_dollar}{pageContext.request.contextPath}/static/favicon.ico" />

<%@include file="layout_css.jsp"%>

<%-- jQuery - leave here because enables the use of ${symbol_dollar} on jsp pages that they use ${symbol_dollar}(document).ready(function() {...}); --%>
<script src="${symbol_dollar}{pageContext.request.contextPath}/static/gentelella/vendors/jquery/dist/jquery.min.js"></script>

<%-- Application --%>
<script src="${symbol_dollar}{pageContext.request.contextPath}/static/application.js"></script>

</head>

<body class="nav-md">
   <div class="container body">
      <div class="main_container">

         <%-- left navigation --%>
         <tiles:insertAttribute name="navigation_left" />
         <%-- /left navigation --%>

         <%-- top navigation --%>
         <tiles:insertAttribute name="navigation_top" />
         <%-- /top navigation --%>

         <%-- page content --%>
         <div class="right_col" role="main">
            <div class="">
               <%-- top content 
               <tiles:insertAttribute name="content_top" />--%>
               <%-- /top content --%>

               <%-- content --%>
               <tiles:insertAttribute name="content" />
               <%-- /content --%>
            </div>
         </div>
         <%-- /page content --%>

         <%-- footer content --%>
         <tiles:insertAttribute name="footer" />
         <%-- /footer content --%>
      </div>
   </div>
   <%@include file="layout_javascript.jsp"%>
</body>
</html>