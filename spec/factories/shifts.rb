FactoryBot.define do
  factory :shift do
    slot { Time.zone.now..(Time.zone.now + 7.hours) }

    %i[ monday tuesday wednesday thursday friday saturday sunday ].each_with_index do |day, i|
      trait day do
        slot { (Time.zone.now.monday + i.day + 7.hours)..(Time.zone.now.monday + i.day + 15.hours) }
      end

    end

  end
end
