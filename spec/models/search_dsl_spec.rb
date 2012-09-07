require 'spec_helper'

class ModelSearch
  include SearchDSL
end

describe SearchDSL do
  context 'when created' do
    before do
      ModelSearch._search = Search.new(ModelSearch._model)
      @model1 = Model.create(name: 'a name')
      @model2 = Model.create(name: 'another name')
    end

    context 'empty' do
      let(:search) { ModelSearch.new }

      it 'should guess the model based on the class name' do
        search.model.should == Model
      end

      it 'should get the search result' do
        search.result.should =~ [@model1, @model2]
      end
    end

    context 'with a nil param' do
      before do
        ModelSearch.search :name
      end

      let(:search) { ModelSearch.new(nil) }

      it 'should not fail' do
        search.result
      end

    end

    context 'with a param' do
      before do
        ModelSearch.search :name
      end

      let(:search) { ModelSearch.new(name: 'a name') }

      it 'should filter using the param' do
        search.result.should =~ [@model1]
      end
    end
  end

end
