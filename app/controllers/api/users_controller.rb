class Api::UsersController < Api::BaseController
  before_action :doorkeeper_authorize!
end
