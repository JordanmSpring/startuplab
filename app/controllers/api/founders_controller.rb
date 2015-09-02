class Api::FoundersController < ApplicationController
  before_action :find_idea
  before_action :find_founder

  def destroy
    @founder = @idea.founders.find(params[:id])
    @founder.destroy
    head :ok
  end

  def update
    @founder.update!(founder_params)
    head :ok
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end

    def find_founder
      @founder = @idea.founders.find(params[:id])
    end

    def founder_params
      params.require(:founder).permit(:role)
    end
end
