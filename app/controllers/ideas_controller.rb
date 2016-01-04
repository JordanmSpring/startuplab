class IdeasController < ApplicationController
  respond_to :docx

  before_action :find_idea

  def show
    authorize(@idea, :export?)
    respond_with(@idea, filename: "idea-#{@idea.to_param}.docx", word_template: 'show.docx')
  end

  private
    def find_idea
      @idea = Idea.find(params[:id])
    end

end
