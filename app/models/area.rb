class Area < ApplicationRecord
    # Associations
    has_many :projects, foreign_key: :created_by

    # Validations
    validates_presence_of :title, :created_by
end
