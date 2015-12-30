module PathsHelper
  def angular_idea_path(idea)
    "/#/ideas/#{idea.id}"
  end

  def angular_idea_url(idea)
    "http://#{App.mailer_default_url_options[:host]}#{angular_idea_path(idea)}"
  end
end