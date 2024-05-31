# 2022-24.DEVOP.UFS08

## gcloud setup               linen-striker-424313-i7

Clean up previous session

`gcloud auth revoke --all`

`gcloud auth application-default revoke`

Auth both for gcloud commands and third party usage (eg. Terraform)

`gcloud auth login --no-launch-browser`

`gcloud auth application-default login`

List all projects

`gcloud projects list --format json`

Use the first Project ID as the default one

`export TF_VAR_GOOGLE_CLOUD_PROJECT_ID=$(gcloud projects list --format json | jq -r '.[0].projectId')`

`echo $TF_VAR_GOOGLE_CLOUD_PROJECT_ID`

`gcloud config set project $TF_VAR_GOOGLE_CLOUD_PROJECT_ID`

Enable one specific Google Cloud API

`gcloud services enable compute.googleapis.com`
