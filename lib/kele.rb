require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, pass)
    response = self.class.post(
      '/sessions', body: {
        email: email,
        password: pass
      }
    )
    if response['message'] == 'Resource not found'
      p 'oh god no'
    else
      p response['auth_token']
      @auth_token = response['auth_token']
    end
    p @auth_token
  end
end
