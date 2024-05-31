terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
    archive = {
      source = "hashicorp/archive"
      version = "2.4.2"
    }
  }
}

variable "GOOGLE_CLOUD_PROJECT_ID" {
  type = string
}
//
provider "google" {
  project = var.GOOGLE_CLOUD_PROJECT_ID
}
provider "archive" {
  # Configuration options
}

resource "google_storage_bucket" "bucket" {
  name     = "my-test-bucket-hasban"
  location = "US"
}

data "archive_file" "dotfiles" {
  type        = "zip"
  output_path = "${path.module}/function-artifacts/index.zip"
    source_dir = "./function-source"
}
resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./function-artifacts/index.zip"
}
resource "google_cloudfunctions_function" "function" {
  name        = "function-2"
  description = "My function"
  runtime     = "nodejs16"
  region = "us-central1"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloGET"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}