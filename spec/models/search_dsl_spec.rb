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

class ModelSearch
  include SearchDSL
end

describe SearchDSL do
  context 'when included' do
    let(:search) { ModelSearch.new }

    it 'should guess the model based on the class name' do
      search.model.should == Model
    end

    it 'should get the search result' do
      search.result.should match_array(Model.all)
    end
  end
end
