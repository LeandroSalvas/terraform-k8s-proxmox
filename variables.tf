variable "ssh_key" {
  default = "#YOURPUBLICKEYHERE"
}

variable "template_name" {
    default = "ubuntu-template"
}

variable "pmox_user" {
    default = "YOURUSERHERE"
}

variable "pmox_password" {
    default = "YOURPASSWORDHERE"
}
variable "pmox_api_url" {
    default = "https://YOURSERVERHERE:8006/api2/json"
}
