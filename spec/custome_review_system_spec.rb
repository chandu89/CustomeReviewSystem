# frozen_string_literal: true

require 'timecop'
require_relative 'spec_helper'
require_relative '../app/custome_review_system'

RSpec.describe CustomeReviewSystem do
  subject { CustomeReviewSystem.new }
  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  context 'Unit test the rules are being returned properly' do
    let(:customer_purchases) do
      [
        { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 6, 1) },
        { customer_id: 31_337, purchase_amount_cents: 6522, created_at: Time.utc(2009, 5, 4, 6, 12) },
        { customer_id: 4465, purchase_amount_cents: 987, created_at: Time.utc(2010, 8, 17, 11, 9) },
        { customer_id: 234_234, purchase_amount_cents: 200, created_at: Time.utc(2010, 11, 1, 16, 12) },
        { customer_id: 12_445, purchase_amount_cents: 1664, created_at: Time.utc(2010, 11, 18, 13, 19) },
        { customer_id: 234_234, purchase_amount_cents: 1200, created_at: Time.utc(2010, 12, 2, 16, 12) },
        { customer_id: 12_445, purchase_amount_cents: 1800, created_at: Time.utc(2010, 12, 3, 11, 17) },
        { customer_id: 65, purchase_amount_cents: 900, created_at: Time.utc(2011, 4, 28, 13, 16) },
        { customer_id: 65, purchase_amount_cents: 1600, created_at: Time.utc(2011, 5, 4, 11, 1) }
      ]
    end

    it 'returns the rule with the lowest index when all the other rule matching is done' do
      customer_purchases
      subject.customer_purchases = customer_purchases
      new_record = { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.now }
      reward = subject.get_reward(new_record)
      expect(reward).to eql({ reward_date: Time.now, reward_type: 'Next Purchase Free Reward' })

      subject.customer_purchases = customer_purchases
      new_record = { customer_id: 653, purchase_amount_cents: 1800, created_at: Time.now }
      reward = subject.get_reward(new_record)
      expect(reward).to eql({ reward_date: Time.now, reward_type: 'Next Purchase Free Reward' })

      another_new_record = { customer_id: 65, purchase_amount_cents: 180, created_at: Time.now + 1 }
      reward = subject.get_reward(another_new_record)
      expect(reward).to eql({ reward_date: Time.now, reward_type: 'twenty percent off next order' })

      yet_another_new_record = { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2021, 5, 4, 11, 1) }
      reward = subject.get_reward(yet_another_new_record)
      expect(reward).to eql({ reward_date: Time.now, reward_type: 'Star Wars themed item added to delivery' })
    end
  end
end
