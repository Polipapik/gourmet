build:
		GOOS=linux GOARCH=amd64 go build -o ./api/svc-receiver/svc-receiver -i ./api/svc-receiver/*.go
		docker build -t svc-receiver ./api/svc-receiver
		docker build -t purchase-db ./db
		rm ./api/svc-receiver/svc-receiver

unfail:
		go get -u github.com/Polipapik/gourmet

run:
		docker-compose up

down:
		docker-compose down

clean:
		docker rm svc-receiver purchase-db

# ifndef $(GOPATH)
#     GOPATH=$(shell go env GOPATH)
#     export GOPATH
# endif
