class Api::IdeasController < Api::BaseController
  before_action :find_idea, except: [:index, :create]
  respond_to :json

  def index
    @ideas = current_user.ideas
    render json: @ideas
  end

  def show
    render json: IdeaExhibit.new(@idea)
  end

  def update
    @idea.update(idea_update_params)
    head :ok
  end

  def create
    idea = current_user.ideas.create!(idea_params)
    respond_with(:api, IdeaExhibit.new(idea))
  end

  private
    def find_idea
      @idea = Idea.find(params[:id])
    end

    def idea_create_params
      params.require(:idea).permit(:name)
    end

    def idea_update_params
      params.require(:idea).permit(
        :idea,
        :problem,
        :problem_detail,
        :company,
        :mvp_url,
        :mvp_stage,
        :target_customer,
        :target_customer_reason
      )
    end
end
