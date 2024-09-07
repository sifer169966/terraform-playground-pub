resource "google_compute_network" "playground" {
    name = "playground-network"
    auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "playground_subnetwork" {
  name = "playground-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region = "asia-southeast1"
  network = google_compute_network.playground.self_link
}