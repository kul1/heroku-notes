# encoding: utf-8
class MembersController< ApplicationController

	
	def index
    @title= 'Member Sign In'
  end
	def new
    @title= 'Sign In'
  end

	def user_location
		# store location
		@location = request.location.city.present? ? request.location.city : 'localhost'
		user.location = @location
		user.save
	end

end
