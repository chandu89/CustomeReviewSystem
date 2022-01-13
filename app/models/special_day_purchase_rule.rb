# frozen_string_literal: true

require 'date'

# This is for Special Day Purchase Rule
class SpecialDayPurchaseRule
  attr_accessor :day, :month

  SPECIAL_DAY = 4
  SPECIAL_MONTH = 5

  def initialize(threshold: nil)
    self.day = threshold.nil? ? SPECIAL_DAY : threshold[:day]
    self.month = threshold.nil? ? SPECIAL_MONTH : threshold[:month]
  end

  def apply(new_record, existing_memory: [])
    date = new_record[:created_at]
    reward = nil
    if date.day == day && date.month == month
      reward = { reward_date: Time.now, reward_type: 'Star Wars themed item added to delivery' }
    end
    reward
  end
end
