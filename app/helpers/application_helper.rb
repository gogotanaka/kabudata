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

	def complete_time(time)
		wdays = ["日", "月", "火", "水", "木", "金", "土"]
		time.strftime("%Y年%m月%d日") + "(" + wdays[time.wday] + ")" + "　" + time.strftime("%H:%M:%S")
	end

	def complete_date(time)
		wdays = ["日", "月", "火", "水", "木", "金", "土"]
		time.strftime("%Y年%m月%d日") + "(" + wdays[time.wday] + ")"
	end

	def update_time(time)
		wdays = ["日", "月", "火", "水", "木", "金", "土"]
		time.strftime("%Y年%m月%d日") + "(" + wdays[time.wday] + ")" + "　" + time.strftime("%H")+ "時" + time.strftime("%M") + "分"
	end

	def week_count(array)
		tmp = 0
		array.each do |x|
			tmp = tmp + x
		end
		tmp
	end
end
