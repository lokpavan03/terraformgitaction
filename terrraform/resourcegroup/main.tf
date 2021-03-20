terraform {
  backend "remote" {
    organization = "loktf"

    workspaces {
      name = "terraform"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

#Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "TFCloudRG007"
  location = "West Europe"
}

#Create a Virtual Network with resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "Vnet-tf"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
  tags = {
        environment = "Terraform Cloud Demo"
    }
}

resource "azurerm_subnet" "subnet" {
  name                 = "Subnet01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#     }
#   }
}

# Create public IPs
resource "azurerm_public_ip" "pip" {
    name                         = "myPublicIP"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Cloud Demo"
    }
}

resource "azurerm_network_security_group" "nsg" {
    name                = "TFC_NSG"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Cloud Demo"
    }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
    name                      = "myNIC"
    location                  = azurerm_resource_group.rg.location
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.pip.id
    }

    tags = {
        environment = "Terraform Cloud Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "ngsa" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.rg.name
    }

    byte_length = 8
}

# # Create storage account for boot diagnostics
# resource "azurerm_storage_account" "mystorageaccount" {
#     name                        = "diag${random_id.randomId.hex}"
#     resource_group_name         = azurerm_resource_group.rg.name
#     location                    = azurerm_resource_group.rg.location
#     account_tier                = "Standard"
#     account_replication_type    = "LRS"

#     tags = {
#         environment = "Terraform Cloud Demo"
#     }
# }

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = "TFCloud"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.nic.id]
    size                  = "Standard_B1s"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = "azureuser"
    admin_password = "Password1234!"
    disable_password_authentication = false

    tags = {
        environment = "Terraform Cloud Demo"
    }
}
