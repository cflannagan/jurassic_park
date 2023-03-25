# Jurassic Park API

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
    "cage": {
      "id": 5,
      "capacity": 5,
      "power_status": "active",
      "created_at": "2023-03-24T18:16:26.714Z",
      "updated_at": "2023-03-24T18:16:26.808Z"
    },
    "created_at": "2023-03-22T01:30:43.730Z",
    "updated_at": "2023-03-24T17:01:37.214Z",
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
    "cage": {
      "id": 5,
      "capacity": 5,
      "power_status": "active",
      "created_at": "2023-03-24T18:16:26.714Z",
      "updated_at": "2023-03-24T18:16:26.808Z"
    },
    "created_at": "2023-03-22T01:30:43.831Z",
    "updated_at": "2023-03-22T01:30:43.831Z",
    "url":"http://localhost:3000/dinosaurs/2"
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

#### cURL example

```
curl -X POST http://localhost:3000/dinosaurs \
-H 'Content-Type: application/json' \
-d '{
  "name": "T-Rex",
  "species_id": 1,
  "cage_id": 5
}'
```

#### Response

```json
{
  "id": 13,
  "name": "T-Rex",
  "species": {
    "id": 1,
    "name": "Tyrannosaurus",
    "dinosaur_type": "carnivore",
    "created_at": "2023-03-22T01:30:43.501Z",
    "updated_at": "2023-03-22T01:30:43.501Z"
  },
  "cage": {
    "id": 5,
    "capacity": 5,
    "power_status": "active",
    "created_at": "2023-03-24T18:16:26.714Z",
    "updated_at": "2023-03-24T18:16:26.808Z"
  },
  "created_at": "2023-03-25T18:48:05.247Z",
  "updated_at": "2023-03-25T18:48:05.247Z",
  "url":"http://localhost:3000/dinosaurs/13"
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

#### cURL example

```
curl -X PUT http://localhost:3000/dinosaurs/1 \
-H 'Content-Type: application/json' \
-d '{
  "name": "Tyrone"
}'
```

##### Response

```json
{
  "id": 1,
  "name": "Tyrone",
  "species": {
    "id": 1,
    "name": "Tyrannosaurus",
    "dinosaur_type": "carnivore",
    "created_at": "2023-03-22T01:30:43.501Z",
    "updated_at": "2023-03-22T01:30:43.501Z"
  },
  "cage": {
    "id": 5,
    "capacity": 5,
    "power_status": "active",
    "created_at": "2023-03-24T18:16:26.714Z",
    "updated_at": "2023-03-24T18:16:26.808Z"
  },
  "created_at": "2023-03-22T01:30:43.730Z",
  "updated_at": "2023-03-25T18:50:45.808Z",
  "url":"http://localhost:3000/dinosaurs/1"
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
  "cage": {
    "id": 5,
    "capacity": 5,
    "power_status": "active",
    "created_at": "2023-03-24T18:16:26.714Z",
    "updated_at": "2023-03-24T18:16:26.808Z"
  },
  "created_at": "2023-03-22T01:30:43.730Z",
  "updated_at": "2023-03-24T17:01:37.214Z",
  "url": "http://localhost:3000/dinosaurs/1"
}
```

### DELETE /dinosaurs/:id

Deletes an existing dinosaur.

#### cURL example

```
curl -X DELETE http://localhost:3000/dinosaurs/13 \
-H 'Content-Type: application/json'
```

##### Response

(none)

## /cages

### GET /cages

Returns a list of all cages.

#### Response

```json
[
  {
    "id": 5,
    "capacity": 5,
    "dinosaurs": [
      {
        "id": 2,
        "name": "Roberta",
        "species_id": 1,
        "cage_id": 5,
        "created_at": "2023-03-22T01:30:43.831Z",
        "updated_at": "2023-03-22T01:30:43.831Z"
      },
      {
        "id": 1,
        "name": "Tyrone",
        "species_id": 1,
        "cage_id": 5,
        "created_at": "2023-03-22T01:30:43.730Z",
        "updated_at": "2023-03-25T18:50:45.808Z"
      }
    ],
    "power_status": "active",
    "created_at": "2023-03-24T18:16:26.714Z",
    "updated_at": "2023-03-24T18:16:26.808Z",
    "url":"http://localhost:3000/cages/5"
  }
]
```

### POST /cages

Creates a new cage.

#### Parameters

| Name | Type | Description |
| --- | --- | --- |
| capacity | integer | Desired capacity for the cage. |
| power_status | string | must be either 'active' or 'down'. Default is 'down' |

#### cURL example

```
curl -X POST http://localhost:3000/cages \
-H 'Content-Type: application/json' \
-d '{
  "capacity": 10,
  "power_status": "active"
}'
```

#### Response

```json
{
  "id": 6,
  "capacity": 10,
  "dinosaurs": [],
  "power_status": "active",
  "created_at": "2023-03-25T19:01:42.167Z",
  "updated_at": "2023-03-25T19:01:42.167Z",
  "url":"http://localhost:3000/cages/6"
}
```

### PUT /cages/:id

Updates an existing cage.

##### Parameters

| Name | Type | Description |
| --- | --- | --- |
| capacity | integer | Desired capacity for the cage. |
| power_status | string | must be either 'active' or 'down'. Default is 'down' |

#### cURL example

```
curl -X PUT http://localhost:3000/cages/6 \
-H 'Content-Type: application/json' \
-d '{
  "capacity": "11"
}'
```

##### Response

```json
{
  "id": 6,
  "capacity": 11,
  "dinosaurs": [],
  "power_status": "active",
  "created_at": "2023-03-25T19:01:42.167Z",
  "updated_at": "2023-03-25T19:01:42.167Z",
  "url":"http://localhost:3000/cages/6"
}
```

### GET /cages/:id

Returns a single cage.

##### Response

```json
{
  "id": 5,
  "capacity": 5,
  "dinosaurs": [
    {
      "id": 2,
      "name": "Roberta",
      "species_id": 1,
      "cage_id": 5,
      "created_at": "2023-03-22T01:30:43.831Z",
      "updated_at": "2023-03-22T01:30:43.831Z"
    },
    {
      "id": 1,
      "name": "Tyrone",
      "species_id": 1,
      "cage_id": 5,
      "created_at": "2023-03-22T01:30:43.730Z",
      "updated_at": "2023-03-25T18:50:45.808Z"
    }
  ],
  "power_status": "active",
  "created_at": "2023-03-24T18:16:26.714Z",
  "updated_at": "2023-03-24T18:16:26.808Z",
  "url":"http://localhost:3000/cages/5"
}
```

### DELETE /cages/:id

Deletes an existing cage.

#### cURL example

```
curl -X DELETE http://localhost:3000/cages/6 \
-H 'Content-Type: application/json'
```

##### Response

(none)

## /species

### GET /species

Returns a list of all species.

#### Response

```json
[
  {
    "id": 1,
    "name": "Tyrannosaurus",
    "dinosaur_type": "carnivore",
    "dinosaurs": [
      {
        "id": 2,
        "name": "Roberta",
        "species_id": 1,
        "cage_id": 5,
        "created_at": "2023-03-22T01:30:43.831Z",
        "updated_at": "2023-03-22T01:30:43.831Z"
      },
      {
        "id": 1,
        "name": "Tyrone",
        "species_id": 1,
        "cage_id": 5,
        "created_at": "2023-03-22T01:30:43.730Z",
        "updated_at": "2023-03-25T18:50:45.808Z"
      }
    ],
    "created_at": "2023-03-22T01:30:43.501Z",
    "updated_at": "2023-03-22T01:30:43.501Z",
    "url":"http://localhost:3000/species/1"
  }
]
```

### POST /species

Creates a new species.

#### Parameters

| Name | Type | Description |
| --- | --- | --- |
| name | string | The name of the species. |
| dinosaur_type | string | must be either "carnivore" or "herbivore" |

#### cURL example

```
curl -X POST http://localhost:3000/species \
-H 'Content-Type: application/json' \
-d '{
  "name": "Diplodocus",
  "dinosaur_type": "herbivore"
}'
```

#### Response

```json
{
    "id": 9,
    "name": "Diplodocus",
    "dinosaur_type": "herbivore",
    "dinosaurs": [],
    "created_at": "2023-03-25T19:10:44.103Z",
    "updated_at": "2023-03-25T19:10:44.103Z",
    "url": "http://localhost:3000/species/9"
}
```

### PUT /species/:id

Updates an existing species.

##### Parameters

| Name | Type | Description |
| --- | --- | --- |
| name | string | The name of the species. |
| dinosaur_type | string | must be either "carnivore" or "herbivore" |

#### cURL example

```
curl -X PUT http://localhost:3000/species/9 \
-H 'Content-Type: application/json' \
-d '{
  "name": "Diplodocus (type B)"
}'
```

##### Response

```json
{
    "id": 9,
    "name": "Diplodocus (type B)",
    "dinosaur_type": "herbivore",
    "dinosaurs": [],
    "created_at": "2023-03-25T19:10:44.103Z",
    "updated_at": "2023-03-25T19:10:44.103Z",
    "url": "http://localhost:3000/species/9"
}
```

### GET /species/:id

Returns a single species.

##### Response

```json
{
    "id": 9,
    "name": "Diplodocus (type B)",
    "dinosaur_type": "herbivore",
    "dinosaurs": [],
    "created_at": "2023-03-25T19:10:44.103Z",
    "updated_at": "2023-03-25T19:10:44.103Z",
    "url": "http://localhost:3000/species/9"
}
```

### DELETE /species/:id

Deletes an existing species.

#### cURL example

```
curl -X DELETE http://localhost:3000/species/9 \
-H 'Content-Type: application/json'
```

##### Response

(none)
