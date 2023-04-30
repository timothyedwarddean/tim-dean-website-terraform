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
  default     = "TOKEN-HERE"
}

variable "cloudflare_zone" {
  description = "cloudflare Zone Id"
  default     = "ZONE-HERE"
}

variable "name_servers" {
  type    = list(string)
  default = [ "cory.ns.cloudflare.com", "mimi.ns.cloudflare.com" ]
}