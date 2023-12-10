# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])

#   Character.create(name: "Luke", movie: movies.first)
#
#



# db/seeds.rb
admin_role = Role.create(name: 'admin')
user_role = Role.create(name: 'user')


# db/seeds.rb

# Helper method to create time slots
def create_timeslot(start_time, end_time)
  Timeslot.create(start_time: start_time, end_time: end_time)
end

# Seed time slots
create_timeslot('09:00:00', '09:30:00')
create_timeslot('09:30:00', '10:00:00')
create_timeslot('10:00:00', '10:30:00')
create_timeslot('10:30:00', '11:00:00')
# Add more time slots as needed

