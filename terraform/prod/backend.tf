terraform {
  backend "gcs" {
    bucket = "tf-storage-bucket"
    prefix = "reddit/prod"
  }
}
