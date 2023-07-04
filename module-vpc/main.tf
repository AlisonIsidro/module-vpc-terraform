module "vpc" {
  source = "./modules/vpc"
  cidr   = "192.168.0.0/16"
  name = "wikijs"
  private_subnets = "192.168.1.0/24"
  public_subnets  = "192.168.2.0/24"
  az              = ["us-east-2a", "us-east-2b"]
  cidr_rt         = "0.0.0.0/0"
}