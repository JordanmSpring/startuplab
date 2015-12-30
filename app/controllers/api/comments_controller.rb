class Api::CommentsController < Api::BaseController
  before_action :find_idea
  respond_to :json

  def index
    @comments = @idea.comments
    respond_with(:api, @comments)
  end

  def create
    comment = @idea.comments.build(params.require(:comment).permit(:body))
    comment.user = current_user
    comment.save!
    render json: CommentExhibit.new(comment)
  end

  private
    def find_idea
      @idea = Idea.find(params[:idea_id])
    end
end
