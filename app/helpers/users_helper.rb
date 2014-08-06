module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def user_has_info?
      if current_user.user_info
        true
      else
        false
      end 
    end 

    def current_user
       remember_token = User.digest(cookies[:remember_token])
       if User.find_by(remember_token: remember_token)
         @current_user ||= User.find_by(remember_token: remember_token)
       else
         @current_user ||= Instructor.find_by(remember_token: remember_token)
       end  
    end 

    def current_student? 
      if current_user.attributes['facility']
        false
      else 
        true
      end
    end

    def current_user?(user)
      user == current_user
    end
  
end