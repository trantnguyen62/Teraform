provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "example" {
  bucket        = "kaizen-tran859"
  force_destroy = true


}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [aws_s3_bucket.example]

  create_duration = "10s"
}

resource "aws_s3_object" "object" {
  depends_on    = [time_sleep.wait_10_seconds]
  bucket        = "kaizen-tran859"
  force_destroy = true
  key           = "main.tf"
  source        = "main.tf"


}

resource "aws_s3_bucket" "example2" {
  bucket_prefix =  "kaizen-"
  force_destroy = true


}
