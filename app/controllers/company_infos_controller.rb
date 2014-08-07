class CompanyInfosController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :new, :create]
  before_action :is_instructor, only: [:edit, :update, :new , :create]
  before_action :is_admin, only: [:edit, :update, :new , :create]
  before_action :info_exist_user,  only: [:update]
  before_action :edit_info,  only: [:edit]
  before_action :correct_user,   only: [:update, :edit]
  before_action :no_info_user,   only: [:new, :create]
  before_action :has_info_user, only: [:update, :edit]

	

	def new
		@company_info =  CompanyInfo.new
	end 

	def create
    
    if current_user.company.company_info
      flash[:error] = "company info already exist!"
      redirect_to facility_admin_url
    else
    @company_info=current_user.company.build_company_info(company_info_params)
			if @company_info.save
               # Handle a successful save.
               flash[:success] = "Company info created!"
               redirect_to facility_admin_url
            else
               render 'new'
            end
        end
    end

    
    def update
      @company_info=CompanyInfo.find(params[:id])
	    if @company_info.update_attributes(company_info_params)
            # Handle a successful save.
            flash[:success] = "Company info updated"
            redirect_to facility_admin_url
        else
            render 'new'
        end
    end

    
    def edit
      @company_info=current_user.company.company_info
    end


    private

    def company_info_params
      params.require(:company_info).permit(:description, :address, :telephone,
                                   :email,:price)
    end

    def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end

    def is_admin
        redirect_to(root_url) unless current_user.companyadmin?
    end

    def correct_user
      @company_info = CompanyInfo.find(params[:id])
      @company=Company.find(@company_info.company_id)
      redirect_to(root_url) unless current_user.company==@company
    end


    def no_info_user
      @instructor=current_user
      redirect_to(root_url) if @instructor.company.company_info
    end

    def has_info_user
    	@instructor=current_user
        redirect_to(root_url) unless @instructor.company.company_info

    end

    def info_exist_user
      redirect_to(root_url) unless CompanyInfo.exists?(params[:id])
    end


    def edit_info
      redirect_to(root_url) unless current_user.company.company_info
    end

    def is_instructor
      redirect_to(root_url) unless current_user.attributes['facility']
    end




	
end 