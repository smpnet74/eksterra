provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "null_resource" "buildeks" {
  provisioner "local-exec" {
    command = <<EOH
     wget https://github.com/weaveworks/eksctl/releases/download/0.26.0/eksctl_Linux_amd64.tar.gz
     tar -zxf ./eksctl_Linux_amd64.tar.gz
     rm ./eksctl_Linux_amd64.tar.gz
     ./eksctl create cluster -f eksctl.yaml
 EOH
  }
}

resource "null_resource" "destroyeks" {
  provisioner "local-exec" {
    when    = destroy
    command = <<EOH
     wget https://github.com/weaveworks/eksctl/releases/download/0.26.0/eksctl_Linux_amd64.tar.gz
     tar -zxf ./eksctl_Linux_amd64.tar.gz
     rm ./eksctl_Linux_amd64.tar.gz
     ./eksctl delete cluster -f eksctl.yaml
 EOH
  }
}
