module SearchDSL
  extend ActiveSupport::Concern

  included do
    class_attribute :_model
    self._model = name[0..-7].constantize
  end

  def model
    _model
  end
end
