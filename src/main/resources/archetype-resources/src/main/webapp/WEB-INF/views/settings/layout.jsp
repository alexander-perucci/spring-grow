#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<%@include file="settings_javascript.jsp"%>

<div class="row">
   <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
         <div class="x_title">
            <h2>
               <spring:message code="settings" />
            </h2>
            <ul class="nav navbar-right panel_toolbox">
               <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
            </ul>
            <div class="clearfix"></div>
         </div>
         <div class="x_content">
            <div class="col-md-3 col-sm-12 col-xs-12" id="crop-avatar">
               <div class="row">
                  <%-- Current avatar --%>
                  <div class="avatar-view">
                     <div id="avatarTooltip" class="animate slideInUp">                     
                        <div id="avatarTooltipContent">
                           <div id="avatarTooltipContentIcon" class="animate zoomIn">
                              <span class="fa fa-camera"></span>
                           </div>
                           <div id="avatarTooltipContentDescription">
                              <span><spring:message code='settings.avatar.change'/></span>
                           </div>
                        </div>
                     </div>
                     <img class="avatar_image" src="${symbol_dollar}{pageContext.request.contextPath}/utility/user/avatar/show"
                                               data_origin_src="${symbol_dollar}{pageContext.request.contextPath}/utility/user/avatar/show"
                                               onerror="handleImageErrorLoad(this);"
                                               data_error_src="${symbol_dollar}{pageContext.request.contextPath}/static/images/user-template_1.png"
                                               alt="<security:authentication property='principal.user.firstname' /> <security:authentication property='principal.user.lastname' />">
                  </div>
               
                  <div id="avatar-modal" class="modal fade" tabindex="-1" aria-labelledby="avatar-modal-label" role="dialog" aria-hidden="true">
                     <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                           <form class="avatar-form" action="${symbol_dollar}{pageContext.request.contextPath}/utility/user/avatar/update" enctype="multipart/form-data" method="POST">
                              <div class="modal-header">
                                 <button type="button" class="close" data-dismiss="modal">&times;</button>
                                 <h4 class="modal-title" id="avatar-modal-label">
                                    <spring:message code="settings.avatar.change" />
                                 </h4>
                              </div>
                              <div class="modal-body">
                                 <div class="avatar-body">

                                    <%-- Upload image and data --%>
                                    <div class="avatar-upload">
                                       <input type="hidden" class="avatar-src" name="avatar_src"> <input type="hidden" class="avatar-data" name="avatar_data"> <label for="avatarInput"><spring:message code="settings.avatar.upload" /></label> <input type="file" class="avatar-input" id="avatarInput" name="avatar_file" accept="image/*">
                                    </div>

                                    <%-- Crop and preview --%>
                                    <div class="row">
                                       <div class="col-md-9">
                                          <div class="avatar-wrapper"></div>
                                       </div>
                                       <div class="col-md-3">
                                          <div class="avatar-preview preview-lg"></div>
                                          <div class="avatar-preview preview-md"></div>
                                          <div class="avatar-preview preview-sm"></div>
                                       </div>
                                    </div>

                                    <div class="row avatar-btns">
                                       <div class="col-md-9">
                                          <div class="btn-group">
                                             <button type="button" class="btn btn-primary" data-method="zoom" data-option="0.1" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.zoom.in'/>">
                                                <span class="fa fa-search-plus"></span>
                                             </button>
                                             <button type="button" class="btn btn-primary" data-method="zoom" data-option="-0.1" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.zoom.out'/>">
                                                <span class="fa fa-search-minus"></span>
                                             </button>
                                          </div>

                                          <div class="btn-group">
                                             <button type="button" class="btn btn-primary" data-method="move" data-option="-10" data-second-option="0" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.move.left'/>">
                                                <span class="fa fa-arrow-left"></span>
                                             </button>
                                             <button type="button" class="btn btn-primary" data-method="move" data-option="10" data-second-option="0" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.move.right'/>">
                                                <span class="fa fa-arrow-right"></span>
                                             </button>
                                             <button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="-10" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.move.up'/>">
                                                <span class="fa fa-arrow-up"></span>
                                             </button>
                                             <button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="10" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.move.down'/>">
                                                <span class="fa fa-arrow-down"></span>
                                             </button>
                                          </div>

                                          <div class="btn-group">
                                             <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.rotate.left'/>">
                                                <span class="fa fa-rotate-left"></span>
                                             </button>
                                             <button type="button" class="btn btn-primary" data-method="rotate" data-option="90" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.rotate.right'/>">
                                                <span class="fa fa-rotate-right"></span>
                                             </button>
                                          </div>

                                          <div class="btn-group">
                                             <button type="button" class="btn btn-primary" data-method="scaleX" data-option="-1" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.flip.horizontal'/>">
                                                <span class="fa fa-arrows-h"></span>
                                             </button>
                                             <button type="button" class="btn btn-primary" data-method="scaleY" data-option="-1" data-toggle="tooltip" title="<spring:message code='settings.avatar.method.flip.vertical'/>">
                                                <span class="fa fa-arrows-v"></span>
                                             </button>
                                          </div>

                                       </div>
                                       <div class="col-md-3">
                                          <button type="submit" class="btn btn-success btn-block avatar-save">
                                             <spring:message code="common.update" />
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </form>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="row margin_top_20 margin_bottom_20 ">
                  <ul class="nav nav-pills nav-stacked">
                     <li class="${symbol_dollar}{'account' == requestScope.active ? 'active' : 'none'}"><a href="${symbol_dollar}{pageContext.request.contextPath}/settings/account"><spring:message code="settings.account" /></a></li>
                     <li class="${symbol_dollar}{'password' == requestScope.active ? 'active' : 'none'}"><a href="${symbol_dollar}{pageContext.request.contextPath}/settings/password"><spring:message code="settings.password" /></a></li>
                  </ul>
               </div>
            </div>
            <div class="col-md-9 col-sm-12 col-xs-12">
               <%-- content --%>
               <tiles:insertAttribute name="settings_content" />
               <%-- /content --%>
            </div>
            <div class="clearfix"></div>
         </div>
      </div>
   </div>
</div>
