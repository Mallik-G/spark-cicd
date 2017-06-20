output "jenkins-ip" {
  value = "${aws_instance.jenkins-instance.public_ip}"
}
output "jenkins-dns" {
  value = "${aws_instance.jenkins-instance.public_dns}"
}
