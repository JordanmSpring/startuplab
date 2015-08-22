class UsersExhibit
  attr_reader :collection

  def initialize(users)
    @collection = users
  end

  def as_json(options = {})
    @collection.map { |user| UserExhibit.new(user) }.as_json
  end
end
