class AddConstraintsToDinosaurs < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_cage_id() RETURNS TRIGGER AS $$
      DECLARE
        dinosaur_type TEXT;
        power_status TEXT;
        capacity INTEGER;
        occupancy INTEGER;
      BEGIN

        -- we only care about various checks below if "new" cage_id isn't null and it's a new value
        IF NEW.cage_id IS NOT NULL AND OLD.cage_id IS DISTINCT FROM NEW.cage_id THEN
          -- Make note of new dino type, cage power_status & capacity and number of dinos already in cage
          SELECT species.dinosaur_type INTO dinosaur_type FROM species WHERE species.id = NEW.species_id;
          SELECT cages.power_status INTO power_status FROM cages WHERE cages.id = NEW.cage_id;
          SELECT cages.capacity INTO capacity FROM cages WHERE cages.id = NEW.cage_id;
          SELECT COUNT(*) INTO occupancy FROM dinosaurs WHERE cage_id = NEW.cage_id;

          -- The cage must be powered on
          IF power_status = 'DOWN' THEN
            RAISE EXCEPTION 'Cannot add dinosaur to a powered down cage';
          END IF;
          -- Cage must not be at capacity already
          IF occupancy = capacity THEN
            RAISE EXCEPTION 'Cannot add dinosaur to cage already at capacity';
          END IF;
          -- If it's a carnivore, it can only go into cage with others of same species.
          IF dinosaur_type = 'carnivore'
            AND EXISTS (SELECT * FROM dinosaurs WHERE cage_id = NEW.cage_id AND species_id != NEW.species_id) THEN
            RAISE EXCEPTION 'Cannot add carnivore dinosaur to a cage with different species';
          END IF;
          -- if it's a herbivore, it can only go into cage with other herbivores.
          IF dinosaur_type = 'herbivore' AND
            EXISTS (
              SELECT * FROM dinosaurs JOIN species ON dinosaurs.species_id = species.id WHERE cage_id = NEW.cage_id
                AND species.dinosaur_type = 'carnivore') THEN
            RAISE EXCEPTION 'Cannot add herbivore dinosaur to a cage with carnivore dinosaurs';
          END IF;
        END IF;
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER check_cage_id
        BEFORE INSERT OR UPDATE ON dinosaurs
        FOR EACH ROW
        EXECUTE FUNCTION check_cage_id();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER check_cage_id ON dinosaurs;

      DROP FUNCTION check_cage_id();
    SQL
  end
end
