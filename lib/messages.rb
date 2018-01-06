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

  def create_message(recipient, subject, body, token = nil)
    var body = {
      'sender' => @email,
      'recipient_id' => recipient,
      'subject' => subject,
      'stripped-text' => body
    }

    body.merge('token' => token) if token.present?

    response = self.class.post(
      '/messages', headers: {
        'authorization' => @auth_token
      }, body: body
    )
    if response['message']
      p 'message not sent'
    else
      p 'message sent successfully'
    end
  end
end
