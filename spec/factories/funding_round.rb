require Rails.root.to_s + '/spec/factories/sequences' unless FactoryGirl.sequences.any?

FactoryGirl.define do
  factory :funding_round do
    company
    raw_raised_amount { BigDecimal.new('1000.01') }
    raised_currency_code { 'USD' }
    funded_on { 10.days.ago }
    crunchbase_id  { FactoryGirl.generate(:guid) }

    factory :unfunded_funding_round, class: FundingRound do
      raw_raised_amount { BigDecimal.new('0') }
    end
  end
end
