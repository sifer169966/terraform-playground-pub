resource "google_compute_instance" "default" {
    count = "${length(var.machine_count)}"
    name = "list-${count.index + 1}"
    machine_type = "${var.environment != "dev" ? var.machine_type : var.machine_type_dev}"
    zone = "asia-southeast1-c"
    can_ip_forward = false
    description = "This is a virtual machine"
    # FIREWALLS
    tags = ["allow-http", "allow-https"]
    boot_disk {
        initialize_params {
          image = "${var.image}"
        }
    }
     
    labels = {
        name = "list-${count.index + 1}"
        machine_type = "${var.environment != "dev" ? var.machine_type : var.machine_type_dev}"
    }

    network_interface {
        network = "default"
    }

    metadata = {
      size = "20"
      foo = "bar"
    }

    metadata_startup_script = "echo Hello world!"

    service_account {
      scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}

resource "google_compute_disk" "default" {
    name = "test-disk"
    type = "pd-ssd"
    zone = "asia-southeast1-c"
    size = 10
}

resource "google_compute_attached_disk" "default" {
    disk = "${google_compute_disk.default.self_link}"
    instance = "${google_compute_instance.default[0].self_link}"
}

output "machine_type" { value = [for v in resource.google_compute_instance.default : v.machine_type] }
output "name" { value = [for v in resource.google_compute_instance.default : v.name] }
output "zone" { value = [for v in resource.google_compute_instance.default : v.zone] }
output "instance_ids" { value = [for v in resource.google_compute_instance.default : v.id] }