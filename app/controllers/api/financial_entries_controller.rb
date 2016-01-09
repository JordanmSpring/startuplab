class Api::FinancialEntriesController < ApplicationController
  before_action :find_idea
  before_action :find_entry, only: [:update, :destroy]

  def destroy
    authorize(@entry, :destroy?)
    @entry.destroy
    head :ok
  end

  def create
    authorize(@idea, :update?)
    @idea.financial_entries.create!(entry_params)
    head :ok
  end

  def update
    authorize(@entry, :update?)
    @entry.update!(entry_params)
    head :ok
  end

  private
    def find_idea
      Pundit.policy_scope!(current_user, Idea).find(params[:idea_id])
    end

    def find_entry
      @entry ||= find_idea.financial_entries.find(params[:id])
    end

    def entry_params
      params.require(:financial_entry).permit(:group, :name, :value)
    end
end
