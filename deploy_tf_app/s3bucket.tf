terraform {
  backend "s3" {
    bucket = "weahteraws"
    key    = "terra-form-state-sunday"
    region = "us-west-1"
  }
}

