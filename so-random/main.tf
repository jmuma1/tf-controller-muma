# data "terraform_remote_state" "firstfile_data" {
#   backend = "local"

#   config = {
#     path = "../random/terraform.tfstate"
#   }
# }

resource "aws_s3_bucket_acl" "ndamukong" {
#  depends_on = [aws_s3_bucket_ownership_controls.ndamukongowner]

  bucket = var.id
  acl    = "private"
}

# data "aws_iam_policy_document" "ndamukongtopic" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["s3.amazonaws.com"]
#     }

#     actions   = ["SNS:Publish"]
#     resources = ["arn:aws:sns:*:*:s3-event-notification-topic"]

#     condition {
#       test     = "ArnLike"
#       variable = "aws:SourceArn"
#       values   = [aws_s3_bucket.ndamukong.arn]
#     }
#   }
# }

# resource "aws_sns_topic" "ndamukongtopic" {
#   name   = "s3-ndamukong-topic"
#   policy = data.aws_iam_policy_document.ndamukongtopic.json
# }

# resource "aws_s3_bucket_notification" "bucket_notification" {
#   bucket = aws_s3_bucket.ndamukong.id

#   topic {
#     topic_arn     = aws_sns_topic.ndamukongtopic.arn
#     events        = ["s3:ObjectCreated:*"]
#     filter_suffix = ".log"
#   }
# }