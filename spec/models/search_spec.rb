require 'spec_helper'

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
      search.result.should =~ Model.all
    end
  end
end
