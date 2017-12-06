require 'httparty'
require 'json'
require_relative 'roadmap'
require_relative 'messages'

class Kele
  include HTTParty
  include Roadmap
  include Messages
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, pass)
    response = self.class.post(
      '/sessions', body: {
        'email' => email,
        'password' => pass
      }
    )
    if response['message'] == 'Resource not found'
      p 'oh god no'
    else
      @email = email
      @auth_token = response['auth_token']
    end
  end

  def get_me
    response = self.class.get(
      '/users/me', headers: {
        'authorization' => @auth_token
      }
    )
    JSON.parse(response.body)
  end

  def get_mentor_availability(id)
    response = self.class.get(
      "/mentors/#{id}/student_availability", headers: {
        'authorization' => @auth_token
      }, body: {
        'id' => id
      }
    )
    JSON.parse(response.body)
  end
end
