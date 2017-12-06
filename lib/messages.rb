module Messages
  def get_messages(page = 1)
    response = self.class.get(
      '/message_threads', headers: {
        'authorization' => @auth_token
      }, body: {
        'page' => page
      }
    )
    JSON.parse(response.body)
  end

  def create_message(recipient, token = nil, subject, body)
    response = self.class.post(
      '/messages', headers: {
        'authorization' => @auth_token
      }, body: {
        'sender' => @email,
        'recipient_id' => recipient,
        'token' => token,
        'subject' => subject,
        'stripped-text' => body
      }
    )
    if response['message']
      p 'message not sent'
    else
      p 'message sent successfully'
    end
  end
end
