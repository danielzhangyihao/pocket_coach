class CompaniesController < ApplicationController
before_action :signed_in_user
	def index
       @companies= Company.paginate(page: params[:page])
	end 

	def show
	   @company= Company.find(params[:id])
	   @instructors= @company.instructors
	end



	private

def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end
end
