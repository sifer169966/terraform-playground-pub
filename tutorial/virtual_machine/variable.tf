variable "environment"  {default = "production" }
variable "image" { default = "ubuntu-os-cloud/ubuntu-2004-lts"}
variable "machine_type" { default = "n1-standard-2" }
variable "machine_type_dev" {
    default = "n1-standard-1"
}
variable "machine_count" { default = ["server1"]}