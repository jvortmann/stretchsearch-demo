require 'spec_helper'

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
      search.result.should =~ Model.all
    end
  end
end
