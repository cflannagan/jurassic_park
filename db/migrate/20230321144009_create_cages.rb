class CreateCages < ActiveRecord::Migration[7.0]
  def up
    create_enum :power_classification, %w[ACTIVE DOWN]
    create_table :cages do |t|
      t.integer :capacity, null: false, default: 1
      t.enum :power_status, enum_type: :power_classification, default: "DOWN", null: false

      t.timestamps
    end
  end
  def down
    drop_table :cages
    execute <<-SQL
      DROP TYPE power_classification;
    SQL
  end
end
