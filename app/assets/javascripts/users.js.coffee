# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready ->
	input = $("#user_old_password")
	input.on "input", ->
		if (input.val().length > 4)
			$("#user_email").prop('readonly', false)
			$("#user_password").prop('readonly', false)
			$("#user_password_confirmation").prop('readonly', false)
			console.log('true')
		else
			$("#user_email").attr('readonly', true)
			$("#user_password").attr('readonly', true)
			$("#user_password_confirmation").attr('readonly', true)
			console.log('false')