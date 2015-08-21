class Api::IdeasController < Api::BaseController
  before_action :find_idea, except: [:index, :create]
  respond_to :json

  def index
    @ideas = Idea.all
    render json: @ideas
  end

  def show
    render json: IdeaExhibit.new(@idea)
  end

  def update
    @idea.update(params.require(:idea).permit!)
    head :ok
  end

  def create
    idea = current_user.ideas.create!(params.require(:idea).permit!)
    respond_with(:api, idea)
  end

  private
    def find_idea
      @idea = Idea.find(params[:id])
    end
end
