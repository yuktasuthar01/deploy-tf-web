module "rg" {
  source = "./modules/rg"

  resource_group_name = "demo"
  location            = "centralindia"

}

module "service_plan" {
  source              = "./modules/service-plan"
  location            = module.rg.location
  resource_group_name = module.rg.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = {
    environment = "dev"
    project     = "demo"
  }

}


module "app-service" {
  source              = "./modules/app-service"
  resource_group_name = module.rg.name
  location            = module.rg.location
  linux_web_app_name  = "login-register-app"
  service_plan_id     = module.service_plan.id
  identity_type       = "SystemAssigned"

  settings = {
    site_config = {
      minimum_tls_version = "1.2"
      http2_enabled       = true

      application_stack = {
        node_version = "18-lts"
      }
    }

    auth_settings = {
      enabled                       = false
      runtime_version               = "~1"
      unauthenticated_client_action = "AllowAnonymous"
    }

  }
  tags = {
    environment = "dev"
    project     = "demo"
  }

}

module "virtual_network" {
  source = "./modules/vnet"
  subnets = [
    {
      name           = "subnet1"
      address_prefix = "10.0.0.0/24"
      // Add other subnet attributes as needed
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.1.0/24"
      // Add other subnet attributes as needed
    }
    // Add more subnets as needed
  ]
  virtual_network_name = "test-vnet"
  location             = module.rg.location
  resource_group_name  = module.rg.name
  address_space        = ["10.0.0.0/16"]
  tags = {
    environment = "dev"
    project     = "demo"
  }
}

# module "subnets" {
#   source                = "./modules/vnet/subnets"
#   subnets = "10.0.1.1/16"
#   virtual_network_name  = module.virtual_network.name

# }

// module "cosmosdb_mongodb" {
//source              = "./modules/mongodb"
//cosmo_account_name  = "login-register-app"
//location            = module.rg.location
//resource_group_name = module.rg.name
//backup_type         = "Continuous"
//account_name        = "db_mongo"
//consistency_policy = {
//example_policy_1 = {
// consistency_level       = "BoundedStaleness"
//max_interval_in_seconds = 10
//max_staleness_prefix    = 200
//}
//example_policy_2 = {
// consistency_level       = "Strong"
//max_interval_in_seconds = null
//max_staleness_prefix    = null
//}
//public_network_access_enabled = true  # or false, depending on your requirements
//mongodb_name                  = "example_mongodb"
//account_name                  = "example_account"
//throughput                    = 400  # Example value within the required range
//geo_location = {
// location = "West US"
//failover_priority = 0
// }
//}
//}

module "cosmosdb_mongodb" {
  source              = "./modules/mongodb"
  cosmo_account_name  = "login-register-app"
  location            = module.rg.location
  resource_group_name = module.rg.name
  backup_type         = "Continuous"

  public_network_access_enabled = true # or false, depending on your requirements
  mongodb_name                  = "example_mongodb"
  account_name                  = "example_account"
  throughput                    = 400 # Example value within the required range
  geo_location = {
    location          = "West US"
    failover_priority = 1
    zone_redundancy = "false"
  }

  consistency_policy = {
    example_policy_1 = {
      consistency_level       = "BoundedStaleness"
      max_interval_in_seconds = 10
      max_staleness_prefix    = 200
    }
    example_policy_2 = {
      consistency_level       = "Strong"
      max_interval_in_seconds = null
      max_staleness_prefix    = null
    }
  }
}
