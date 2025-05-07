# app/serializers/user_serializer.rb
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at # Add any other attributes you want to expose

  # Example of a custom attribute if needed
  # attribute :full_name do |object|
  #  "#{object.first_name} #{object.last_name}" if object.first_name && object.last_name
  # end
end