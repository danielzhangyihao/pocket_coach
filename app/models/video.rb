class Video < ActiveRecord::Base
  validates_presence_of :panda_video_id
  belongs_to :people, :polymorphic => true
  validates :people_id, presence: true

  def panda_video
    @panda_video ||= Panda::Video.find(panda_video_id)
  end
end
