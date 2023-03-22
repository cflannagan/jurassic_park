# Dinosaur API

## /dinosaurs

### GET /dinosaurs

Returns a list of all dinosaurs.

#### Response

```json
[
  {
    "id": 1,
    "name": "Ty",
    "species": {
      "id": 1,
      "name": "Tyrannosaurus",
      "dinosaur_type": "carnivore",
      "created_at": "2023-03-22T01:30:43.501Z",
      "updated_at": "2023-03-22T01:30:43.501Z"
    },
    "cage_id": null,
    "created_at": "2023-03-22T01:30:43.730Z",
    "updated_at": "2023-03-22T01:30:43.730Z",
    "url": "http://localhost:3000/dinosaurs/1"
  },
  {
    "id": 2,
    "name": "Roberta",
    "species": {
      "id": 1,
      "name": "Tyrannosaurus",
      "dinosaur_type": "carnivore",
      "created_at": "2023-03-22T01:30:43.501Z",
      "updated_at": "2023-03-22T01:30:43.501Z"
    },
    "cage_id": null,
    "created_at": "2023-03-22T01:30:43.831Z",
    "updated_at": "2023-03-22T01:30:43.831Z",
    "url": "http://localhost:3000/dinosaurs/2"
  }
]
```

### POST /dinosaurs

Creates a new dinosaur.

#### Parameters

| Name | Type | Description |
| --- | --- | --- |
| name | string | The name of the dinosaur. |
| species_id | integer | The ID of the species of the dinosaur. |
| cage_id | integer | The ID of the cage of the dinosaur. |

#### Response

```json
{
  "id": 3,
  "name": "Sue",
  "species": {
    "id": 1,
    "name": "Tyrannosaurus",
    "dinosaur_type": "carnivore",
    "created_at": "2023-03-22T01:30:43.501Z",
    "updated_at": "2023-03-22T01:30:43.501Z"
  },
  "cage_id": null,
  "created_at": "2023-03-22T01:30:43.730Z",
  "updated_at": "2023-03-22T01:30:43.730Z",
  "url": "http://localhost:3000/dinosaurs/3"
}
```

### PUT /dinosaurs/:id

Updates an existing dinosaur.

##### Parameters

| Name | Type | Description |
| --- | --- | --- |
| name | string | The name of the dinosaur. |
| species_id | integer | The ID of the species of the dinosaur. |
| cage_id | integer | The ID of the cage of the dinosaur. |

##### Response

```json
{
  "id": 3,
  "name": "Sue",
  "species": {
    "id": 1,
    "name": "Tyrannosaurus",
    "dinosaur_type": "carnivore",
    "created_at": "2023-03-22T01:30:43.501Z",
    "updated_at": "2023-03-22T01:30:43.501Z"
  },
  "cage_id": 1,
  "created_at": "2023-03-22T01:30:43.730Z",
  "updated_at": "2023-03-22T01:30:43.730Z",
  "url": "http://localhost:3000/dinosaurs/3"
}
```

### GET /dinosaurs/:id

Returns a single dinosaur.

##### Response

```json
{
  "id": 1,
  "name": "Ty",
  "species": {
    "id": 1,
    "name": "Tyrannosaurus",
    "dinosaur_type": "carnivore",
    "created_at": "2023-03-22T01:30:43.501Z",
    "updated_at": "2023-03-22T01:30:43.501Z"
  },
  "cage_id": 1,
  "created_at": "2023-03-22T01:30:43.730Z",
  "updated_at": "2023-03-22T01:30:43.730Z",
  "url": "http://localhost:3000/dinosaurs/1"
}
```

### DELETE /dinosaurs/:id

Deletes an existing dinosaur.

##### Response

```json
{
  "id": 1,
  "name": "Ty",
  "species": {
    "id": 1,
    "name": "Tyrannosaurus",
    "dinosaur_type": "carnivore",
    "created_at": "2023-03-22T01:30:43.501Z",
    "updated_at": "2023-03-22T01:30:43.501Z"
  },
  "cage_id": 1,
  "created_at": "2023-03-22T01:30:43.730Z",
  "updated_at": "2023-03-22T01:30:43.730Z",
  "url": "http://localhost:3000/dinosaurs/1"
}
```