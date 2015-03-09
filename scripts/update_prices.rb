# Script to calculate the cost of attendance for all scouts already registered

Scout.all.each do |scout|
  scout.calculate_costs
  scout.save
end

User.all.each do |user|
  user.calculate_total_cost
  user.save
end