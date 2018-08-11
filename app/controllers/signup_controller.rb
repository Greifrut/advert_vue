class SignupController < ApplicationController
  wrap_parameters :user, insclude: [:email, :password, :password_confirmation]

  def create
    user = User.new(user_params)

    if user.save
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf], email: user.email, id: user.id }
    else
      render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_enity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
