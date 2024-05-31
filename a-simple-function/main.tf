terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

variable "GOOGLE_CLOUD_PROJECT_ID" {
  type = string
}
provider "google" {
  project = var.GOOGLE_CLOUD_PROJECT_ID
}