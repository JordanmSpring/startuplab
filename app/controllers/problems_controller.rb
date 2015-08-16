class ProblemsController < ApplicationController
  before_action :find_idea

  def index
    problems = @idea.problems
     # TODO: Use responders? Or serializers?
    render json: problems
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end
end
