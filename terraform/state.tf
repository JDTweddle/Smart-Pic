
terraform {
    backend "s3" {
        bucket = "bucket-name"
        key = "global/s3/terrafrom.tfstate"
        region = "you-region"
        
    }
}
