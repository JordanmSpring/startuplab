class Api::RegistrationsController < Devise::RegistrationsController
  self.responder = RegistrationResponder
  respond_to :json
end
