[![Build Status](https://travis-ci.org/StupidCodeFactory/reception_scheduler.svg?branch=master)](https://travis-ci.org/StupidCodeFactory/reception_scheduler)

### Setup

Simply run:

```shell
bin/setup
```

### Reception Scheduler

The service class `Scheduler` is responsible for scheduling slots.

```ruby
# example from the seeds.rb

establishment = Establishment.create!(name: 'Soho House')
donald = Employee.create!(name: 'Donald Trump')
kim = Employee.create!(name: 'Kim Jong Un')

donald_shift = Shift.new(slot: Time.zone.now.midday..(Time.zone.now.midday + 6.hours))

other_shift = Shift.new(slot: donald_shift.slot.end..(donald_shift.slot.end + 4.hours))

scheduler_service = Scheduler.new(establishment)


log = -> (result, shift) do
  puts result ? "Scheduled #{shift.employee.name} from #{shift.slot.begin.to_s(:short)} to #{shift.slot.end.to_s(:short)}" : shift.errors.full_messages.to_sentence(last_word_connector: ' and ')
end

log.call(scheduler_service.book(donald, donald_shift), donald_shift) # => Scheduled Donald Trump from 15 Jun 12:00 to 15 Jun 18:00
log.call(scheduler_service.book(kim, other_shift), other_shift) # => Scheduled Kim Jong Un from 15 Jun 18:00 to 15 Jun 22:00
log.call(scheduler_service.book(donald, other_shift), other_shift) # => Slot has already been alocated
```
