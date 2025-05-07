# frozen_string_literal: true

# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      # User was successfully created
      # The token is automatically available in the response headers if configured correctly.
      # We can also include it in the body if desired.
      # The `current_user` helper isn't set here yet upon signup through Devise directly.
      # We need to generate a token manually or rely on devise-jwt to set it in the header.

      # Let's explicitly generate a token here for the response body for clarity
      # Ensure your User model includes `include Devise::JWT::RevocationStrategies::JTIMatcher`
      # and `:jwt_authenticatable, jwt_revocation_strategy: self`
      token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil)[0]


      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        token: token # Include the token in the response body
      }, status: :ok
    else
      # User creation failed
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end