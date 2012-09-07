require 'spec_helper'

module SuperModel
  module RandomID
    protected
    def generate_id
      SecureRandom.hex(13)
    end
  end
end

class Model < SuperModel::Base
  include SuperModel::RandomID
end

describe Search do
  context 'when created' do
    before :all do
      Model.create
      Model.create
    end

    let(:search) { Search.new(Model) }

    it 'should have a model' do
      search.model.should == Model
    end

    it 'should return all objects' do
      search.result.should match_array(Model.all)
    end
  end
end
