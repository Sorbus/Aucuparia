# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	button = $("#category[name]")
	button.on "click", ->
		button.preventDefault();
		button.prop('readonly', true)
		console.log('clicked')
		alert 'clicked'
	console.log('...')