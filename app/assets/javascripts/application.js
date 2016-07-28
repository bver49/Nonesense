// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.Jcrop
//= require masonry
//= require semantic-ui
//= require imageloaded
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).ready(function(){

	$('.scrollToTop').hide();
	$(window).scroll(function(){
		if ($(this).scrollTop() > 100) {
			$('.scrollToTop').fadeIn();
      $('.topmenu').css('background','rgba(255,255,255,0.8)');
		} else {
			$('.scrollToTop').fadeOut();
      $('.topmenu').css('background','rgba(255,255,255,1)');
		}
	});
	$('.scrollToTop').click(function(){
		$('html, body').animate({scrollTop : 0},800);
		return false;
	});
});
