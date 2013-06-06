class AdminController < ApplicationController

	def board
	end

	def blog
	end

	def stock
	end

	def mail
		@mail = Mailaddress.all
	end

	def inquiry
		@inquiry = Inquiry.all
	end
end
