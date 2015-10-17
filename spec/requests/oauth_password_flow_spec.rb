RSpec.describe "OAuth password flow" do

  let :email_address do
    "test@test.com"
  end

  let :password do
    "12344321"
  end

  let! :user do
    FactoryGirl.create(:user, email_address: email_address, password: password)
  end

  it "creates a token and returns it when the credentials are valid and get /v1/users/me" do
    post "/oauth/token", grant_type: "password", username: email_address, password: password
    expect(response.status).to eq 200

    access_token = JSON.parse(response.body)["access_token"]
    expect(access_token).not_to be_nil

    get "/v1/users/me", nil, { "Content-Type" => "application/vnd.api+json", "Authorization" => "Bearer #{access_token}" }
    expect(response.status).to eq 200
    me = JSON.parse(response.body)
    expect(me["data"]["attributes"]["email-address"]).to eq email_address
  end

  it "does not issue a token if the credentials are invalid" do
    post "/oauth/token", grant_type: "password", username: email_address, password: "bologna"
    expect(response.status).to eq 401
  end
end
