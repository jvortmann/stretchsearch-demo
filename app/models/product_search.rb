module StretchSearch
  extend ActiveModel::Naming

  def initialize(params)
  end

  module ClassMethods
    def search(field)
      class_eval do
        attr_accessor field
      end
    end
  end

  def result
    Product.all
  end

end

class ProductSearch
  include StretchSearch
  extend StretchSearch::ClassMethods

  search :name
end
