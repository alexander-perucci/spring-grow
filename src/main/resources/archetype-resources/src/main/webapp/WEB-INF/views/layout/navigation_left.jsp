#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<div class="col-md-3 left_col">
	<div class="left_col scroll-view">
	    <div class="navbar nav_title" style="border: 0;">
           <a href="${symbol_dollar}{pageContext.request.contextPath}/welcome" class="site_title">
           		<i class="fa fa-users"></i> <span><spring:message code="common.application.name" /></span>
           </a>
        </div>

        <div class="clearfix"></div>
        
        <%-- menu profile quick info --%>
        <div class="profile">
           <div class="profile_pic">
             <img class="avatar_image avatar_navigation_left" 
                  src="${symbol_dollar}{pageContext.request.contextPath}/utility/user/avatar/show" 
                  data_origin_src="${symbol_dollar}{pageContext.request.contextPath}/utility/user/avatar/show"
                  onerror="handleImageErrorLoad(this);"
                  data_error_src="${symbol_dollar}{pageContext.request.contextPath}/static/images/user-template_1.png"     
                  alt="<security:authentication property='principal.user.firstname' /> <security:authentication property='principal.user.lastname' />">
           </div>
           <div class="profile_info">
              <span><spring:message code="common.welcome" />,</span>
              <h2><security:authentication property="principal.user.firstname" /> <security:authentication property="principal.user.lastname" /></h2>
           </div>
        </div>
        <%-- /menu profile quick info --%>
        <div class="clearfix"></div>
        <%-- sidebar menu --%>
		<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
            <security:authorize access="hasAnyRole('administrator')">
			<div class="menu_section">
                <ul class="nav side-menu">
					<li><a><i class="fa fa-bug"></i><spring:message code="common.manage"/><span class="fa fa-chevron-down"></span></a>
						   <ul class="nav child_menu">
							   <li><a href="${symbol_dollar}{pageContext.request.contextPath}/administration/user/list"><spring:message code="users"/></a></li>
						   </ul>
                    </li>
					<%--
                        <li><a href="javascript:void(0)"><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a></li>
                    --%>
				</ul>
			</div>
            </security:authorize>
		</div>
		<%-- /sidebar menu --%>

		<%-- /menu footer buttons --%>
		<div class="sidebar-footer hidden-small">
			<a href="${symbol_dollar}{pageContext.request.contextPath}/settings/account" data-toggle="tooltip" data-placement="top" title="<spring:message code="settings" />" style="width: 50%;"> <span class="glyphicon glyphicon-cog" aria-hidden="true"></span></a> 
            <%--<a data-toggle="tooltip" data-placement="top" title="FullScreen"> <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span> </a>
            <a data-toggle="tooltip" data-placement="top" title="Lock"> <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span></a>--%>
            <a href="${symbol_dollar}{pageContext.request.contextPath}/j_spring_security_logout" data-toggle="tooltip" data-placement="top" title="<spring:message code="common.signout" />" style="width: 50%;"> <span class="glyphicon glyphicon-off" aria-hidden="true"></span></a>
		</div>
      
		<%-- /menu footer buttons --%>
	</div>
</div>
