# Deployment Verification Checklist

Use this checklist only when the advanced stack is actually deployed in an AWS account. Do not mark evidence as complete until it has been observed and tested.

## Before apply

- [ ] AWS credentials or SSO session are configured locally
- [ ] `terraform fmt -check -recursive` passes
- [ ] `terraform init` succeeds
- [ ] `terraform validate` succeeds
- [ ] `terraform plan` has been reviewed
- [ ] Expected AWS cost is understood
- [ ] `terraform.tfvars` contains the intended Availability Zones
- [ ] If HTTPS is enabled, the Route53 hosted zone already exists

## Remote state

- [ ] State S3 bucket created with versioning enabled
- [ ] State bucket public access blocked
- [ ] State encryption enabled
- [ ] DynamoDB lock table created
- [ ] Advanced environment initialized with `backend.hcl`

## Networking

- [ ] VPC created
- [ ] Two public subnets created across separate Availability Zones
- [ ] Two private application subnets created
- [ ] Two private data subnets created
- [ ] Internet Gateway attached
- [ ] NAT Gateway present in each Availability Zone
- [ ] Public and private routes verified

## Traffic and compute

- [ ] Application Load Balancer is active
- [ ] Auto Scaling Group reaches desired capacity
- [ ] EC2 application instances have no public inbound SSH requirement
- [ ] Target group reports healthy instances
- [ ] ALB endpoint returns the application page
- [ ] Scaling policy is visible on the Auto Scaling Group

## Database and storage

- [ ] RDS PostgreSQL is not publicly accessible
- [ ] RDS Multi-AZ is enabled
- [ ] RDS encryption is enabled
- [ ] RDS master password is managed by AWS Secrets Manager
- [ ] EFS is encrypted
- [ ] EFS mount targets exist in both application Availability Zones
- [ ] Database and EFS security groups only allow traffic from the application tier

## Monitoring

- [ ] Auto Scaling in-service capacity alarm exists
- [ ] RDS high CPU alarm exists
- [ ] RDS low free storage alarm exists
- [ ] CloudWatch metrics are visible for the deployed resources

## HTTPS / DNS when enabled

- [ ] ACM certificate status is `Issued`
- [ ] Route53 alias points to the ALB
- [ ] HTTP redirects to HTTPS
- [ ] HTTPS endpoint loads successfully

## Portfolio evidence to capture

Capture only sanitized evidence with no credentials, account IDs, secrets, private IP information that should remain private, or sensitive business data.

- [ ] Terraform apply summary
- [ ] ALB healthy target screenshot
- [ ] Auto Scaling Group instance health screenshot
- [ ] RDS Multi-AZ configuration screenshot
- [ ] EFS mount-target screenshot
- [ ] CloudWatch alarm screenshot
- [ ] HTTPS endpoint screenshot if configured
- [ ] `terraform output` with sensitive values excluded

## Cleanup

For a temporary portfolio deployment, run a reviewed destroy plan when finished to avoid unnecessary AWS charges. The remote-state bucket has `prevent_destroy` enabled and should be handled separately from the application stack.
