class CreateSpecies < ActiveRecord::Migration[7.0]
  def up
    create_enum :dinosaur_classification, %w[carnivore herbivore]

    create_table :species do |t|
      t.string :name, null: false
      t.enum :dinosaur_type, enum_type: :dinosaur_classification, null: false

      t.timestamps
    end
    add_index :species, :name, unique: true
  end
  def down
    drop_table :species
    execute <<-SQL
      DROP TYPE dinosaur_classification;
    SQL
  end
end
