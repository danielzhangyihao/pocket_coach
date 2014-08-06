class UserInfosController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :new, :create]
  before_action :info_exist_user,  only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :right_user,   only: [:new, :create]
  before_action :no_info_user,   only: [:new, :create]


	def new
		@user_info =  UserInfo.new
	end 

	def create
    if @user.user_info
      flash[:error] = "User info already exist!"
      redirect_to @user
    else
		@user_info = UserInfo.create(user_info_params)
    @user_info.user_id="0"
			if @user_info.save
               # Handle a successful save.
               @user.user_info=@user_info
               flash[:success] = "User info created!"
               redirect_to @user
            else
               render 'new'
            end
        end
    end

    
    def update
    @user = User.find(@user_info.user_id)

	    if @user_info.update_attributes(user_info_params)
            # Handle a successful save.
            flash[:success] = "User info updated"
            redirect_to @user
        else
            render 'new'
        end
    end

    
    def edit
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
      redirect_to(root_url) if @user.user_info
    end

    def info_exist_user
      redirect_to(root_url) unless UserInfo.exists?(params[:id])
    end





end 