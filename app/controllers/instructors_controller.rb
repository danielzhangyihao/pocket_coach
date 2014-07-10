class InstructorsController < ApplicationController

  def show
    @instructor = Instructor.find(params[:id])
  end

  def new
  	@instructor = Instructor.new
  end


  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @instructor
    else
      render 'new'
    end
  end

  private

    def instructor_params
      params.require(:instructor).permit(:name, :email, :password,
                                   :password_confirmation, :companyadmin, :facility)
    end
end