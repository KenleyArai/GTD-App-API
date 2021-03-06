class User < ApplicationRecord
    has_secure_password

    # Associations
    has_many :projects, foreign_key: :created_by

    # Validations
    validates_presence_of :name, :email, :password_digest
end
