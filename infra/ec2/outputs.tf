output "region" {
  value =  data.aws_region.usw2.name
}

output "vpc_id" {
  value = module.myvpc.vpc_id
}

output "ec2_ip" {
  value =module.ec2.ec2_ip
}

output "bucket_url" {
  value = "http://${module.s3.bucket_name}.s3.us-west-2.amazonaws.com"
}