class Api::FundingOptionsController < Api::BaseController
  before_action :find_idea

  def create
    @idea.funding_option_names = params.require(:funding_options)
    head :ok
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end
end
