# Output the Public IP address of our EC2 instance.
# We will need this IP to connect via SSH and to access our app.
output "instance_public_ip" {
  value       = aws_instance.app_server.public_ip
  description = "The public IP address of the EC2 instance."
}

# Output the command to SSH into the server.
output "ssh_command" {
  value       = "ssh -i ${local_file.ssh_private_key.filename} ubuntu@${aws_instance.app_server.public_ip}"
  description = "The command to SSH into the server."
}