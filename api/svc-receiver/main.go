package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/Polipapik/gourmet/api/svc-receiver/model"
	"github.com/Polipapik/gourmet/api/util"
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

var env struct {
	db      *gorm.DB
	Product model.Product
	Router  *mux.Router
}

func init() {
	log.Println("Attempting to open a database connection...")
	connectionString := fmt.Sprintf("host=%s port=%s user=%s dbname=%s sslmode=disable password=%s",
		os.Getenv("DB_HOSTNAME"),
		os.Getenv("DB_PORT"),
		os.Getenv("DB_USER"),
		os.Getenv("DB_NAME"),
		os.Getenv("DB_PASSWORD"))

	db, err := gorm.Open(os.Getenv("DB_DIALECT"), connectionString)
	if err != nil {
		log.Fatal(err)
	}

	env.db = db
	log.Println("Database connection successfully.")
}

func main() {
	defer log.Println("Main function ended")
	defer env.db.Close() // check usability

	env.Router = mux.NewRouter()

	// log.Println("kek")

	// ps := []model.Product{}
	// err := env.db.Select("*").Find(&ps).Error
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// log.Println(ps)

	env.Router.HandleFunc("/",
		func(w http.ResponseWriter, r *http.Request) {
			GetProducts(env.Product, w, r)
		}).
		Methods("GET")

	// env.Router.HandleFunc("/Product/{id:[0-9]+}",
	// 	func(w http.ResponseWriter, r *http.Request) {
	// 		GetProduct(env.Product, w, r)
	// 	}).
	// 	Methods("GET")
	// env.Router.HandleFunc("/Product",
	// 	func(w http.ResponseWriter, r *http.Request) {
	// 		CreateProduct(env.Product, w, r)
	// 	}).
	// 	Methods("POST")
	// env.Router.HandleFunc("/Product/{id:[0-9]+}",
	// 	func(w http.ResponseWriter, r *http.Request) {
	// 		UpdateProduct(env.Product, w, r)
	// 	}).
	// 	Methods("PUT")
	// env.Router.HandleFunc("/Product/{id:[0-9]+}",
	// 	func(w http.ResponseWriter, r *http.Request) {
	// 		DeleteProduct(env.Product, w, r)
	// 	}).
	// 	Methods("DELETE")

	log.Fatal(http.ListenAndServe(os.Getenv("RECEIVER_SERVICE_ADDRESS"), env.Router))
}

func GetProducts(p model.Product, w http.ResponseWriter, r *http.Request) {
	log.Println("HANDLE GetProducts touch")

	//v := r.URL.Query()

	ps := []model.Product{}
	log.Println(ps)
	env.db.Select("*").Find(&ps)
	log.Println(ps)

	util.RespondWithJSON(w, http.StatusOK, ps)
}
