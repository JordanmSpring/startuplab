class Api::IdeasController < Api::BaseController
  skip_before_action :authenticate_user!, only: [ :show, :index ]
  before_action :find_idea, except: [:index, :create, :draft, :published]
  respond_to :json

  def index
    @ideas = Idea.published
    render json: @ideas
  end

  def draft
    @ideas = Idea.with_founder(current_user).draft
    render json: @ideas
  end

  def published
    @ideas = Idea.with_founder(current_user).published
    render json: @ideas
  end

  def show
    authorize(@idea)
    render json: IdeaExhibit.new(@idea, current_user)
  end

  def update
    authorize(@idea)
    @idea.update(idea_update_params)
    head :ok
  end

  def destroy
    authorize(@idea)
    @idea.destroy
    head :ok
  end

  def publish
    authorize(@idea)
    @idea.publish!
    head :ok
  end

  def unpublish
    authorize(@idea)
    @idea.unpublish!
    head :ok
  end

  def create
    Idea.transaction do
      authorize(Idea, :create?)
      @idea = current_user.ideas.create!(idea_create_params)
      @idea.founders.create(role: 'Founder', user: current_user)
    end
    render json: IdeaExhibit.new(@idea, current_user)
  end

  private
    def find_idea
      @idea = Idea.find(params[:id])
    end

    def idea_create_params
      params.require(:idea).permit(:name)
    end

    def idea_update_params
      params.require(:idea).permit(
        :idea,
        :problem,
        :problem_detail,
        :company,
        :mvp_url,
        :mvp_stage,
        :target_customer,
        :target_customer_reason,
        :costs,
        :revenue,
        :name,
        :pitch_why,
        :pitch_what,
        :pitch_how,
        :timing_why,
        :timing_description,
        :facebook_url,
        :twitter_url,
        :linkedin_url
      )
    end
end
