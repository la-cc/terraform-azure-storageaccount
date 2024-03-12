variable "name" {
  type        = string
  description = "Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
}


variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "westeurope"
}

variable "account_tier" {
  type        = string
  description = "Valid options are Standard and Premium."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Valid options are LRS, GRS, RAGRS and ZRS."
  default     = "LRS"
}

variable "account_kind" {
  type        = string
  description = "Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "StorageV2"
}

variable "access_tier" {
  type        = string
  description = "Valid options are Hot and Cool."
  default     = "Hot"
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow or disallow public access to all blobs or containers in the storage account."
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_0 for new storage accounts."
  default     = "TLS1_2"
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled."
  default     = true
}

variable "containers" {
  type        = map(string)
  description = <<-EOT
    Optionally define one or more storage containers as a map in the following manner:
    <name> = <container_access_type>

    name: may only contain lowercase letters, numbers, and hyphens, and must begin with a letter or a number. Each hyphen must be preceded and followed by a non-hyphen character. The name must also be between 3 and 63 characters long.
    container_access_type: The Access Level configured for this Container. Possible values are blob, container or private.
  EOT

  default = {}
}

variable "file_shares" {
  type        = map(number)
  description = <<-EOT
    Optionally define one or more file shares as a map in the following manner:
    <name> = <quota in GB>

    For example:
    {
      fileshare = 10
    }
    EOT

  default = {}
}

variable "network_rules" {
  type = map(object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  }))

  description = <<-EOT
    Optionally create custom network rules, for example if you want to prohibit public access to the storage account. Only one network rules resource can be tied to a storage account, so define only one entry in the map.
    default_action: Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
    bypass: Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. User has to explicitly set bypass to empty slice ([]) to remove it.
    ip_rules: List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. User has to explicitly set ip_rules to empty slice ([]) to remove it.
    virtual_network_subnet_ids: A list of virtual network subnet IDs to secure the storage account. User has to explicitly set virtual_network_subnet_ids to empty slice ([]) to remove it.
  EOT

  default = {}
}

variable "index_path" {
  description = "path from your repo root to index.html"
  default     = "index.html"
}

variable "custom_404_path" {
  description = "path from your repo root to your custom 404 page"
  default     = "404.html"
}

variable "tags" {
  type        = map(string)
  description = "Defines the default tags.  Some tags like owner are enforced by Azure policies. "
  default = {
    TF-Managed  = "true"
    TF-Worfklow = ""
    Maintainer  = ""
  }
}
