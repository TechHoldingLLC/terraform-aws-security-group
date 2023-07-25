module "security_group" {
  source = "../../"
  name   = "my-project-user-api-ecs"
  vpc_id = "vpc_id" # Replace the vpc_id with the desired vpc id.

  egress = [
    ## Https 443 port traffic allowed to all destinations in egress
    {
      port        = 443
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    },
    ## Https 443 port traffic allowed to all IPv6 destinations in egress
    {
      port        = 443
      cidr_blocks = []
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  ingress = [
    ## Http 80 port traffic allowed to specific destination IP addresses in ingress
    {
      port        = 80
      cidr_blocks = ["2.2.2.1/32", "1.1.1.1/32"]
    },
    ## Redshift 5439 port traffic allowed from same security group that own this rule in ingress
    {
      port = 5439
      self = true
    },
    ## Port range 4430-4440 traffic allowed from specific security group in ingress
    {
      from_port                = 4430
      to_port                  = 4440
      source_security_group_id = "sg-123456" # Security group to apply this rule to.
    },
    ## Https 443 Port traffic allowed from specific security group with description in ingress
    {
      protocol                 = "TCP"
      port                     = 443
      source_security_group_id = "sg-123456" # Security group to apply this rule to.
      description              = "Allow Https"
    }
  ]
}

provider "aws" {}