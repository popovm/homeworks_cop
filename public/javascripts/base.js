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

  $("input[name='role']").change( function() {
    if ( $(this).val() == 'teacher' ) {
      $('#fnBlock').hide();
      $('#fnBlock').val("");
    }
    else
      $('#fnBlock').show();
  })

  $("#registration-form").submit( function() {
    if ($("input[name='password'").val() != $("input[name='password_confirmation'").val()) {
      if ($('.errorBlock').length == 0)
        $(this).before("<div class='errorBlock'>Паролата не съвпада!</div>");
      else
        $('.errorBlock').replaceWith("<div class='errorBlock'>Паролата не съвпада!</div>");
      return false;
    }
  })
})