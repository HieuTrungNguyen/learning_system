$(document).on('turbolinks:load', function () {
  $('#word_category_id').addClass('form-control');
});

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  var answers = document.getElementsByClassName('answer_field');
  if(answers.length < 4)
    $(link).parent().before(content.replace(regexp, new_id));
  else {
    alert(I18n.t('answer_not_more_4'))
  }
}

function remove_fields(link) {
  var answer = $(link).parent().parent();
  var answers = document.getElementsByClassName('answer_field');
  if(answers.length > 2){
    $(link).prev('input[type=hidden]').value = '1';
    $(link).closest('.form-group').remove();
  }
  else{
    alert(I18n.t('answer_not_less_2'))
  }
}
