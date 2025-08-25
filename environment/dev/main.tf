locals {
  common_tags = {
    "managed"     = "terraform"
    "owner"       = "todo app team"
    "environment" = "dev"
  }
}


module "resource_group" {
  source   = "../../module/azurerm_resource_group"
  rg_name  = "rg-dev-todoapp"
  location = "centralindia"
  tags     = local.common_tags
}

module "acr" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_container_registary"
  acr_name   = "acrdevtodoapp"
  rg_name    = "rg-dev-todoapp"
  location   = "centralindia"
  tags       = local.common_tags

}

module "sql_server" {
  depends_on      = [module.resource_group]
  source          = "../../module/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp"
  rg_name         = "rg-dev-todoapp"
  location        = "centralindia"
  admin_user_name = "serveradmin"
  admin_password  = "Nidhya@2022"
  tags            = local.common_tags

}

module "sql_database" {
  depends_on  = [module.sql_server]
  source      = "../../module/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "29"
  tags        = local.common_tags
}

module "AKS" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_kubernets_cluster"
  aks_name   = "aks-dev-todoapp"
  location   = "centralindia"
  rg_name    = "rg-dev-todoapp"
  dns_prefix = "aks-dev-todoapp"
  # node_count = 2
  # vm_size    = "Standard_D2_v2"
  tags = local.common_tags

}
