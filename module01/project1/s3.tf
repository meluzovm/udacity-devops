resource "aws_s3_bucket" "staticsite" {
  bucket = "mm-udacity-staticwebsite"
#  bucket = "my-${var.aws_account}-bucket"
  # acl    = "public-read-write"
  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name = "mm-udacity-staticwebsite"
  }
}

#aws s3 sync ~/Downloads/udacity-starter-website/. s3://my-827609500002-bucket/   

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.staticsite.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}


resource "aws_s3_bucket_policy" "policy1" {
  bucket = aws_s3_bucket.staticsite.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = <<EOF
{
  "Id": "Policy1620835039383",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1620835037466",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::mm-udacity-staticwebsite/*",
      "Principal": "*"
    }
  ]
}
EOF  
}

## IAM Policy for CF
##  "Statement": [
##    {
##      "Sid": "Stmt1620835037466",
##      "Action": [
##        "s3:GetObject"
##      ],
##      "Effect": "Allow",
##      "Resource": "arn:aws:s3:::mm-udacity-staticwebsite/*",
##      "Principal": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E3LFAEPXT4P66T"
##
##    }
##    ]