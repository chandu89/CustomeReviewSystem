# frozen_string_literal: true

require 'date'
# This is for Purchase within last x(30) days
class PurchaseWithinXDaysRule
  attr_accessor :threshold

  DAY_THRESHOLD = 30

  def initialize(threshold: nil)
    self.threshold = (threshold.nil? ? DAY_THRESHOLD : threshold)
  end

  def apply(new_record, existing_memory: [])
    return nil if existing_memory.nil?

    reward = nil
    existing_memory.each do |x|
      next unless x[:customer_id] == new_record[:customer_id] &&
                  (DateTime.parse(new_record[:created_at].to_s).between? DateTime.parse(
                    x[:created_at].to_s
                  ), DateTime.parse(
                    x[:created_at].to_s
                  ).next_day(threshold))

      reward = { reward_date: Time.now,
                 reward_type: 'twenty percent off next order' }
    end

    reward
  end
end
