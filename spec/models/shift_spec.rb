require 'rails_helper'

RSpec.describe Shift, type: :model do
  it { is_expected.to belong_to(:establishment) }
  it { is_expected.to belong_to(:employee) }
end
