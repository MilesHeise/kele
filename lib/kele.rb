Class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, pass)
    @auth_token = self.class.post(email: email, password: pass).auth_token
  end
end
