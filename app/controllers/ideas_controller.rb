class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
    render json: @ideas
  end

  def show
    @idea = Idea.find(params[:id])
    render json: @idea
  end
end
