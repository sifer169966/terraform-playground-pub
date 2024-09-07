

# Instance Template <- Describe Instance

resource "google_compute_instance_template" "instance_template" {
    count = 1
    name = "playground-server-${count.index + 1}"
    description = "This is my auto scaling template"
    # Networks
    #tags = []
    labels = {
      environment = "production"
      name = "playground-server-${count.index + 1}"
    }

    instance_description = "This is an instance that has been auto scaled"
    machine_type = "n1-standard-1"
    can_ip_forward = false

    scheduling {
      automatic_restart = true
      on_host_maintenance = "MIGRATE"
    }

    disk {
      source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
      auto_delete = true
      boot = true
    }

    disk {
      auto_delete = false
      disk_size_gb = 10
      mode = "READ_WRITE"
      type = "PERSISTENT"
    }

    network_interface {
        network = "default"
    }

    metadata = {
      foo = "bar"
    }

    service_account {
      scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}


# Heath Check <- Auto Scaling Policy (when to scale)
resource "google_compute_health_check" "health" {
    count = 1
    name = "name"
    check_interval_sec = 5
    timeout_sec = 5
    healthy_threshold = 2
    unhealthy_threshold = 10
    http_health_check {
      request_path = "/"
      port = "8080"
    }
}

# Group Manager <- Manages the nodes
resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  name = "instance-group-manager"
  base_instance_name = "instance-group-manager"
  version {
    name = "1-tiny-server"
    instance_template = "${google_compute_instance_template.instance_template[0].self_link}"
  }

  region = "${var.region}"
  auto_healing_policies {
    health_check = "${google_compute_health_check.health[0].self_link}"
    initial_delay_sec = 300
  }
}

# Auto Scaling Policy <- How many instances
resource "google_compute_region_autoscaler" "autoscaler" {
    count = 1
    name = "auto-scaler"
    project = "$PROJECT_ID"
    target = "${google_compute_region_instance_group_manager.instance_group_manager.self_link}"
    region = "${var.region}"
    autoscaling_policy {
      max_replicas = 2
      min_replicas = 1
      # Let's an instance gracefully shutting down before hard remove it
      cooldown_period = 60
      cpu_utilization {
        target = 0.8
      }
    }

}