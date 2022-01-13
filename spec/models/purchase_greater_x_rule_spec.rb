# frozen_string_literal: true

require 'timecop'
require_relative '../spec_helper'
require_relative '../../app/models/purchase_greater_x_rule'

RSpec.describe PurchaseGreaterXRule do
  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  let(:record) {  { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 6, 1) } }
  let(:threshold) { nil }
  let(:purchase_obj) { PurchaseGreaterXRule.new(threshold: threshold) }
  let(:reward) { purchase_obj.apply(record) }

  context 'when the record purchase is less then theshold' do
    let(:threshold) { 2000 }
    it 'returns a nil value' do
      expect(reward).to be_nil
    end
  end

  context 'when the record purchase is greater then theshold' do
    it 'returns a new reward with reward_type' do
      expect(reward).to eql({ reward_date: Time.now, reward_type: 'Next Purchase Free Reward' })
    end
  end
end
