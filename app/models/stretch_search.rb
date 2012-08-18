module StretchSearch
  extend ActiveSupport::Concern

  included do
    class_attribute :_fields, :_target_class
    self._fields = []
    self._target_class = name[0..-7].constantize
  end

  def initialize(params)
    if params.present?
      params.each do |name, value|
        send "#{name}=", value
      end
    end
  end

  def result
    result = _target_class.scoped
    _fields.each do |f|
      value = send(f)
      if value.present?
        result = result.where(f => value)
      end
    end
    result
  end

  module ClassMethods
    def search(field)
      class_eval do
        attr_accessor field
      end
      _fields << field
    end
  end
end
