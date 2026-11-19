provider "aws" {
  region  = "us-east-1"
  profile = "estudos"

  default_tags {
    tags = {
      Projeto    = "02-site-estatico"
      Gerenciado = "terraform"
    }
  }
}