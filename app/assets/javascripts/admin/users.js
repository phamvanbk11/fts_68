$(document).ready(function() {
  $('.role-switch').bootstrapSwitch();
  $('input.role-switch').on('switchChange.bootstrapSwitch', function(event, state) {
    $form = $(this).parent().closest('form')
    formURL = $form.attr('action');
    postData = $form.serialize();
    $.ajax({
      url: formURL,
      type: 'POST',
      data: postData,
      datatype: 'json'
    });
  });
});
