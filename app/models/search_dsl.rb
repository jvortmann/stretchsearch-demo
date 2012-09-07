module SearchDSL
  extend ActiveSupport::Concern

  included do
    class_attribute :_model, :_search
    self._model = name[0..-7].constantize
    self._search = Search.new(self._model)
  end

  def initialize(params={})
    @params = params || {}
  end

  def model
    _model
  end

  def result
    _search.run @params
  end

  module ClassMethods
    def search(attribute)
      _search.add_rule(attribute)

      class_eval do
        attr_accessor attribute
      end
    end
  end
end
