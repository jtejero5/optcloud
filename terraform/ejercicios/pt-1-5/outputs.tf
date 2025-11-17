# Output de les instàncies públiques
output "public_instance_ips" {
  description = "ID, IP pública i IP privada de les instàncies públiques"
  value = [
    for instance in aws_instance.public : {
      id         = instance.id
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  ]
}

# Output de les instàncies privades
output "private_instance_ips" {
  description = "ID, IP pública i IP privada de les instàncies privades"
  value = [
    for instance in aws_instance.private : {
      id         = instance.id
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  ]
}

# Output del bucket S3 (si s'ha creat)
output "s3_bucket_name" {
  description = "Nom del bucket S3 creat (si create_s3_bucket és true)"
  value       = var.create_s3_bucket ? aws_s3_bucket.optional[0].bucket : null
}