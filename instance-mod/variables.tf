variable "amis" {
  description = "Map with amis"
  default = {
    "eu-north-1"   = "ami-01d965b90792d9bf7"
    "eu-central-1" = "ami-04cc9fe9200c6ec8c"
    "eu-west-1"    = "ami-02e17a1a8168436f5"
  }
}

variable "public-key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQHde4y3bjidC7XpXOLwqe5TiXHFXgHYECe612cE32E9zn4JiBV3J7fKCLUxCVK3+jClJEQr263V75YQwD1giR3nhB9rkEAdXJra506hmSSxEn4Gm/KnzUc411RcCggcBNNbUGQ3FxM7M7cMkS4iFJb2erkVHFc1Gc4+nSBrSxCWbCTS6DQVm4hE3eFP7IGvwzbPPj6YtBIxpPzQvhkVgjZtY9IZbCCp+Z7ctcQkbb0ox6USJHJmIYDaGEBbqMAesfZHhnG0cGDDRRzl5Xk/yLA7wpb40Grt1tCucXsUdXdJpD2xxiBYPtyK1j7kkU4Me4rNAMBZA6MVBADjj85q2j mattias"
}
