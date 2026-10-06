output "alarm_names" {
  description = "CloudWatch alarm names created by this module."
  value = [
    aws_cloudwatch_metric_alarm.asg_low_in_service.alarm_name,
    aws_cloudwatch_metric_alarm.rds_high_cpu.alarm_name,
    aws_cloudwatch_metric_alarm.rds_low_storage.alarm_name
  ]
}
