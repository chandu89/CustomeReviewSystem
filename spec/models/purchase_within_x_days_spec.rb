# frozen_string_literal: true

require 'timecop'
require_relative '../spec_helper'
require_relative '../../app/models/purchase_within_x_days_rule'

RSpec.describe PurchaseWithinXDaysRule do
  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  let(:purchase_obj) { PurchaseWithinXDaysRule.new }
  let(:year) { 2008 }
  let(:existing_memory) { [] }
  let(:record) { { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 6, 1) } }
  let(:reward) { purchase_obj.apply(record, existing_memory: existing_memory) }
  context 'when no existing memory' do
    it 'returns no reward' do
      expect(reward).to be_nil
    end
  end

  context 'when existing memory within 30 days' do
    let(:existing_memory) { [{ customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 5, 1) }] }

    it 'returns reward' do
      expect(reward).to eql({ reward_date: Time.now, reward_type: 'twenty percent off next order' })
    end
  end

  context 'when existing memory beyond 30 days' do
    let(:existing_memory) { [{ customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2008, 1, 2, 6, 1) }] }

    it 'returns no reward' do
      expect(reward).to be_nil
    end
  end
end
