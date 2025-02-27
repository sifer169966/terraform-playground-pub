variable "tier" {default = "db-f1-micro"}
variable "name" {default = "playground"}
variable "db_region" {default = "asia-southeast1"}
variable "disk_size" {default = "20"}
variable "database_version" {default = "MYSQL_5_7"}
variable "user_host" {default = "%"}
variable "user_name" {default = "admin"}
variable "user_password" {default = "$DB_PASSWORD"}
variable "activation_policy" {default = "ALWAYS"}