<p align="center">
<img src="https://github.com/kura-labs-org/kuralabs_deployment_1/blob/main/Kuralogo.png">
</p>
<h1 align="center">Terraform Automating Banking application<h1> 

## Planning

<img width="601" alt="Screenshot 2023-10-29 at 8 58 30 PM" src="https://github.com/Jmo-101/automate_tf_bankapp/assets/138607757/81216153-4969-42c2-b657-50c6535640fa">

## Purpose
This project demonstrates the understanding of Terraform to deploy instances in 2 AWS regions. It also involves using Git commands in the command line to branch and push out code to the repository. Additionally, the project showcases the usage of Amazon RDS as a database to store banking client/user data.

## Terraform Configuration (v1)
In the initial Terraform configuration, an existing Terraform file within a default VPC was used. This file was configured to create a VPC containing two Amazon EC2 instances within an availability zone and public subnet. One instance hosted the Jenkins manager, while the second instance housed a Jenkins agent with Terraform installed.

## Terraform Configuration (v2)
In the updated Terraform configuration, two separate VPCs were created, one in US-east-1 and the other in US-west-2. Each VPC was configured to have 2 availability zones and 2 public subnets housing the EC2 instances. Security ports 8000 were opened for application access within each VPC.

## Git Integration
Within the Jenkins agent instance, Git commands were utilized to interact with the repository:
- `git init`: Initializes the local Git repository.
- `git clone [repository_url]`: Clones the repository to the local machine.
- `git add .`: Adds all files to be staged for commit.
- `git commit -m "[commit_message]"`: Commits the staged changes with an appropriate message.
- `git push origin [branch_name]`: Pushes the changes to the remote repository.
