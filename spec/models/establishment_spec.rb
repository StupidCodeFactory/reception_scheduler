require 'rails_helper'

RSpec.describe Establishment, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_db_index(:name).unique(true) }
end
