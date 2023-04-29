# Add a non-www record to the domain
resource "cloudflare_record" "root" {
  zone_id = var.cloudflare_zone
  name    = "@"
  value   = "tim-dean.com.s3-website-us-east-1.amazonaws.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# Add a www record to the domain
resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone
  name    = "www"
  value   = "tim-dean.com.s3-website-us-east-1.amazonaws.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

# Cloudflare page rule logic
resource "cloudflare_page_rule" "https" {
  zone_id = var.cloudflare_zone
  target  = "*.${var.site_domain}/*"
  actions {
    always_use_https = true
  }
}

# Redirect tim-dean.com/learn to Terraform cause why not
resource "cloudflare_page_rule" "redirect_to_learn" {
  zone_id = var.cloudflare_zone
  target  = "${var.site_domain}/learn"
  actions {
    forwarding_url {
      status_code = 302
      url         = "https://learn.hashicorp.com/terraform"
    }
  }
}

# Block potentially malicious countries.
resource "cloudflare_filter" "block_ips_from_countries" {
  zone_id     = var.cloudflare_zone
  description = "Block IPs from different countries"
  expression  = "(not ip.geoip.country in {\"US\" \"CA\"})"
}

resource "cloudflare_firewall_rule" "block_ips_from_countries" {
  zone_id     = var.cloudflare_zone
  description = "Block IPs from different countries"
  filter_id   = cloudflare_filter.block_ips_from_countries.id
  action      = "block"
  priority    = 2
}
