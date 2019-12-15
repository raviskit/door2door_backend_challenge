# door2door_backend_challenge
Door2Door Back-end code challenge
This project implements the following backend challenge : https://github.com/door2door-io/d2d-code-challenges/tree/master/backend

## Prerequisite

* Ruby 2.6.3
* Rails 5.2.3
* Docker (optional)
* Mongodb

## Setup and Run

Application is containerized. To run the application, make sure Docker is installed and run

	docker-compose up --build

It will run the application on port localhost:3000

## Specs

To run the specs run the docker container in one tab and in another tab run
  docker-compose exec api bundle exec rspec spec
  
## Features Implemented

- [x] Vehicle registration
- [x] Vehicle location update
- [x] Vehicle de-registration
- [x] Ignore location updates outside city boundaries
- [x] Archive valid vehicle locations
- [x] Solution is able to handle the simulation tool's load
- [x] Containerized

## Endpoints

Vehicle registration

	POST /vehicles

Request body:

	{ "id": "some-uuid-here" }

Response status code: 204

Response body should be empty.

The vehicle will contact this endpoint to register itself in your solution. It will pass in a universally unique ID to identify itself. After receiving this registration request, you should expect to start receiving vehicle location updates from the vehicle.

Example: the vehicle with the ID abc123 wants to start sending location updates. It would contact POST /vehicles with { "id": “abc123” } in the request body.
Location update

	POST /vehicles/:id/locations

Request body:

	{ "lat": 10.0, "lng": 20.0, "at": "2019-09-01T12:00:00Z" }

Response status code: 204

Response body should be empty.

The vehicle will contact this endpoint whenever a new location is detected, but no more than once every 3 seconds. It will contain the latitude and longitude of its position, and the timestamp that the position was recorded in ISO8601 format. The vehicle will never contact this endpoint without having registered first.

Example: the vehicle with the ID abc123 has recorded a new position at 12pm CET on 2nd December 2019, at the position (51.2, 45.3). It would contact POST /vehicles/abc123/locations with { "lat": 51.2, “lng”: 45.3, “at”: “2019-12-02T12:00:00+01:00” } in the request body.
Vehicle de-registration

	DELETE /vehicles/:id

Response status code: 204

Response body should be empty.

The vehicle will contact this endpoint when it will stop emitting location updates. After this endpoint has been called, the vehicle will never send further location updates unless it calls the vehicle registration endpoint again.

Example: the vehicle with the ID abc123 has finished emitting location updates. It would contact DELETE /vehicles/abc123 to indicate this.
