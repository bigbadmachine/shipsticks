require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { create(:product, length: 1, width: 1, height: 1, type: "Golf") }


  context 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:length) }
    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_inclusion_of(:type).in_array(Product::TYPES) }
  end

  describe '#size_composite' do
    it 'returns composite size' do
      expect(subject.size_composite).to eq(3)
    end
  end

  describe '.calculate' do
    before do
      @golf_product = create(:product, length: 5, width: 5, height: 5, weight: 10, type: "Golf")
      @luggage_product = create(:product, length: 5, width: 5, height: 5, weight: 12, type: "Luggage")
      @ski_product = create(:product, length: 7, width: 7, height: 7, weight: 15, type: "Ski")
    end

    context 'when no type is passed' do
      it 'returns golf product' do
        expect(Product.calculate(5,5,5,10)).to eq(@golf_product)
        expect(Product.calculate(5,5,5,12)).to eq(@luggage_product)
        expect(Product.calculate(6,5,5,10)).to eq(@ski_product)
      end
    end

    context 'when Ski type is passed' do
      it 'returns true' do
        expect(Product.calculate(5,5,5,10,"Ski")).to eq(@ski_product)
      end
    end
  end

end
