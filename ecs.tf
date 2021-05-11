resource "aws_ecs_cluster" "main" {
  name = "${var.name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "my-app" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_cpu}"
  memory                   = "${var.fargate_memory}"

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${var.app_image}",
    "memory": ${var.fargate_memory},
    "name": "${var.name}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "cntr1" {
  name            = "${var.name}-ecs-service1"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.my-app.arn}"
  desired_count   = "${var.app_count}"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = ["${aws_security_group.ecs.id}"]
    subnets = ["${aws_subnet.private_subnet_1.id}"]
#    subnets = ["${element(data.aws_subnet_ids.private.ids, count.index)}"]
  }
}

resource "aws_ecs_service" "cntr2" {
  name            = "hashout-ecs-service2"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.my-app.arn}"
  desired_count   = "${var.app_count}"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = ["${aws_security_group.ecs.id}"]
    subnets = ["${aws_subnet.private_subnet_2.id}"]
#    subnets = ["${element(data.aws_subnet_ids.private.ids, count.index)}"]
  }
}
