module Roadmap
  def get_roadmap(id)
    response = self.class.get(
      "/roadmaps/#{id}", headers: {
        'authorization' => @auth_token
      }, body: {
        id: id
      }
    )
    JSON.parse(response.body)
  end

  def get_checkpoint(id)
    response = self.class.get(
      "/checkpoints/#{id}", headers: {
        'authorization' => @auth_token
      }, body: {
        id: id
      }
    )
    JSON.parse(response.body)
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post(
      '/messages', headers: {
        'authorization' => @auth_token
      }, body: {
        'enrollment_id' => get_me.dig('current_enrollment', 'id'),
        'checkpoint_id' => checkpoint_id,
        'assignment_branch' => however I do optional,
        'assignment_commit_link' => however I do optional,
        'comment' => however I do optional
      }
    )
    if response['message']
      p 'message not sent'
    else
      p 'message sent successfully'
    end
  end
end
