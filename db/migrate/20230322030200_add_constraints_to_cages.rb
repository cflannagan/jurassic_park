class AddConstraintsToCages < ActiveRecord::Migration[7.0]
  def up
    add_check_constraint :cages, "capacity > 0", name: "capacity_non_negative"

    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_cage_status_and_capacity() RETURNS TRIGGER AS $$
      DECLARE
        occupancy INTEGER;
      BEGIN

        SELECT COUNT(*) INTO occupancy FROM dinosaurs WHERE cage_id = NEW.id;

        -- we only want to check power_status if it has changed and it's now 'DOWN'. No need to check if it's 'ACTIVE'
        IF NEW.power_status = 'DOWN' AND OLD.power_status IS DISTINCT FROM NEW.power_status THEN
          IF occupancy > 0 THEN
            RAISE EXCEPTION 'Cannot power down when dinosaurs are present';
          END IF;
        END IF;

        -- we only want to check capacity if it has been changed and capacity is going down
        IF OLD.capacity IS DISTINCT FROM NEW.capacity AND NEW.capacity < OLD.capacity THEN
          IF occupancy > NEW.capacity THEN
            RAISE EXCEPTION 'Cannot change capacity; occupancy cannot exceed capacity';
          END IF;
        END IF;
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER check_cage_status_and_capacity
        BEFORE UPDATE ON cages
        FOR EACH ROW
        EXECUTE FUNCTION check_cage_status_and_capacity();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER check_cage_status_and_capacity ON cages;

      DROP FUNCTION check_cage_status_and_capacity();
    SQL

    remove_check_constraint :cages, name: "capacity_non_negative"
  end
end
