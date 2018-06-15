# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

establishment = Establishment.create!(name: 'Soho House')
donald = Employee.create!(name: 'Donald Trump')
kim = Employee.create!(name: 'Kim Jong Un')

donald_shift = Shift.new(slot: Time.zone.now.midday..(Time.zone.now.midday + 6.hours))

other_shift = Shift.new(slot: donald_shift.slot.end..(donald_shift.slot.end + 4.hours))

scheduler_service = Scheduler.new(establishment)


log = -> (result, shift) do
  puts result ? "Scheduled #{shift.employee.name} from #{shift.slot.begin.to_s(:short)} to #{shift.slot.end.to_s(:short)}" : shift.errors.full_messages.to_sentence(last_word_connector: ' and ')
end

log.call(scheduler_service.book(donald, donald_shift), donald_shift)
log.call(scheduler_service.book(kim, other_shift), other_shift)
log.call(scheduler_service.book(donald, other_shift), other_shift)
