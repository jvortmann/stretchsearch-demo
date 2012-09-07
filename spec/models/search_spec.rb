require 'spec_helper'

class Model
end

describe Search do
  context 'when created' do
    let(:search) { Search.new(Model) }

    it 'should have a model' do
      search.model.should == Model
    end
  end
end
