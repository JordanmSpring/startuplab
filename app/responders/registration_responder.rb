class RegistrationResponder < ActionController::Responder
  def to_json
    if resource.persisted?
      render json: UserExhibit.new(resource), status: 201
    else
      render status: 422, json: {
        errors: resource.errors.full_messages.join(', ')
      }
    end
  end
end
