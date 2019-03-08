//= require active_admin/base
//= require jquery-fileupload/vendor/jquery.ui.widget
//= require jquery-fileupload/jquery.iframe-transport
//= require jquery-fileupload/jquery.fileupload
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require attachments
//= require active_admin/base
//= require tinymce

$(document).ready(function() {
  $(function() {
    if($.fn.cloudinary_fileupload !== undefined) {
      $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
    }
  });
  tinyMCE.init({
     selector: '.tinymce',
     toolbar: "undo redo | bold italic | numlist bullist | styleselect | alignleft aligncenter alignright alignjustify | indent outdent | forecolor backcolor | image",
     plugins: 'textcolor image lists',
     theme: 'modern',
      file_browser_callback: function(field_name, url, type, win) {
        var title_text;
        var cmsURL;

        if (type == 'image') {
          title_text = "Choose an Image"
          cmsURL = '/refinery/dialogs/image';
        } else {
          title_text = "Choose Object to Link"
          cmsURL = '/refinery/dialogs/link';
        }
        tinymce.activeEditor.windowManager.open({
          title: title_text,
          width: 860,
          height: 600,
          resizable: "yes"
        }, {
          window: win,
          input: field_name
        });
      }
   });
});
