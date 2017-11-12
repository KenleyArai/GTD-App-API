class Action < ApplicationRecord
  # Associations
  belongs_to :project

  # Validations
  validates_presence_of :title
end
