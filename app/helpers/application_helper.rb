module ApplicationHelper

	def title(text)
  		content_for :title, text
	end

	def description(text)
  		content_for :description, text
	end

end
