Course.all.each do |course|
  course.capacity = 20
  course.save
end