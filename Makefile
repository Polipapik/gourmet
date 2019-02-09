build:
		GOOS=linux GOARCH=amd64 go build -o ./api/svc-receiver/svc-receiver -i ./api/svc-receiver/*.go
		docker build -t svc-receiver ./api/svc-receiver
		docker build -t gourmet-db ./db
		rm ./api/svc-receiver/svc-receiver

unfail:
		go get -u github.com/Polipapik/gourmet

run:
		docker-compose up

down:
		docker-compose down

clean:
		docker rm svc-receiver gourmet-db

re:
		make down
		make build
		make run

# ifndef $(GOPATH)
#     GOPATH=$(shell go env GOPATH)
#     export GOPATH
# endif
