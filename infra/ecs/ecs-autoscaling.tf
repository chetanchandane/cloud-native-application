resource "aws_appautoscaling_target" "ecs_target" {
    max_capacity = 3
    min_capacity = 1
    resource_id = "service/${aws_ecs_cluster.ecs-pro-cluster.name}/${aws_ecs_service.my_ecs_service.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "scale-up" {
    name = "scale-up"
    policy_type = "StepScaling"
    resource_id = aws_appautoscaling_target.ecs_target.resource_id
    scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
    service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

    target_tracking_scaling_policy_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ECSServiceAverageCPUUtilization"
      }
      target_value = 75.0
    }
}

resource "aws_appautoscaling_policy" "sacle-down" {
    name = "scale-down"
    policy_type = "StepScaling"
    resource_id = aws_appautoscaling_target.ecs_target.resource_id
    scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
    service_namespace = aws_appautoscaling_target.ecs_target.service_namespace

    target_tracking_scaling_policy_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ECSServiceAverageCPUUtilization"
      }
      target_value = 25.0
    }
}
