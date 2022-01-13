# frozen_string_literal: true

require 'timecop'
require_relative '../spec_helper'
require_relative '../../app/models/special_day_purchase_rule'

RSpec.describe SpecialDayPurchaseRule do
  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  let(:record) {  { customer_id: 65, purchase_amount_cents: 1600, created_at: Time.utc(2011, 5, 4, 11, 1) } }
  let(:threshold) { nil }
  let(:purchase_obj) { SpecialDayPurchaseRule.new(threshold: threshold) }
  let(:reward) { purchase_obj.apply(record) }

  context 'when the purchase date is 4th may' do
    it 'returns a new reward' do
      expect(reward).to eql({ reward_date: Time.now, reward_type: 'Star Wars themed item added to delivery' })
    end
  end

  context 'when date not in the declared special day' do
    let(:threshold) { { day: 7, month: 11 } }
    it 'returns nil' do
      expect(reward).to be_nil
    end
  end
end
