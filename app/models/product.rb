class Product
  TYPES = ["Golf", "Luggage", "Ski"]

  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer
  field :size_composite, type: Integer

  validates_presence_of :name, :type, :length, :width, :height, :weight
  validates_inclusion_of :type, in: TYPES

  before_save :update_size_composite

  def self.calculate(length, width, height, weight, type=nil)
    length = (length || 0)
    width  = (width  || 0)
    height = (height || 0)
    weight = (weight || 0)

    results = Product.gte(length: length, width: width, height: height, weight: weight).order_by(size_composite: :asc, weight: :asc)
    results = results.where(type: type) if TYPES.include?(type)
    results.first
  end

  private

  def update_size_composite
    self.size_composite = length + width + height
  end

end
