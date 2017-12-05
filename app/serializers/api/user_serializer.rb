class Api::UserSerializer < Api::BaseSerializer
  attributes :id, :email, :created_at, :updated_at
end
