variable "path" {default = "/Users/fer.wasin/terraform-workspace/playground/tutorial/credentials"}

provider "google" {
    project = "$PROJECT_ID"
    region = "${var.region}"
    credentials = "${file("${var.path}/compute-default.json")}"
}