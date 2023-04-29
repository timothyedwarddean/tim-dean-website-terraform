# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "aws_region" {
  type        = string
  description = "The AWS region to put the bucket into"
  default     = "us-east-1"
}

variable "site_domain" {
  type        = string
  description = "The domain name to use for the static site"
  default     = "tim-dean.com"
}

variable "cloudflare_api_token" {
  description = "cloudflare api token"
  default = "ENTER_API"
}

variable "cloudflare_zone" {
  description = "cloudflare Zone Id"
  default = "ENTER_ZONE"
}