resource "hcloud_server" "bastion" {
  name        = "bastion"
  image       = "ubuntu-20.04"
  server_type = "cx11"
  location    = "fsn1"
  ssh_keys    = [module.kube-hetzner.ssh_key_id]
}

resource "hcloud_server_network" "server_network_bastion" {
  network_id = module.kube-hetzner.network_id
  server_id  = hcloud_server.bastion.id
  ip         = "10.0.0.2"
}

resource "hcloud_network_route" "bastion" {
  network_id  = module.kube-hetzner.network_id
  destination = "10.66.66.0/24"
  gateway     = "10.0.0.2"
}
