$(document).ready(function() {
  $('.render-subject-form').click(function(){
    formURL = $(this).attr('data-url');
    $.ajax({
      url: formURL,
      type: 'GET',
      datatype: 'html',
      success: function(data, textStatus ){
        $('#subject-form-modal').html(data);
      }
    });
  });

  $('#subject-form-modal').on('click', '.btn-form-subject', function(){
    $form = $(this).parent().closest('form')
    formURL = $form.attr('action');
    postData = $form.serialize();
    $.ajax({
      url: formURL,
      type: 'POST',
      data: postData,
      datatype: 'json',
      success: function(data, textStatus){
      },
      error: function(xhr, textStatus, errorThrown){
        $form.clear_form_errors();
        $form.render_form_errors($.parseJSON(xhr.responseText));
      }
    });
  });

  $.fn.render_form_errors = function(errors){
    $.each(errors, function(field, messages){
      $input = $('input[name="subject[' + field + ']"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block')
        .append(messages.join('</br>'));
    });
  };

  $.fn.clear_form_errors = function(){
    $('.form-group.has-error', this).each(function(){
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    });
  }
});
