module "kube-hetzner" {
  providers = {
    hcloud = hcloud
  }
  hcloud_token = var.hcloud_token

  source = "kube-hetzner/kube-hetzner/hcloud"

  ssh_public_key  = file("~/.ssh/htz_id_rsa.pub")
  ssh_private_key = file("~/.ssh/htz_id_rsa")

  network_region = "eu-central"

  control_plane_nodepools = [
    {
      name        = "control-plane-fsn1",
      server_type = "cpx11",
      location    = "fsn1",
      labels      = [],
      taints      = [],
      count       = 1
    },
    {
      name        = "control-plane-nbg1",
      server_type = "cpx11",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 0
    },
    {
      name        = "control-plane-hel1",
      server_type = "cpx11",
      location    = "hel1",
      labels      = [],
      taints      = [],
      count       = 0
    }
  ]

  agent_nodepools = [
    {
      name        = "agent-small",
      server_type = "cpx11",
      location    = "fsn1",
      labels      = [],
      taints      = [],
      count       = 1
    },
    {
      name        = "agent-large",
      server_type = "cpx21",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 1
    },
    {
      name        = "storage",
      server_type = "cpx21",
      location    = "fsn1",
      labels = [
        "node.kubernetes.io/server-usage=storage"
      ],
      taints = [],
      count  = 1
    },
    {
      name        = "egress",
      server_type = "cpx11",
      location    = "fsn1",
      labels = [
        "node.kubernetes.io/role=egress"
      ],
      taints = [
        "node.kubernetes.io/role=egress:NoSchedule"
      ],
      floating_ip = true
      count       = 0
    },
    {
      name        = "agent-arm-small",
      server_type = "cax11",
      location    = "fsn1",
      labels      = [],
      taints      = [],
      count       = 0
    }
  ]

  load_balancer_type     = "lb11"
  load_balancer_location = "fsn1"

  # traefik_additional_options = ["--log.level=DEBUG", "--tracing=true"]

  firewall_kube_api_source = ["10.0.0.2/32"]

  # extra_firewall_rules = [
  #   {
  #     description = "For Postgres"
  #     direction       = "in"
  #     protocol        = "tcp"
  #     port            = "5432"
  #     source_ips      = ["0.0.0.0/0", "::/0"]
  #     destination_ips = [] # Won't be used for this rule
  #   },
  #   {
  #     description = "To Allow ArgoCD access to resources via SSH"
  #     direction       = "out"
  #     protocol        = "tcp"
  #     port            = "22"
  #     source_ips      = [] # Won't be used for this rule
  #     destination_ips = ["0.0.0.0/0", "::/0"]
  #   }
  # ]

  # use_control_plane_lb = true
  # control_plane_lb_type = "lb21"
  # control_plane_lb_enable_public_interface = false
  # Let's say you are not using the control plane LB solution above, and still want to have one hostname point to all your control-plane nodes.
  # You could create multiple A records of to let's say cp.cluster.my.org pointing to all of your control-plane nodes ips.
  # In which case, you need to define that hostname in the k3s TLS-SANs config to allow connection through it. It can be hostnames or IP addresses.
  # additional_tls_sans = ["cp.cluster.my.org"]
}
