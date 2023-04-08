//   *********************************************VPC*********************************************

// For VPC
vpc_cidr_block = "10.0.0.0/16"
route_cidr = "0.0.0.0/0"
IGW_tag = "Internet_gate_way"
vpc_tag = "VPC_TF"
RT_tag = "Route_Table"

az_public_subnet = {
  "ap-south-1a" : "10.0.0.0/24",
  "ap-south-1b" : "10.0.1.0/24"
}

az_private_subnet = {
  "ap-south-1a" : "10.0.101.0/24",
  "ap-south-1b" : "10.0.102.0/24"
}

az_database_subnet = {
  "ap-south-1a" : "10.0.201.0/24",
  "ap-south-1b" : "10.0.202.0/24"
}

availability_zones = [
  "ap-south-1a",
  "ap-south-1b" 
]
//   *********************************************WEB TIER*********************************************

// For Web_tier load_balancer

  lb_name = "Web-Tier-load-balancer"
  alb_SG-name = "Security-group-for-ALB"
  ports = [80,443,22]
  SG_tag = "SG-1"
  listner_port = "80"
  listner_protocol = "HTTP"
  TG_name = "Target-group-for-Web-tier"
  TG_port = "80"
  TG_protocol = "HTTP"

  // For Web_Tier Auto_Scaling_Group

  
  web_SG_name = "web_security_group"
  key_name = "key-tf"
  ami = "ami-0f8ca728008ff5af4"
  instance_type = "t2.micro"
  name_prefix = "web_launch_template"
  min_size = "1"
  max_size = "5"
  desired_capacity = "3"

//   *********************************************APP TIER*********************************************

  // For App_Tier load balancer

  app_alb_name = "app-app-lb"
  app_alb_SG_name = "alb-app-security-group"
  app_listener_port = "80"
  app_listener_protocol = "HTTP"
  app_TG_name = "app-target-group"
  app_TG_port = "80"
  app_TG_protocol = "HTTP"
  
  //For App_Tier Auto_Scaling

  app_instance_SG_name = "app-server-security-group" 
  app_ami = "ami-0f8ca728008ff5af4"
  app_instance_type = "t2.micro"
  app_name_prefix = "app-launch-template"
  app_desired_capacity = "3"
  app_max_size = "5"
  app_min_size = "1"
  
//   *********************************************THE DB*********************************************

  // For Data base


  db_SG_name = "db_Security_Group"
  db_name = "dbpostgres"
  username = "uzair"
  password = "uzair123456"
  db_port = "5432"
  allocated_storage = "256" # gigabytes
  backup_retention_period = "7"   # in days
  engine = "postgres"
  engine_version = "14.7"
  identifier = "dbpostgres"
  instance_class = "db.t3.micro"
  db_storage_type = "gp2"