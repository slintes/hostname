package main

import (
	"fmt"
	"net/http"
	"os"
	"strconv"
	"time"
)

var hostname string

func main() {
	delay := os.Getenv("DELAY")
	delay_s, err := strconv.Atoi(delay)
	if err != nil {
		fmt.Println("couldn't read delay time from env")
		delay_s = 20
	}
	fmt.Printf("Started, but going to sleep for %v seconds\n", delay_s)
	hostname, _ = os.Hostname()
	time.Sleep(time.Second * time.Duration(delay_s))
	http.HandleFunc("/", handler)
	fmt.Println("And awake, ready for business!")
	http.ListenAndServe(":8080", nil)
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from %s!", hostname)
}
