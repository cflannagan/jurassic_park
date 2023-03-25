# README

## Prerequisites:

Your local environment supports the following:
- PostgreSQL (9.3 version or newer)
- Rails 7.0
- Ruby 2.7.0 (required by Rails 7.0)

## Quick Start:

Assuming you have all the prerequisites installed:

1. Git clone the repo
2. Change to the project directory: `cd jurassic_park`
3. Install the required gems: `bundle install`
4. Create the database: `rails db:create`
5. Run the database migrations: `rails db:migrate`
6. Seed the database: `rails db:seed`
7. Start the Rails server: `rails server`
8. Open one of following endpoints: [`/dinosaurs`](http://localhost:3000/dinosaurs),
[`/cages`](http://localhost:3000/cages), [`/species`](http://localhost:3000/species).

## List of available filters and sample urls

You can also use filtering options with endpoints:

### /dinosaurs
* [caged](http://localhost:3000/dinosaurs?caged)
* [not_caged](http://localhost:3000/dinosaurs?not_caged)
* [carnivore](http://localhost:3000/dinosaurs?carnivore)
* [herbivore](http://localhost:3000/dinosaurs?herbivore)
* [Species, by name - for example Tyrannosaurus](http://localhost:3000/dinosaurs?species=Tyrannosaurus)
* Mix of filters: [not_caged carnivore](http://localhost:3000/dinosaurs?not_caged&canivore)

### /cages
* [empty](http://localhost:3000/cages?empty)
* [full](http://localhost:3000/cages?full)
* [not_full](http://localhost:3000/cages?not_full)
* [not_empty](http://localhost:3000/cages?not_empty)
* [active](http://localhost:3000/cages?active)
* [down](http://localhost:3000/cages?down)
* Mix of filters: [not_full not_empty (ie: partially filled cages)](http://localhost:3000/cages?not_full&not_empty)

### /species
* [carnivore](http://localhost:3000/species?carnivore)
* [herbivore](http://localhost:3000/species?herbivore)

## Musings

- **First and foremost**: In practice, I would have seeked clarification on requirements with the product manager, so that
way we all know what we're expecting in the deliverables - for example some of the assumptions I will discuss below (dinosaurs can
be uncaged, etc)
- **100% Rspec & Rubocop**: I did exclude some files for Rubocop, as well as disabling certain cops in specific places, but
for most part I think we're in a good place here.
- **Dinosaurs can be uncaged**: What if there was an incident and a dinosaur has escaped a cage? Or a dinosaur is currently
being treated by a vet? Or has deceased, but we still want to keep a database record of, in memorandum? The assessment
made no explicit mention that dinosaurs must be "caged".
- **Cages could have capacity changed**: "Cages" to me could be anything - it could be an outdoors enclosure with electrical
fencing boundary. Maybe later the aforementioned enclosure is expanded (take over more land) to hold more dinosaurs? I allowed
for this possibility.
- **Dinosaur names must be unique**: Prevents "Oops, you mean Charlie the _herbivore_? I thought you were referring to
Charlie the _carnivore_? Oh no, I just uncaged Charlie the herbivore into general area with other carnivores.." type of situation.
- **"Dinosaur type" (carnivore vs herbivore) is a property inherent to "species"**: The way I saw it, "carnivore" or "herbivore"
is something that I feel should be assigned to "species", so I decided to split off a separate "Species" model, with it own
enum for dinosaur type (carnivore vs herbivore). I do realize I might have inadvertently created more work for myself for an
assessment. If I had more times I would probably explore for ways to have the "species" + "dinosaur type" enum as part of
"Dinosaur" class.
- **How I would have addressed concurrency concerns**: Database constraints (checks and triggers). Those db constraints
would prevent race conditions where things might happen where it should not (ie: application logic, because of concurrent requests
somehow accidentally place herbivores and carnivores togehter in a cage). Utilize background workers (like Sidekiq) to handle
updates.

[API Documentation can be found here](API_Documentation.md)