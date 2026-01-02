postgres:
	docker run --name postgres18 -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=secret -p 5432:5432 -d postgres:18-alpine
createdb:
	docker exec -it postgres18 createdb --username=admin --owner=admin simple_bank
dropdb:
	docker exec -it postgres18 dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://admin:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://admin:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
.PHONY: postgres createdb dropdb migrateup migratedown sqlc