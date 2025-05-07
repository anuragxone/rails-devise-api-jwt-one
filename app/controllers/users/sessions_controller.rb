# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    # resource here is the successfully authenticated user
    # The token is typically in the Authorization header of the response
    # e.g., `Authorization: Bearer <your_token_here>`
    # We can also choose to include it in the JSON body.

    # `current_user` is set by Devise after successful login
    token = request.env['warden-jwt_auth.token'] # Get token from warden after login

    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(current_user).serializable_hash[:data][:attributes], # Assuming you have a UserSerializer
      token: token # Include the token in the response body
    }, status: :ok
  end

  def respond_to_on_destroy
    # This is called when logging out (destroying the session)
    # devise-jwt handles token revocation based on JTIMatcher by default
    if current_user
      render json: {
        status: 200,
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end# frozen_string_literal: true

