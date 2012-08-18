class FieldRule
  attr :field, :method

  def initialize(field, method)
    @field = field
    @method = method
  end
end

module StretchSearch
  extend ActiveSupport::Concern

  included do
    class_attribute :_rules, :_target_class
    self._rules = []
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
    _rules.each do |r|
      field = r.field
      method = r.method
      value = send(field)
      if value.present?
        if method == :eq
          result = result.where(field => value)
        elsif method == :contains
          result = result.where("#{field} LIKE '%#{value}%'")
        end
      end
    end
    result
  end

  module ClassMethods
    def search(field, method)
      class_eval do
        attr_accessor field
      end
      _rules << FieldRule.new(field, method)
    end
  end
end
