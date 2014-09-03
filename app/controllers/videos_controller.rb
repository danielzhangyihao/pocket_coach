class VideosController < ApplicationController
  before_action :signed_in_user, only: [:index, :create , :new , :show]
  def show
    @video = Video.find(params[:id])
    @original_video = @video.panda_video
    @h264_encoding = @original_video.encodings['h264']
  end

  def new
    @video = Video.new
  end

  def create
    @video =current_user.videos.build(video_params)
    if @video.save
    #@video = Video.create!(video_params)
       redirect_to :action => :show, :id => @video.id
    else
      render 'new'
    end
  end

  def index
    @videos=Video.paginate(page: params[:page])
    @feed_items=Video.paginate(page: params[:page])
  end

  private
  def video_params
    params.require(:video).permit(:title, :panda_video_id)
  end

  def signed_in_user
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end

end