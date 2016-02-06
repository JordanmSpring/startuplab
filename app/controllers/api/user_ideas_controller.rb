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
      params.require(:user_idea).permit(:email)
    end

    # Finds the user to share this idea with, and invites them if they aren't
    # already in the system.
    def get_shared_user
      if User.exists?(email: create_params[:email])
        User.find_by(email: create_params[:email])
      else
        parts     = create_params[:email].to_s.split('@')
        temp_name = parts[0].sub(/^(.).*(.)$/, '\1....\2') + "@#{parts[1]}"
        User.invite!(create_params.merge(name: create_params[:email], name: temp_name), UserIdea.new)
      end
    end

end