module ApplicationHelper
	def markdown(content)
		@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true, strikethrough: true, superscript: true, highlight: true, footnotes: true)
		@markdown.render(content)
	end
	
	def icon
		['genderless','mars','mars-stroke','venus','mercury','transgender','transgender-alt','neuter','ban','mars-double','venus-double','venus-mars','tree','bed','bug','bolt','eye','flask','heart']
	end
end
