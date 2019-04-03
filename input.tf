variable "subscription_id" {
  type = "string"
}

variable "client_id" {
  type = "string"
}

variable "troux_id" {
  type        = "string"
  description = "A valid Application TrouxID must begin with 'A', see http://troux.intranet.group/"
}

variable "resource_owner" {
  type        = "string"
  description = "The name of the person who is the application owner, or requestor"
}

variable "lbg_cost_center" {
  type        = "string"
  description = "Cost center that will be billed for the costs of running this VM"
}

variable "resource_expiry_date" {
  type        = "string"
  description = "Date after which we could consider removing"
}

variable "extra_tags" {
  type        = "map"
  description = "Extra tags to be added to the base set"
  default     = {}
}

variable "location" {
  type = "string"
}

variable "environment" {
  type = "string"
}

variable "tf_state_storage_account" {
  type = "string"
}

variable "tf_state_container_name" {
  type = "string"
}

variable "mgmt_network_tf_state_key" {
  type = "string"
}

variable "subscriptions_tf_state_key" {
  type = "string"
}

variable "aad_user_directory" {
  type = "string"
}
