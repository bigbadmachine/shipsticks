class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :length, :width, :height, :weight
end
