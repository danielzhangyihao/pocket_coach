module InstructorsHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(instructor, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(instructor.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: instructor.name, class: "gravatar")
  end

  def instructor_has_info?
      if current_user.instructor_info
        true
      else
        false
      end 
    end 
end