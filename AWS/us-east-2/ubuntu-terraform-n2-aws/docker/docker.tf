provider "docker" {
host = "${var.DOCKER_HOST}"
}

# Create a container
resource "docker_container" "docker" {
  image = "${docker_image.ubuntu.latest}"
  name  = "foo"
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}
