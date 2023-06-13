require 'rspec'
require './lib/visitor.rb'

RSpec.describe Visitor do
  describe 'initialize' do
    it 'creates a visitor with the provided attributes' do
      visitor = Visitor.new('Bruce', 54, '$10')
      expect(visitor.name).to eq('Bruce')
      expect(visitor.height).to eq(54)
      expect(visitor.spending_money).to eq(10)
      expect(visitor.preferences).to eq([])
    end
  end

  describe 'add_preference' do
    it 'adds a preference to the visitor' do
      visitor = Visitor.new('Bruce', 54, '$10')
      visitor.add_preference(:gentle)
      visitor.add_preference(:thrilling)
      expect(visitor.preferences).to eq([:gentle, :thrilling])
    end
  end

  describe 'tall_enough?' do
    it 'returns true if the visitor is tall enough' do
      visitor = Visitor.new('Bruce', 54, '$10')
      expect(visitor.tall_enough?(54)).to be true
      expect(visitor.tall_enough?(64)).to be false
    end
  end
end
