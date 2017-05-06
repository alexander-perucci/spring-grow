/* Fixed it by adding a parsley validate call on the select fields based on select2 event 'select2:select' */
   window.Parsley.on('form:validated', function(){
      $('select').on('change', function(e) {
          $(this).parsley().validate();
      });
  });
  
   window.Parsley.on('field:ajaxoptions', function(){
     this.$element.addClass('show-spinner')
  });
   
   window.Parsley.addAsyncValidator('remote-validator-username', function (xhr) {
      this.$element.removeClass('show-spinner')
      if ($.parseJSON(xhr.responseText).state === 'ERROR') {
          return false;
      } else {
          return true;
      }
  },'', {"dataType": "application/json"});
   
   
   window.Parsley.addAsyncValidator('remote-validator-email', function (xhr) {
      this.$element.removeClass('show-spinner')
      if ($.parseJSON(xhr.responseText).state === 'ERROR') {
          return false;
      } else {
          return true;
      }
  },'', {"dataType": "application/json"});
   
   
   // force reset parsley on form reset
   $("form").on("reset",function(ev){
      var targetJQForm = $(ev.target);
      setTimeout((function(){
         $(this).parsley().reset();
      }).bind(targetJQForm),0);
   });
