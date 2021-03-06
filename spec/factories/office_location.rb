require Rails.root.to_s + '/spec/factories/sequences' unless FactoryGirl.sequences.any?

FactoryGirl.define do
  factory :office_location do
    association :tenant, factory: :company
    zip_code { '12345' }
    country_code { 'USA' }
    state_code { 'FL' }
    longitude { BigDecimal.new(-81) }
    latitude { BigDecimal.new(28) }

    factory :headquarters do
      headquarters { true }
    end
  end
end
