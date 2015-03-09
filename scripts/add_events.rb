event = Event.new(semester: "Fall", year: "2014", current: true)
event.save!

Scout.all.each do |scout|
  scout.preferences.each do |preference|
    preference.event = event
    preference.save
  end

  scout.records.each do |record|
    record.event = event
    record.save
  end
end

Course.all.each do |course|
  course.event = event
  course.save
end