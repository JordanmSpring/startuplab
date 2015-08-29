class Api::ChannelsController < Api::BaseController
  before_action :find_idea

  def create
    @idea.channel_names = params.require(:channels)
    head :ok
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end
end
