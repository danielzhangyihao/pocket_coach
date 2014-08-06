class InstructorInfosController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :new, :create]
  before_action :is_instructor, only: [:edit, :update, :new , :create]
  before_action :info_exist_user,  only: [:update]
  before_action :edit_info,  only: [:edit]
  before_action :correct_user,   only: [:update]
  before_action :right_user,   only: [:edit]
  before_action :no_info_user,   only: [:new, :create]


	def new
		@instructor_info =  InstructorInfo.new
	end 

	def create
    
    if current_user.instructor_info
      flash[:error] = "User info already exist!"
      redirect_to current_user
    else
    @instructor_info=current_user.build_instructor_info(instructor_info_params)
			if @instructor_info.save
               # Handle a successful save.
               flash[:success] = "Instructor info created!"
               redirect_to current_user
            else
               render 'new'
            end
        end
    end

    
    def update
      @instructor_info=InstructorInfo.find(params[:id])
	    if @instructor_info.update_attributes(instructor_info_params)
            # Handle a successful save.
            flash[:success] = "Instructor info updated"
            redirect_to current_user
        else
            render 'new'
        end
    end

    
    def edit
      @instructor_info=current_user.instructor_info
    end


   

    private

    def instructor_info_params
      params.require(:instructor_info).permit(:description, :price)
    end

    def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end

    def correct_user
      @instructor_info = InstructorInfo.find(params[:id])
      @instructor=Instructor.find(@instructor_info.instructor_id)
      redirect_to(root_url) unless current_user?(@instructor)
    end

    def right_user
      @instructor = Instructor.find(params[:id])
      redirect_to(root_url) unless current_user?(@instructor)
    end

    def no_info_user
      @instructor=current_user
      redirect_to(root_url) if @instructor.instructor_info
    end

    def info_exist_user
      redirect_to(root_url) unless InstructorInfo.exists?(params[:id])
    end

    def edit_info
      redirect_to(root_url) unless current_user.instructor_info
    end

    def is_instructor
      redirect_to(root_url) unless current_user.attributes['facility']
    end



	
end 