// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require turboboost
//= require_tree .

$(window).on('popstate', function () {
	$.get(document.location.href)
});

$(function() {
	$(document).on('ajax:before', function() {
		$('#spinner').removeClass('hidden');
		$('#yield').addClass('faded');
	});
	
	$(document).bind('ajaxComplete', function() {
		$('#spinner').addClass('hidden');
		$('#yield').removeClass('faded');
		document.title = title;
	});
});

//setInterval(function() {
//    $.ajax({
//		url: '/messages/refresh',
//		type: 'GET',
//		success: function(result) {
//		}
//	});
//	title = $(document).find("title").text();
//}, 600000);