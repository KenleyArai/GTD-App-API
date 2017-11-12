require 'rails_helper'

RSpec.describe Action, type: :model do
  # Associations
  it { should belong_to(:project) }
  # Validations
  it { should validate_presence_of(:title) }
end
