class IdeasController < ApplicationController
  before_action :find_idea, except: :index

  def index
    @ideas = Idea.all
    render json: @ideas
  end

  def show
    render json: @idea
  end

  def update
    @idea.update(params.require(:idea).permit!)
    head :ok
  end

  private
    def find_idea
      @idea = Idea.find(params[:id])
    end
end
