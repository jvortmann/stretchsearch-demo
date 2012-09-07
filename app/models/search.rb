class Search
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def result
    model.all
  end
end
