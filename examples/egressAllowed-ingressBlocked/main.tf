module "security_group" {
  source = "../../"
  name   = "my-project-user-api-ecs"
  vpc_id = "vpc_id" # Replace the vpc_id with the desired vpc id.
}