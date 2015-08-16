class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
    render json: @ideas
  end

  def show
    @idea = Idea.find(params[:id])
    render json: { id: @idea.id, name: @idea.name, problems: @idea.problems }
  end
end
