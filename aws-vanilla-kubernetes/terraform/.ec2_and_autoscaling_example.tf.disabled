# min 1, des 2, max 3
# if cpu more 80% we scale up
# if CPU lesss 30% we scale down

resource "aws_launch_template" "tf-test" {
  name_prefix   = "test"
  image_id      = "ami-0ff39345bd62c82a5"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0669581bf5aeb0489"]
}

resource "aws_autoscaling_group" "tf-asg" {
  availability_zones = ["us-east-2a"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.tf-test.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "tf-simple-upscale" {
  name                   = "terraform-upscale"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tf-asg.name
}

resource "aws_autoscaling_policy" "tf-simple-downscale" {
  name                   = "terraform-downscale"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tf-asg.name
}

resource "aws_cloudwatch_metric_alarm" "tf-alarm-cpu-above" {
  alarm_name          = "terraform-cpu-above"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.tf-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.tf-simple-upscale.arn]
}

resource "aws_cloudwatch_metric_alarm" "tf-alarm-cpu-below" {
  alarm_name          = "terraform-cpu-below"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.tf-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.tf-simple-downscale.arn]
}