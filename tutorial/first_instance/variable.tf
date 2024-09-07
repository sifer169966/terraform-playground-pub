variable "image" { default = "ubuntu-os-cloud/ubuntu-2004-lts"}
variable "machine_type" { 
    type = map(string)
    default =  {
        dev = "n1-standard-1"
        prod = "production_box_wont_work_yet"
    } 
}
variable "instances" { default = ["server1", "server2", "server3"]}