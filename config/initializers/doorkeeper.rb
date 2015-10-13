Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do
    user = User.find_by(email_address: params[:username])
    user && user.authenticate(params[:password])
  end

  access_token_expires_in nil

  access_token_methods :from_bearer_authorization

  grant_flows %w(password)
end
