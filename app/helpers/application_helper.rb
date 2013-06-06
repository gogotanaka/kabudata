module ApplicationHelper
	def compare(previous, current)
		diff = previous.gsub(/(\d{0,3}),(\d{3})/, '\1\2').to_i - current.gsub(/(\d{0,3}),(\d{3})/, '\1\2').to_i
		diffcomma = diff.to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\1,')
		if diff > 0
			diffcomma = "+" + diffcomma
			return "<p class='plus'>#{diffcomma}</p>".html_safe
		else
			return "<p class='minus'>#{diffcomma}</p>".html_safe
		end
	end
end
