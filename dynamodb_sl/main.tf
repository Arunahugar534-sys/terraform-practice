resource "aws_s3_bucket" "name" {
    bucket = "terraform-s3-bucket-practice-demo2"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.name.id

    versioning_configuration {
       status = "Enabled"
    }
}

