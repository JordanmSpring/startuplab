class UseCases::SaveFromLocal

  private

  IDEA_PARAMS = [
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
  ]

  public

  def initialize(params, current_user)
    @params = params
    @current_user = current_user

    Idea.transaction do
      create_idea
      create_financial_entries
      create_channels
      create_crowdfunding
    end
  end

  def create_idea
    idea_params = @params.slice(*IDEA_PARAMS)
    @idea = @current_user.ideas.create!(idea_params)
    @idea.founders.create!(role: 'Founder', user: @current_user)
  end

  def create_financial_entries
    puts 'financialEntries', @params.slice(:financialEntries)
    puts 'values, flattened', @params.slice(:financialEntries).values
    puts 'double flat', @params.slice(:financialEntries).values.flat_map(&:values)
    @params.slice(:financialEntries).values.flat_map(&:values).each do |entry|
      puts 'Creating financial_entry', entry.inspect
      @idea.financial_entries.create!(entry)
    end
  end

  def create_channels
    @idea.channel_names = @params.slice(:channels)
    @idea.save!
  end

  def create_crowdfunding
    @idea.funding_option_names = @params.slice(:fundingOptions)
    @idea.save!
  end
end
