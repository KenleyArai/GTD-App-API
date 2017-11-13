require 'rails_helper'

RSpec.describe User, type: :model do
  # Association
  it { should have_many(:projects) }
  it { should have_many(:areas) }
  
  # Validation
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
