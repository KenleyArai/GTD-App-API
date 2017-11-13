require 'rails_helper'

RSpec.describe Project, type: :model do
  # Associations
  it { should have_many(:actions).dependent(:destroy) }
  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
