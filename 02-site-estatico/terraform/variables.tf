variable "bucket_name" {
  description = "Nome globalmente único do bucket que guarda o site"
  type        = string
  default     = "site-estudos-luizhp-tf"

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "O nome do bucket precisa ter entre 3 e 63 caracteres."
  }
}