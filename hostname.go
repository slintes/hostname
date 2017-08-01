package main

import (
	"fmt"
	"net/http"
	"os"
	"time"
)

var hostname string

func main() {
	fmt.Println("Started, but going to sleep...")
	hostname, _ = os.Hostname()
	time.Sleep(time.Second * 20)
	http.HandleFunc("/", handler)
	fmt.Println("And awake, ready for business!")
	http.ListenAndServe(":8080", nil)
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from %s!", hostname)
}
