 class PandaController < ApplicationController
  def verify_authenticity_token
    handle_unverified_request unless (form_authenticity_token == upload_payload['csrf'])
  end

  def upload_payload
    @upload_payload ||= JSON.parse(params['payload'])
  end

  def authorize_upload
    upload = Panda.post('/videos/upload.json', {
      file_name: upload_payload['filename'],
      file_size: upload_payload['filesize'],
      profiles: "h264",
    })

    render :json => {:upload_url => upload['location']}
  end

  def authorize_upload_postprocess

    upload = Panda.post('/videos/upload.json', {
      file_name: upload_payload['filename'],
      file_size: upload_payload['filesize'],
      profiles: "h264",
    })

    render :json => {:upload_url => upload['location'], :postprocess_url => "/videos/postprocess"}
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