FactoryBot.define do
  factory :product do
    name { "MyString" }
    type { "Golf" }
    length { 1 }
    width { 1 }
    height { 1 }
    weight { 1 }

    factory :invalid_product do 
      name { nil }
      type { "INVALID TYPE" }
    end

    factory :updated_product do 
      length { 27 }
      width { 27 }
      height { 27 }
      weight { 27 }
    end
  end
end
