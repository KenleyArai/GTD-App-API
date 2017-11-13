require 'rails_helper'

RSpec.describe Area, type: :model do
  # Association
  it { should have_many(:projects) }

  # Validation
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
