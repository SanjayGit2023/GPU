# DEFINE ALL YOUR VARIABLES HERE

instance_type = "g4dn.xlarge"
ami           = "ami-0866a3c8686eaeeba"   # Ubuntu 24.04
key_name      = "modelkey"                     # Replace with your key-name without .pem extension
volume_size   = 20
region_name   = "us-east-1"
server_name   = "AI model-SERVER"

# Note: 
# a. First create a pem-key manually from the AWS console
# b. Copy it in the same directory as your terraform code
