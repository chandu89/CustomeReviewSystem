# frozen_string_literal: true

# This is for Purchase amount higher than x
class PurchaseGreaterXRule
  attr_accessor :threshold

  THRESHOLD_AMOUNT = 1500

  def initialize(threshold: nil)
    self.threshold = (threshold.nil? ? THRESHOLD_AMOUNT : threshold)
  end

  def apply(new_record, existing_memory: [])
    reward = nil
    if new_record[:purchase_amount_cents] > threshold
      reward = { reward_date: Time.now, reward_type: 'Next Purchase Free Reward' }
    end
    reward
  end
end
