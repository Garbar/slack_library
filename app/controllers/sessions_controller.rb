class SessionsController < ApplicationController
  def create
    # render text: request.env['omniauth.auth'].to_yaml and return
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      # logger.info "Processing the request...#{request.env['omniauth.auth']}"
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to request.env['omniauth.origin'] || root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

  def auth_failure
    flash[:alert] = "Authentication with #{params[:strategy].capitalize} "\
                    'was canceled. Please try again.'
    redirect_to root_path
  end
end
