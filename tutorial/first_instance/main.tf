resource "google_compute_instance" "default" {
    count = "${length(var.instances)}"
    name = "list-${count.index + 1}"
    machine_type = "${var.machine_type["dev"]}"
    zone = "asia-southeast1-c"
    boot_disk {
        initialize_params {
          image = "${var.image}"
          size = "20"
        }
    }
    network_interface {
        network = "default"
    }
    service_account {
      scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }

}

output "machine_type" { value = [for v in resource.google_compute_instance.default : v.machine_type] }
output "name" { value = [for v in resource.google_compute_instance.default : v.name] }
output "zone" { value = [for v in resource.google_compute_instance.default : v.zone] }
output "instance_ids" { value = [for v in resource.google_compute_instance.default : v.id] }