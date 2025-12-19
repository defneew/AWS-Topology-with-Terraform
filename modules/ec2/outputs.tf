output "ec2_ids" {
  value = [
    aws_instance.ec2_a.id,
    aws_instance.ec2_b.id
  ]
}
