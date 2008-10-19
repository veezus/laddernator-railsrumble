// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(document).ready(function($) {
  $('a[rel*=facebox]').facebox()
  
  if($('#flash')) {
    setTimeout('hide_flash()', 10000);
  }
  
})

function hide_flash() {
  $('#flash').slideUp();
}
