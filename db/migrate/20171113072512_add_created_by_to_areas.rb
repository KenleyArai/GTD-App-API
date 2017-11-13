class AddCreatedByToAreas < ActiveRecord::Migration[5.1]
  def change
    add_column :areas, :created_by, :string
  end
end
