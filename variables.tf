variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpMnCKyfyYWRS5qXiQ0MVRwowLpGo6EZRHjI1sO3wpx8gPblXp1O4R3z70BC+p2pODOqoGNTSFcGxAr2P3b0ddIXVgQMMfPXAnwZMdrROm3N84HVPw3w9qnf9zb6OebfMsZhFqM1uWcdbsV7foamjSJHLsHSICX+jROOEOmpuUIZW/6q+gVnUCS82zQMrpYoXzYZLSjXF9JWNjJ9Fc1wiIlc0UWC+2dWXwT0HDXwhRfqr2qMMueaN8MggViD4VKcHvRKauWZMowjOhrZb6RjME1Cfas5oUMCc+p0eRbCLZ2SElbnkrb4THCKAP/fRImjVC93CBPl26ROFq7wz7tUBoyUVopaSu8WuUM7mV11OgsIsFo7/iZnBU95hjXupfTfORHhFZi3kCQG1rrEZFB1qVspWfOcas0o/Gu7By9JUc/72b/xKrLXF50OdKL/sm+gbeOXlLygLpcbEhbUxOUzMysN1JMMnoHZNbTJKgZQwCW6o+iOeIE+qpAkGQTonf9YU= leandrosalvas@localhost.localdomain"
}

variable "template_name" {
    default = "ubuntu-template"
}

variable "pmox_user" {
    default = "root@pam"
}

variable "pmox_password" {
    default = "root@root"
}
variable "pmox_api_url" {
    default = "https://pve.salvas.home:8006/api2/json"
}

variable "k8s_masters" {
  description = "vm variables in a dictionary "
  type        = map(any)
}

variable "k8s_workers" {
  description = "vm variables in a dictionary "
  type        = map(any)
}