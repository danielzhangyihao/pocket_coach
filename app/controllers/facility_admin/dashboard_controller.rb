class FacilityAdmin::DashboardController < ApplicationController
  before_action :signed_in_user 
  before_action :not_student
  before_action :admin_panel_delete 

  def index
  	company=current_user.company
  	@instructors= company.instructors
  end


private

def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end

def admin_panel_delete
      redirect_to(root_url) unless current_user.admin? || current_user.companyadmin?

    end

    def not_student
      if current_user.attributes['facility']
        
      else
        redirect_to(root_url)
      end
    end
end
