provider "aws" {
  profile = "ansible-orchestration"
  region  = "eu-north-1"
}

module "sthlm-instance" {
  source = "./instance-mod"
}
