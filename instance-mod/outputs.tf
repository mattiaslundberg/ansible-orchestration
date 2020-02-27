output "tg-name" {
  value = aws_lb_target_group.main.name
}

output "lb-dns" {
  value = aws_lb.main.dns_name
}
