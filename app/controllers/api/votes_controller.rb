class Api::VotesController < Api::BaseController
  respond_to :json

  def create
    current_user.vote_for(idea) unless current_user.voted_for?(idea)
    head :ok
  end

  def destroy
    current_user.unvote_for(idea) if current_user.voted_for?(idea)
    head :ok
  end

  private

    def idea
      @idea ||= Idea.find(params[:idea_id])
    end

end
