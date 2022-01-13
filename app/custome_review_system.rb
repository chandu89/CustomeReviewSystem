# frozen_string_literal: true

require_relative './models'
# This is for CustomeReviewSystem
class CustomeReviewSystem
  attr_accessor :rules_list, :customer_purchases

  def initialize
    self.rules_list = []
    self.customer_purchases = []
    rules_list << PurchaseGreaterXRule.new
    rules_list << PurchaseWithinXDaysRule.new
    rules_list << SpecialDayPurchaseRule.new
  end

  def get_reward(new_record)
    reward = nil
    rules_list.reverse.each do |rule|
      reward = rule.apply(new_record, existing_memory: customer_purchases)
      break unless reward.nil?
    end
    customer_purchases << new_record
    reward
  end
end
