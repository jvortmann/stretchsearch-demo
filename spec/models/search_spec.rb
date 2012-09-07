require 'spec_helper'

describe Search do
  context 'when created' do
    context 'empty' do
      before do
        Model.create
        Model.create
      end

      let(:search) { Search.new(Model) }

      it 'should have a model' do
        search.model.should == Model
      end

      it 'should return all objects' do
        search.run.should =~ Model.all
      end
    end

    context 'with one rule' do
      before do
        @expected = Model.create(name: 'a name')
        Model.create(name: 'another name')

        @search = Search.new(Model)
        @search.add_rule(:name)
      end

      it 'should filter using the attribute' do
        @search.run(name: 'a name').should =~ [@expected]
      end
    end
  end
end
