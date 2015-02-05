$(document).ready(function() {
  $('#addTest').click( function(e){
    e.preventDefault();
    var $testBlock = $('<div>');
    var $input_label = $('<label for="testinput[]">Вход</label>')
    var $input = $('<input type="text" name="testinput[]">');
    var $output_label = $('<label for="testoutput[]">Изход</label>')
    var $output = $('<input type="text" name="testoutput[]">');
    var $remove_button = $('<button class="removeTest" onclick="$(this).parent().remove()" type="button">Премахни</button>');
    $testBlock.append($input_label);
    $testBlock.append($input);
    $testBlock.append($output_label);
    $testBlock.append($output);
    $testBlock.append($remove_button);
    $('#fieldWrapper').append($testBlock);
  })

  var password_alert = function(form, field) {
    if ($("input[name='" + field + "']").val() != $("input[name='password_confirmation'").val()) {
      if ($('.errorBlock').length == 0)
        $(form).before("<div class='errorBlock'>Паролата не съвпада!</div>");
      else
        $('.errorBlock').replaceWith("<div class='errorBlock'>Паролата не съвпада!</div>");
      return false;
    }
    return true;
  }

  $("input[name='role']").change( function() {
    if ( $(this).val() == 'teacher' ) {
      $('#fnBlock').hide();
      $('#fnBlock').val("");
    }
    else
      $('#fnBlock').show();
  })

  $("#registration-form").submit( function() {
    if (!(password_alert($(this), 'password')))
     return false;
  })

  $("#change-password").submit( function() {
    if (!(password_alert($(this), 'new_password')))
      return false;
  })

})