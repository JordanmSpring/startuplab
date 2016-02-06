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

    user       = User.find_or_create_by(email: create_params[:email])
    # TODO - what if it has already  been shared to this user? Need unique validator.
    @user_idea = @idea.user_ideas.create!(shared_user: user)
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

end