class ApplicationController < JSONAPI::ResourceController
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= _doorkeeper_user
  end

  def _doorkeeper_user
    return unless valid_doorkeeper_token?

    User.find(doorkeeper_token.resource_owner_id)
  end

end
