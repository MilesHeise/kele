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
      'assignment_branch' => nil,
      'assignment_commit_link' => nil,
      'checkpoint_id' => checkpoint_id,
      'comment' => nil,
      'enrollment_id' => get_me.dig('current_enrollment', 'id')
    }

    final_body = body.merge(options).delete_if { |_k, v| v.nil? }

    response = self.class.post(
      '/checkpoint_submissions', headers: {
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
