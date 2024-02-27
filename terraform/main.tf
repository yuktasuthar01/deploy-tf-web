module "rg" {
  source = "./modules/rg"

  resource_group_name = "terraform-testing"
  location            = "eastus"

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
        docker_image_name = "nginx"
        docker_registry_url = "https://hub.docker.com/"
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


module "azurerm_container_registry" {
  source = "./modules/Containers/container-registry"

  resource_group_name = module.rg.name
  location            = module.rg.location

  container_registry_config = {
    name                          = "mern-app-registry"
    admin_enabled                 = true
    sku                           = "Standard"
    public_network_access_enabled = true
    quarantine_policy_enabled     = true
    zone_redundancy_enabled       = true
  }

  tags       = {
    environment = "dev"
    project ="mern-app"
  }
}

module "virtual_network" {
  source = "./modules/vnet"
  subnets = [
    {
      name           = "subnet1"
      address_prefix = "10.0.0.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.1.0/24"
    }

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

module "cosmosdb_mongodb" {
  source              = "./modules/mongodb"
  cosmo_account_name  = "login-register-app"
  location            = module.rg.location
  resource_group_name = module.rg.name
  offer_type          = "Standard"
  kind                = "MongoDB"
  backup_type         = "Continuous"
  capabilities = [{
    name = "EnableMongo"
  }]  
  # create_mode = "Restore" 

  public_network_access_enabled = true
  # cosmo_account_name                  = "db-name"
  # throughput                    = 400
  geo_location = [
    {
      location          = module.rg.location
      failover_priority = 0
      zone_redundant    = false
    }
  ]
  consistency_policy = {
    consistency_level = "Session"
    # max_interval_in_seconds = 10
    # max_staleness_prefix    = 200
  }

  tags = {
    environment = "dev"
    project     = "demo"
  }
}

