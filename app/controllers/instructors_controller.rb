class InstructorsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def show
    @instructor = Instructor.find(params[:id])
  end

  def new
  	@instructor = Instructor.new
    @companies= Company.all
  end

  def edit
  end


  def index
    @instructors=Instructor.paginate(page: params[:page])
  end

  def update
    
    if @instructor.update_attributes(instructor_updateparams)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @instructor
    else
      render 'edit'
    end
  end



  def create
    
    company=Company.find_by_name(params[:instructor][:facility])
    
    if company 
      @instructor=company.instructors.build(instructor_params)
      if @instructor.save
         sign_in @instructor
         flash[:success] = "Welcome to the Sample App!"
         redirect_to @instructor
      else
         @companies= Company.all
         render 'new'
      end
    else 
      @company=Company.create(name: params[:instructor][:facility])
      @instructor=@company.instructors.build(instructor_params)
      if @instructor.save
         sign_in @instructor
         flash[:success] = "Welcome to the Sample App!"
         redirect_to @instructor
      else
         @companies= Company.all
         render 'new'
      end
        
    end
  end
    
 
   def destroy
    Instructor.find(params[:id]).destroy
    flash[:success] = "Instructor deleted."
    redirect_to instructors_url
   end

  private

    def instructor_params
      params.require(:instructor).permit(:name, :email, :password,
                                   :password_confirmation, :companyadmin, :facility)
    end

    def instructor_updateparams
      params.require(:instructor).permit(:name, :email, :password,
                                   :password_confirmation)
    end


     def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end

    def correct_user
      @instructor = Instructor.find(params[:id])
      redirect_to(root_url) unless current_user?(@instructor)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end