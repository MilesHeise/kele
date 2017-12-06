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

  def create_submission(checkpoint_id, options = {})
    body = {
      'enrollment_id' => get_me.dig('current_enrollment', 'id'),
      'checkpoint_id' => checkpoint_id,
      'assignment_branch' => nil,
      'assignment_commit_link' => nil,
      'comment' => nil
    }
    final_body = body.merge(options).compact

    response = self.class.post(
      '/messages', headers: {
        'authorization' => @auth_token
      }, body: final_body
    )
    if response['message']
      p 'checkpoint not submitted'
    else
      p 'checkpoint submitted successfully'
    end
  end
end
