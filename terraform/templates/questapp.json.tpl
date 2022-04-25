[
  {
    "name": "${container_name}",
    "image": "${image_url}:${image_version}",
    "essential": true,
    "cpu": ${cpu},
    "memory": ${memory},
    "links": [],
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${host_port},
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "SECRET_WORD",
        "value": "illusion"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${log_group}-log-stream"
      }
    }
  }
]