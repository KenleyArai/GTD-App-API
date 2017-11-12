class Project < ApplicationRecord
    # Associations
    has_many :actions, dependent: :destroy
    # Validations
    validates_presence_of :title
end
