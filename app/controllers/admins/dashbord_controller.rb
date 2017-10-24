class Admins::DashbordController < ApplicationController
	before_action :authenticate_admin!
	def index
		@user_count = User.all.size
		@school_count = School.all.size
		@institution_count = Institution.all.size
		@month = get_day_in_month()
		@user_with_month= User.user_per_month(@month)
		@school_with_month= School.school_per_month(@month)
		@institution_with_month= Institution.institution_per_month(@month)
	end
	def get_day_in_month
		@day_in_month = []
		day = Time.days_in_month(Date.today.month,Date.today.year)
		(1..day).each{|i| @day_in_month << i}
		return @day_in_month
	end
	helper_method :get_day_in_month
end
