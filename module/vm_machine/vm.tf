resource "azurerm_network_interface" "vm_a_nic" {
  name                = "${var.vm_name}-nic-a"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.private_subnet_a_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "vm_b_nic" {
  name                = "${var.vm_name}-nic-b"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.private_subnet_b_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm_a" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.vm_a_nic.id,]
  zone                  = "1"
  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "18.04.202301100"
  }
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/Users/Cgt_Jpr_PC_Admin/.ssh/id_rsa.pub")
  }

  disable_password_authentication = true
}

resource "azurerm_linux_virtual_machine" "vm_b" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.vm_b_nic.id,]
  zone                  = "3"
  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "18.04.202301100"
  }
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/Users/Cgt_Jpr_PC_Admin/.ssh/id_rsa.pub")
  }

  disable_password_authentication = true
}