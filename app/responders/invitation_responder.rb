class InvitationResponder < ActionController::Responder
  def to_json
    if resource.persisted?
      if resource.invited_by.is_a?(UserIdea)
        render json: UserIdeaExhibit.new(resource.invited_by), status: 201
      else
        render json: FounderExhibit.new(resource.founders.last), status: 201
      end
    else
      render status: 422, json: {
        errors: resource.errors.full_messages.join(', ')
      }
    end
  end
end
