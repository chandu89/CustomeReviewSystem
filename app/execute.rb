# frozen_string_literal: true

require_relative 'custome_review_system'

customer_purchases = [
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

custome_review_system = CustomeReviewSystem.new
custome_review_system.customer_purchases = customer_purchases
new_purchase = 'y'
while new_purchase == 'y'
  print 'enter customer_id: '
  customer_id = gets.chomp.to_i
  print 'enter purchase_amount_cents: '
  purchase_amount_cents = gets.chomp.to_f

  new_record = { customer_id: customer_id, purchase_amount_cents: purchase_amount_cents, created_at: Time.now }
  reward = custome_review_system.get_reward(new_record)
  puts(reward || 'No Offer applicable')
  print('Want to enter new purchase? Y/N')
  new_purchase = gets.chomp.downcase
end
