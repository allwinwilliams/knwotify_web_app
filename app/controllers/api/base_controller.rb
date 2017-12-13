class Api::BaseController < ActionController::Base

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found


  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  private

  def current_user
    if doorkeeper_token
      puts "current_resource_owner"
      return User.find_by_id(session[:current_user_id])
    end
    puts "no current_resource_owner"
    warden.authenticate(:scope => :user)
  end



end
