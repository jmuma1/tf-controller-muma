resource "aws_s3_bucket" "ndamukong" {
  bucket = "ndamukong"
}

# resource "aws_s3_bucket_ownership_controls" "ndamukongowner" {
#   bucket = aws_s3_bucket.ndamukong.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }