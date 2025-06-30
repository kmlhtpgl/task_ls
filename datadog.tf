locals {
    dd-region = local.account_type == "prod" ? "eu-west-2" : "eu-west-1"
    web_hook = local.account_type == "prod" ? "@bigpanda-prod-unified" : "@bigpanda-prprod-unified" 
}

resource "datadog_dashboard_json" "msk _dashboard" {
    count = ((var.environment == "prod" || var.environment == "qa-nft") && var.market != "all") ? 1 : 0
    provider = datadog.dd
    dashboard = templatefile("./datadog_json/cmprv-msk-rawdata-dashboard.json", {environment = local.env_name, market = local.market})
}

resource "datadog_monitor_json" "cmprv-msk-disk" {
    count = ((var.environment == "prod" || var.environment == "qa-nft") && var.market != "all") ? 1 : 0
    provider = datadog.dd
    dashboard = templatefile("./datadog_json/cmprv-msk-rawdata-dashboard.json", {environment = local.env_name, market = local.market})
}