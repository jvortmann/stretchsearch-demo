class Search
  attr_reader :model

  def initialize(model)
    @model = model
    @rules = []
  end

  def run(params={})
    result = model.scoped
    @rules.each do |r|
      if params[r].present?
        result = result.where(r => params[r])
      end
    end
    result
  end

  def add_rule(attribute)
    @rules << attribute
  end
end
