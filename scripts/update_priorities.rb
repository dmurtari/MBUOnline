# Script to give priorities to preferences that don't have a priority assigned
# to them

Scout.all.each do |scout|
  priority = 1
  preferences = scout.preferences.order("created_at asc")
  preferences.each do |preference|
    preference.priority ||= priority
    preference.save
    priority += 1
  end
end