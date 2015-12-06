class Api::UserIdeasController < Api::BaseController
  before_action :find_idea
  respond_to :json

  def index
    authorize(@idea, :share?)
    @user_ideas = @idea.user_ideas
    render json: @user_ideas
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end

end