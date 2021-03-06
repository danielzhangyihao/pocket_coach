class UserInfosController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :new, :create]
  before_action :is_student, only: [:edit, :update, :new , :create]
  before_action :info_exist_user,  only: [:update]
  before_action :edit_info,  only: [:edit]
  before_action :correct_user,   only: [:update]
  before_action :right_user,   only: [:edit]
  before_action :no_info_user,   only: [:new, :create]


	def new
		@user_info =  UserInfo.new
	end 

	def create
    
    if current_user.user_info
      flash[:error] = "User info already exist!"
      redirect_to current_user
    else
    @user_info=current_user.build_user_info(user_info_params)
			if @user_info.save
               # Handle a successful save.
               flash[:success] = "User info created!"
               redirect_to current_user
            else
               render 'new'
            end
        end
    end

    
    def update
      @user_info=UserInfo.find(params[:id])
	    if @user_info.update_attributes(user_info_params)
            # Handle a successful save.
            flash[:success] = "User info updated"
            redirect_to current_user
        else
            render 'new'
        end
    end

    
    def edit
      @user_info=current_user.user_info
    end


   

    private

    def user_info_params
      params.require(:user_info).permit(:description, :feet, :inches,
                                   :weight,:school,:year,:position,:team)
    end

    def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end

    def correct_user
      @user_info = UserInfo.find(params[:id])
      @user=User.find(@user_info.user_id)
      redirect_to(root_url) unless current_user?(@user)
    end

    def right_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def no_info_user
      @user=current_user
      redirect_to(root_url) if @user.user_info
    end

    def info_exist_user
      redirect_to(root_url) unless UserInfo.exists?(params[:id])
    end

    def edit_info
      redirect_to(root_url) unless current_user.user_info
    end

    def is_student
      redirect_to(root_url) if current_user.attributes['facility']
    end





end 