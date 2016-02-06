class Api::UserIdeasController < Api::BaseController
  before_action :find_idea
  respond_to :json

  def index
    authorize(@idea, :share?)
    @user_ideas = @idea.user_ideas
    render json: @user_ideas
  end

  def create
    authorize(@idea, :share?)

    # TODO - what if it has already  been shared to this user? Need unique validator.
    share_with = get_shared_user
    @user_idea = @idea.user_ideas.create!(shared_user: share_with)
    share_with.update_attribute(:invited_by_id, @user_idea.id)
    render json: @user_idea.as_json
  end

  def destroy
    authorize(@idea, :share?)

    @user_idea = UserIdea.find(params[:id])
    @user_idea.destroy
    render json: @user_idea.as_json
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end

    def create_params
      params.require(:user_idea).permit(:email, :name)
    end

    # Finds the user to share this idea with, and invites them if they aren't
    # already in the system.
    def get_shared_user
      if User.exists?(email: create_params[:email])
        User.find_by(email: create_params[:email])
      else
        User.invite!(create_params, UserIdea.new)
      end
    end

end