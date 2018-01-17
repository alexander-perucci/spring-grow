#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@include file="user_javascript.jsp"%>

<div class="row">
   <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
         <div class="x_title">
            <h2>
               <spring:message code="common.manage" />
               <spring:message code="users" />
            </h2>
            <ul class="nav navbar-right panel_toolbox">
               <li><a href="${symbol_dollar}{pageContext.request.contextPath}/administration/user/create"><i class="fa fa-plus"></i></a></li>
               <li><a href="javascript:findAllUsers()"><i class="fa fa-refresh"></i></a></li>
               <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
            </ul>
            <div class="clearfix"></div>
         </div>
         <div class="x_content">
            <p class="text-muted font-13 m-b-30"></p>
            <table id="user_list" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
               <thead>
                  <tr>
                     <th><spring:message code="user.username" /></th>
                     <th><spring:message code="user.firstname" /></th>
                     <th><spring:message code="user.lastname" /></th>
                     <th><spring:message code="user.email" /></th>
                     <th><spring:message code="common.actions" /></th>
                  </tr>
               </thead>
               <tfoot>
                  <tr>
                     <th><spring:message code="common.search.by" /> <spring:message code="user.username" /></th>
                     <th><spring:message code="common.search.by" /> <spring:message code="user.firstname" /></th>
                     <th><spring:message code="common.search.by" /> <spring:message code="user.lastname" /></th>
                     <th><spring:message code="common.search.by" /> <spring:message code="user.email" /></th>
                     <th></th>
                  </tr>
               </tfoot>
               <tbody>
               </tbody>
            </table>
            <div id="modal-expire-session" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
               <div class="modal-dialog modal-sm">
                  <div class="modal-content">
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">�</span>
                        </button>
                        <h4 class="modal-title" > <i class="fa fa-exclamation-triangle"></i> <spring:message code="common.caution" /></h4>
                     </div>
                     <div class="modal-body">
                        <h4><spring:message code="common.expire.session.message" /></h4>
                        <input type="hidden" name="bookId" id="bookId" value=""/>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="common.close" /> </button>
                        <a id="expire-session" href="" class="btn btn-warning"><i class="fa fa-trash"></i> <spring:message code="common.expire.session" /> </a>
                     </div>

                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>

