locals {
  common_tags = merge(
    {
      Project   = var.name
      ManagedBy = "Terraform"
      Layer     = "monitoring"
    },
    var.tags
  )
}

resource "aws_cloudwatch_metric_alarm" "asg_low_in_service" {
  alarm_name          = "${var.name}-asg-low-in-service"
  alarm_description   = "Alarm when the Auto Scaling Group has fewer in-service instances than expected."
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "GroupInServiceInstances"
  namespace           = "AWS/AutoScaling"
  period              = 60
  statistic           = "Minimum"
  threshold           = var.minimum_in_service_instances
  treat_missing_data  = "breaching"

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "rds_high_cpu" {
  alarm_name          = "${var.name}-rds-high-cpu"
  alarm_description   = "Alarm when RDS CPU utilization remains high."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  treat_missing_data  = "notBreaching"

  dimensions = {
    DBInstanceIdentifier = var.db_instance_identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "rds_low_storage" {
  alarm_name          = "${var.name}-rds-low-storage"
  alarm_description   = "Alarm when RDS free storage falls below the configured threshold."
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Minimum"
  threshold           = var.db_free_storage_threshold_bytes
  treat_missing_data  = "notBreaching"

  dimensions = {
    DBInstanceIdentifier = var.db_instance_identifier
  }

  tags = local.common_tags
}
