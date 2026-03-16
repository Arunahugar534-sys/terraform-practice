#Creating S3 bucket 
resource "aws_s3_bucket" "mybucket" {
    bucket = "example-lambda-to-s3-bucket-demo"
}

#Create S3 object

resource "aws_s3_object" "object" {
    bucket = aws_s3_bucket.mybucket.id
    key = "lambda/lambda_function.zip"
    source = "lambda_function.zip"
    etag = filemd5("lambda_function.zip")
}

#Creating IAM role

resource "aws_iam_role" "lambda_admin_role" {
  name = "lambda_admin_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

#Attach policy to lambda function
resource "aws_iam_role_policy_attachment" "lambda-role" {
    role = aws_iam_role.lambda_admin_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#Create role for s3 bucket

/*resource "aws_iam_role" "s3-role"{
    name = "s3_admin"
    assume_role_policy = jsondecode(
        {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
    )
}*/

#Attach policy to s3

resource "aws_iam_role_policy_attachment" "s3-role" {
    role = aws_iam_role.lambda_admin_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


#Creating lambda function

resource "aws_lambda_function" "my_lambda" {
    function_name = "lambda-to-s3"
    role = aws_iam_role.lambda_admin_role.arn
    handler = "lambda_function.lambda.handler"
    runtime = "python3.11"
    timeout = 900
    memory_size = 128



 # 🔑 Code pulled from S3 (NOT local)
    s3_bucket = aws_s3_bucket.mybucket.id
    s3_key = aws_s3_object.object.key
#source_code_hash = filebase64("lambda_function.zip")
    depends_on = [ aws_s3_bucket.mybucket ]
    
}