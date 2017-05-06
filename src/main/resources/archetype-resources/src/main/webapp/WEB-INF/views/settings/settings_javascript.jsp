#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript" charset="utf-8">
   function CropAvatar(${symbol_dollar}element) {
      this.${symbol_dollar}container = ${symbol_dollar}element;

      this.${symbol_dollar}avatarView = this.${symbol_dollar}container.find('.avatar-view');
      this.${symbol_dollar}allAvatar = ${symbol_dollar}('.avatar_image');
      this.${symbol_dollar}avatar = this.${symbol_dollar}avatarView.find('img');
      this.${symbol_dollar}avatarTooltip = this.${symbol_dollar}avatarView.find('${symbol_pound}avatarTooltip');
      this.${symbol_dollar}avatarModal = this.${symbol_dollar}container.find('${symbol_pound}avatar-modal');
      this.${symbol_dollar}avatarForm = this.${symbol_dollar}avatarModal.find('.avatar-form');
      this.${symbol_dollar}avatarUpload = this.${symbol_dollar}avatarForm.find('.avatar-upload');
      this.${symbol_dollar}avatarSrc = this.${symbol_dollar}avatarForm.find('.avatar-src');
      this.${symbol_dollar}avatarData = this.${symbol_dollar}avatarForm.find('.avatar-data');
      this.${symbol_dollar}avatarInput = this.${symbol_dollar}avatarForm.find('.avatar-input');
      this.${symbol_dollar}avatarSave = this.${symbol_dollar}avatarForm.find('.avatar-save');
      this.${symbol_dollar}avatarBtns = this.${symbol_dollar}avatarForm.find('.avatar-btns');

      this.${symbol_dollar}avatarWrapper = this.${symbol_dollar}avatarModal.find('.avatar-wrapper');
      this.${symbol_dollar}avatarPreview = this.${symbol_dollar}avatarModal.find('.avatar-preview');

      this.init();
   }

   ${symbol_dollar}(document)
         .ready(
               function() {
                  CropAvatar.prototype = {
                     constructor : CropAvatar,

                     support : {
                        fileList : !!${symbol_dollar}('<input type="file">').prop('files'),
                        blobURLs : !!window.URL && URL.createObjectURL,
                        formData : !!window.FormData
                     },

                     init : function() {
                        this.support.datauri = this.support.fileList
                              && this.support.blobURLs;

                        if (!this.support.formData) {
                           this.initIframe();
                        }

                        this.initModal();
                        this.addListener();
                     },

                     addListener : function() {
                        this.${symbol_dollar}avatarTooltip.on('click', ${symbol_dollar}.proxy(this.click,
                              this));
                        this.${symbol_dollar}avatarInput.on('change', ${symbol_dollar}.proxy(this.change,
                              this));
                        this.${symbol_dollar}avatarForm.on('submit', ${symbol_dollar}
                              .proxy(this.submit, this));
                        this.${symbol_dollar}avatarBtns.on('click', '[data-method]', ${symbol_dollar}.proxy(
                              this.methods, this));
                     },

                     initModal : function() {
                        this.${symbol_dollar}avatarModal.modal({
                           show : false
                        });
                        var _this = this;
                        this.${symbol_dollar}avatarModal.on('shown.bs.modal', function() {
                           _this.${symbol_dollar}avatarSave.prop("disabled", true);
                        })
                     },

                     initPreview : function() {
                        var url = this.${symbol_dollar}avatar.attr('src');

                        this.${symbol_dollar}avatarPreview.html('<img src="' + url + '">');
                     },

                     initIframe : function() {
                        var target = 'upload-iframe-' + (new Date()).getTime();
                        var ${symbol_dollar}iframe = ${symbol_dollar}('<iframe>').attr({
                           name : target,
                           src : ''
                        });
                        var _this = this;

                        // Ready ifrmae
                        ${symbol_dollar}iframe.one('load', function() {

                           // respond response
                           ${symbol_dollar}iframe.on('load', function() {
                              var data;

                              try {
                                 data = ${symbol_dollar}(this).contents().find('body').text();
                              } catch (e) {
                                 console.log(e.message);
                              }

                              if (data) {
                                 try {
                                    data = ${symbol_dollar}.parseJSON(data);
                                 } catch (e) {
                                    console.log(e.message);
                                 }

                                 _this.submitDone(data);
                              } else {
                                 _this.submitFail('Image upload failed!');
                              }

                              _this.submitEnd();

                           });
                        });

                        this.${symbol_dollar}iframe = ${symbol_dollar}iframe;
                        this.${symbol_dollar}avatarForm.attr('target', target).after(
                              ${symbol_dollar}iframe.hide());
                     },

                     click : function() {
                        this.${symbol_dollar}avatarModal.modal('show');
                        this.initPreview();
                     },

                     change : function() {
                        var files;
                        var file;

                        if (this.support.datauri) {
                           files = this.${symbol_dollar}avatarInput.prop('files');

                           if (files.length > 0) {
                              file = files[0];

                              if (this.isImageFile(file)) {
                                 if (this.url) {
                                    URL.revokeObjectURL(this.url); // Revoke the old
                                    // one
                                 }

                                 this.url = URL.createObjectURL(file);
                                 this.startCropper();
                                 this.enableSaveBtn();
                              } else {
                                 showMessage(
                                             'error',
                                             "<spring:message code='common.error' />",
                                             "<spring:message code='settings.avatar.select.error.message' />");
                                 this.disableSaveBtn();
                              }
                           }
                        } else {
                           file = this.${symbol_dollar}avatarInput.val();

                           if (this.isImageFile(file)) {
                              this.syncUpload();
                              this.enableSaveBtn();
                           } else {
                              showMessage(
                                          'error',
                                          "<spring:message code='common.error' />",
                                          "<spring:message code='settings.avatar.select.error.message' />");
                              this.disableSaveBtn();
                           }
                        }
                     },

                     submit : function() {
                        if (!this.${symbol_dollar}avatarSrc.val() && !this.${symbol_dollar}avatarInput.val()) {
                           return false;
                        }

                        if (this.support.formData) {
                           this.ajaxUpload();
                           return false;
                        }
                     },

                     methods : function(e) {
                        var data;

                        if (this.active) {
                           data = ${symbol_dollar}(e.target).data();

                           if (data.method) {
                              this.${symbol_dollar}img.cropper(data.method, data.option,
                                    data.secondOption);
                           }

                           // change the data value in case of scaleX and scaleY
                           switch (data.method) {
                           case 'scaleX':
                           case 'scaleY':
                              ${symbol_dollar}(e.target).data('option', -data.option);
                              break;
                           }
                        }
                     },

                     isImageFile : function(file) {
                        if (file.type) {
                           return /^image${symbol_escape}/${symbol_escape}w+${symbol_dollar}/.test(file.type);
                        } else {
                           return /${symbol_escape}.(jpg|jpeg|png|gif)${symbol_dollar}/.test(file);
                        }
                     },

                     startCropper : function() {
                        var _this = this;

                        if (this.active) {
                           this.${symbol_dollar}img.cropper('replace', this.url);
                        } else {
                           this.${symbol_dollar}img = ${symbol_dollar}('<img src="' + this.url + '">');
                           this.${symbol_dollar}avatarWrapper.empty().html(this.${symbol_dollar}img);
                           this.${symbol_dollar}img.cropper({
                              aspectRatio : 1,
                              viewMode : 1,
                              dragMode : 'move',
                              autoCropArea : 0.65,
                              restore : true,
                              guides : true,
                              highlight : true,
                              cropBoxMovable : true,
                              cropBoxResizable : false,
                              preview : this.${symbol_dollar}avatarPreview.selector,
                              crop : function(e) {
                                 var json = [ '{"x":' + e.x, '"y":' + e.y,
                                       '"height":' + e.height,
                                       '"width":' + e.width,
                                       '"scaleX":' + e.scaleX,
                                       '"scaleY":' + e.scaleY,
                                       '"rotate":' + e.rotate + '}' ].join();
                                 _this.${symbol_dollar}avatarData.val(json);
                              }
                           });

                           this.active = true;
                        }

                        this.${symbol_dollar}avatarModal.one('hidden.bs.modal', function() {
                           _this.${symbol_dollar}avatarPreview.empty();
                           _this.stopCropper();
                        });
                     },

                     stopCropper : function() {
                        if (this.active) {
                           this.${symbol_dollar}avatarForm.trigger("reset");
                           this.${symbol_dollar}img.cropper('destroy');
                           this.${symbol_dollar}img.remove();
                           this.active = false;
                        }
                     },

                     ajaxUpload : function() {
                        var url = this.${symbol_dollar}avatarForm.attr('action');
                        var data = new FormData(this.${symbol_dollar}avatarForm[0]);
                        data.append('avatar_data', new Blob([ this.${symbol_dollar}avatarData
                              .val()
                              || null ], {
                           type : "application/json"
                        }));

                        var _this = this;

                        ${symbol_dollar}.ajax(url, {
                           type : 'POST',
                           data : data,
                           dataType : 'json',
                           processData : false,
                           contentType : false,

                           beforeSend : function() {
                              _this.submitStart();
                           },

                           success : function(data) {
                              _this.submitDone(data);
                           },

                           error : function(XMLHttpRequest, textStatus,
                                 errorThrown) {
                              _this.submitFail(textStatus || errorThrown);
                           },

                           complete : function() {
                              _this.submitEnd();
                           }
                        });
                     },

                     syncUpload : function() {
                        this.${symbol_dollar}avatarSave.click();
                     },

                     submitStart : function() {

                     },

                     submitDone : function(data) {
                        if (${symbol_dollar}.isPlainObject(data) && data.state === 'SUCCESS') {
                           showMessage(
                                       'success',
                                       "<spring:message code='common.success' />",
                                       "<spring:message code='settings.avatar.upload.success.message' />");
                           this.cropDone();
                        } else {
                           this.submitFail(data.error);
                        }

                     },

                     submitFail : function(errorMessage) {
                        showMessage('error',
                                    "<spring:message code='common.error' />",
                                    "<spring:message code='settings.avatar.upload.error.message' />");
                        this.url = '';
                        this.stopCropper();
                        this.startCropper();
                     },

                     submitEnd : function() {
                     },

                     cropDone : function() {
                        this.${symbol_dollar}avatarForm.get(0).reset();
                        this.stopCropper();
                        this.${symbol_dollar}allAvatar.each(function(i, obj) {
                           ${symbol_dollar}(obj).attr(
                                 'src',
                                 ${symbol_dollar}(obj).attr('data_origin_src') + '?'
                                       + (new Date()).getTime());
                        });
                        this.${symbol_dollar}avatarModal.modal('hide');
                     },

                     enableSaveBtn : function() {
                        this.${symbol_dollar}avatarSave.prop("disabled", false);
                     },
                     disableSaveBtn : function() {
                        this.${symbol_dollar}avatarSave.prop("disabled", true);
                     },
                  };

                  // initialize CropAvatar
                  ${symbol_dollar}(function() {
                     return new CropAvatar(${symbol_dollar}('${symbol_pound}crop-avatar'));
                  });
                  
                  if(${symbol_dollar}{not empty param.success and param.success}) {
                     showMessage("success", "<spring:message code='common.success' />", "<spring:message code='common.success.message' />");
              	  }
                  
               });
</script>