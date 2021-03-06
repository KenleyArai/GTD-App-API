class CreateActions < ActiveRecord::Migration[5.1]
  def change
    create_table :actions do |t|
      t.string :title
      t.boolean :done
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
