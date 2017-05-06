#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8">
    function findAllUsers(){
       ${symbol_dollar}('${symbol_pound}user_list').dataTable({
      	  "destroy": true,
          "bProcessing": true,
          "bServerSide": true,
          "sPaginationType": "full_numbers",
          "sAjaxDataProp": "rows",
          "aoColumns": [
              {"mData": "username"}, 
              {"mData": "firstname"},
              {"mData": "lastname"},
              {"mData": "email"},
              {"sName": "Actions",
                 "bSearchable": false,
                 "bSortable": false,
                 "sDefaultContent": "",
                 "mRender":  function(data, type, full){
                    return "<a href='${symbol_dollar}{pageContext.request.contextPath}/administration/user/update?id=" + full['id'] + "' class='btn btn-primary btn-xs'><i class='fa fa-folder'></i> <spring:message code='common.update' /> </a> "+
                           "<a href='${symbol_dollar}{pageContext.request.contextPath}/administration/user/delete?id=" + full['id'] + "' class='btn btn-danger btn-xs'><i class='fa fa-trash'></i> <spring:message code='common.delete' /> </a>"+
                           "<a data-href='${symbol_dollar}{pageContext.request.contextPath}/administration/user/expire/session?id=" + full['id'] + "' class='btn btn-warning btn-xs open-modal-expire-session'><i class='fa fa-sign-out'></i> <spring:message code='common.expire.session' /></a>";
                 }
             }
          ],
          "sAjaxSource": "${symbol_dollar}{pageContext.request.contextPath}/administration/user/findallpaginated",
          "oLanguage": {"sUrl": "${symbol_dollar}{pageContext.request.contextPath}/static/plugin_extension/datatables/i18n/datatables-${symbol_dollar}{pageContext.response.locale}.properties"},
          "fnServerParams": addparams,
          "fnServerData": function ( sSource, aoData, fnCallback, oSettings ) {
             oSettings.jqXHR = ${symbol_dollar}.ajax( {
               "dataType": 'json',
               "type": "POST",
               "url": sSource,
               "data": aoData,
               "success":  function (json) {
                  fnCallback(json.result);
               },
               "error": function (e) {
                   console.log(e.message);
               }
             });
           },
          "initComplete": function( settings, json ) {
             ${symbol_dollar}(".open-modal-expire-session").on("click", function () {
                ${symbol_dollar}(".modal-footer ${symbol_pound}expire-session").attr("href", ${symbol_dollar}(this).data('href'));
                ${symbol_dollar}("${symbol_pound}modal-expire-session").modal('show');
          	 });
           }
      }).columnFilter({
         aoColumns: [{type: "text"},
            {type: "text"},
            {type: "text"},
            {type: "text"},
            null
        ]});
       
    }
    
    
    ${symbol_dollar}(document).ready(function() {
       switch('${symbol_dollar}{requestScope.view_type}') {
       case 'list': //manage the page user_list.jsp
          findAllUsers();
          
       	  if(${symbol_dollar}{not empty param.success and param.success}) {
             showMessage("success", "<spring:message code='common.success' />", "<spring:message code='common.success.message' />");
      	  }
          
          break;
       case 'create':
          ${symbol_dollar}("${symbol_pound}user_form").parsley()
          break;
       case 'update':
          ${symbol_dollar}("${symbol_pound}user_form").parsley()
          break;
       case 'delete':
          ${symbol_dollar}(":input[type='text']").each(function () { ${symbol_dollar}(this).attr('disabled','disabled'); });
      	  ${symbol_dollar}(":input[type='email']").each(function () { ${symbol_dollar}(this).attr('disabled','disabled'); });
      	  ${symbol_dollar}(":input[type='password']").each(function () { ${symbol_dollar}(this).attr('disabled','disabled'); });
      	  ${symbol_dollar}(":input[type='checkbox']").each(function () { ${symbol_dollar}(this).attr('disabled','disabled'); });
          ${symbol_dollar}("${symbol_pound}roles").prop("disabled", true);
          break;
   		}
         
	});
   
</script>