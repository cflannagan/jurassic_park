class CreateDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_table :dinosaurs do |t|
      t.string :name, null: false
      t.references :species, null: false, foreign_key: true
      t.references :cage, foreign_key: true

      t.timestamps
    end
    add_index :dinosaurs, :name, unique: true
  end
end
