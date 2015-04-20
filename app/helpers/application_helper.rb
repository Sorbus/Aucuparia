module ApplicationHelper
	def markdown(content)
		@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true, strikethrough: true, superscript: true, highlight: true, footnotes: true)
		@markdown.render(content)
	end
	
	def icon
		['genderless','mars','mars-stroke','venus','mercury','transgender','transgender-alt','neuter','ban','mars-double','venus-double','venus-mars','tree','bed','bug','bolt','eye','flask','heart','paw']
	end
	
	def display_avatar(user, size)
		if !user.use_icon
			'<i class="fa fa-' + icon[user.icon.to_i] + ' fa-' + size + ' fa-fw"></i>'
		elsif user.avatar.nil?
			'<i class="fa fa-' + icon[user.icon.to_i] + ' fa-' + size + ' fa-fw"></i>'
		else
			if size == '4x'
				'<i class="user-image user-4x" style="' + 'background-image:url(' + user.avatar.x4.url + ')">&nbsp</i>'
			elsif size =='2x'
				'<i class="user-image user-2x" style="' + 'background-image:url(' + user.avatar.x2.url + ')">&nbsp</i>'
			elsif size =='1x'
				'<i class="user-image user-1x" style="' + 'background-image:url(' + user.avatar.x1.url + ')">&nbsp</i>'
			else
				'<i class="user-image user-' + size + '" style="' + 'background-image:url(' + user.avatar.x4.url + ')">&nbsp</i>'
			end
		end
	#	unless user.avatar.nil? 
	#		image_tag(user.avatar.file_name) 
	#	else
	#		image_tag("/path/to/fallback.jpg")
	#	end		
	end
	
	def display_badge(role)
		case role
		when :superadmin
			'<i class="fa fa-eye fa-lg" title="superadmin"></i>'.html_safe
		when :admin
			'<i class="fa fa-heartbeat fa-lg" title="administrator"></i>'.html_safe
		when :moderator
			'<i class="fa fa-legal fa-lg" title="moderator"></i>'.html_safe
		when :editor
			'<i class="fa fa-magic fa-lg" title="editor"></i>'.html_safe
		when :author
			'<i class="fa fa-pencil fa-lg" title="author"></i>'.html_safe
		when :commenter
			'<i class="fa fa-comment fa-lg" title="commenter"></i>'.html_safe
		else
			'no'
		end
	end
end
