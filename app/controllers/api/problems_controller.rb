class Api::ProblemsController < Api::BaseController
  before_action :find_idea

  def index
    problems = @idea.problems
     # TODO: Use responders? Or serializers?
    render json: problems
  end

  def create
    # TODO: Use proper params
    @idea.problems.create(params.require(:problem).permit!)
    head :ok
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end
end
