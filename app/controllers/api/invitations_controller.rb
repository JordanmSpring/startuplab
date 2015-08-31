class Api::InvitationsController < Devise::InvitationsController
  skip_before_action :require_no_authentication
  skip_before_action :authenticate_user!, only: [ :edit, :update ]
  self.responder = InvitationResponder
  respond_to :json

  def edit
    resource.invitation_token = params[:invitation_token]
    render json: resource
  end

  def invite_resource(&block)
    if resource_class.exists?(email: invite_params[:email])
      resource = resource_class.find_by(email: invite_params[:email])
    else
      resource = resource_class.invite!(invite_params, current_inviter, &block).tap do |resource|
      end
    end
    idea = Idea.find(params[:idea_id])
    idea.founders.create!(user: resource, role: params[:role])
    resource
  end

  def resource_from_invitation_token
    unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
      head :not_found
    end
  end
end
