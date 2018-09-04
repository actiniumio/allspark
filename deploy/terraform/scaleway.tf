variable "org" {}
variable "token" {}
variable "region" {
  default = "par1"
}
variable "server_type" {
  default = "C2S"
}

provider "scaleway" {
  organization = "${var.org}"
  token        = "${var.token}"
  region       = "${var.region}"
}
#
resource "scaleway_ip" "ip" {
  count = 1
  server = "${element(scaleway_server.allspark.id, count.index)}"
}

resource "scaleway_server" "allspark" {
  count = 2
  name  = "${count.index}"
  image = "2c493e89-350a-4eac-a29e-0cc7371476df"
  type  = "C2S"
  # dynamic_ip_required = true
}

resource "scaleway_security_group" "http" {
  name        = "http"
  description = "allow HTTP and HTTPS traffic"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}
