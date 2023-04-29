# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.aws_region
  shared_config_files      = ["C:/users/timot/.aws/conf"]
  shared_credentials_files = ["C:/users/timot/.aws/credentials"]
  profile                  = "default"
}

provider "cloudflare" {
  api_token       = var.cloudflare_api_token
}