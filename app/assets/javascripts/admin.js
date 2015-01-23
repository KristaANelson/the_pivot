$(".dropdown-menu li a").click(function(){
  $(this).parents(".btn-group").find('.selection').text($(this).text());
  $(this).parents(".btn-group").find('.selection').val($(this).text());
});

$('#selector button').click(function() {
  $(this).addClass('active').siblings().removeClass('active');
});

$('input[name="name-of-radio-group"]').change( function() {
  alert($(this).val());
});
