#encoding: UTF-8

module ApplicationHelper

  def flash_class(type)
    case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      else
        type.to_s
    end
  end

  def parse_error_messages(object)
    session[:error_messages] ||= ""
    object.errors.messages.each do |key, msg|
      msg.each do |one_msg|
        #reprise de contrôle des messages gérés par password_digest
        if !one_msg.eql?("can't be blank") && !one_msg.eql?("doesn't match confirmation")
          session[:error_messages] += one_msg + ";"
        end
      end
    end
  end



  private

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def check_login
    unless request.path == login_path || request.path == sessions_path || request.path == signup_path || request.path == users_path
      if !cookies[:auth_token].nil? && !User.find_by_auth_token(cookies[:auth_token])
        flash[:error] = "Votre compte n'existe plus."
        session[:user_id] = nil
        redirect_to login_path
      else
        if current_user.nil?
          flash[:warning] = "Veuillez vous identifier."
          redirect_to login_path
        end
      end
    end
  end
end
