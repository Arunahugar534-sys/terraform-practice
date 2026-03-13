terraform {
    backend "s3" {
        bucket = "test-dev-remote-backend-demo"
        key = "terraform.tfstate"
        region = "us-east-1"
        use_lockfile = true
      
    }
}