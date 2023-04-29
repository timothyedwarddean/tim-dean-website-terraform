# Create root S3 bucket hosting website.
resource "aws_s3_bucket" "site" {
  bucket = "tim-dean.com"
  force_destroy = true
}

# Configure static website.
resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Configure the ability to GetObjects in S3 for website docs.
resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id
  acl = "public-read"
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.site.arn,
          "${aws_s3_bucket.site.arn}/*",
          "${aws_s3_bucket.site.arn}/*",
        ]
      },
    ]
  })
}

# Create www. S3 bucket that will redirect to tim-dean.com
resource "aws_s3_bucket" "www" {
  bucket = "www.tim-dean.com"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "www" {
  bucket = aws_s3_bucket.www.id
  acl = "private"
}

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.www.id
  
  redirect_all_requests_to {
    host_name = aws_s3_bucket.site.bucket
  }
}