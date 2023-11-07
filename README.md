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

## Databases

To enhance security and minimize the risk of breaches, I utilized Amazon Web Services' managed database service known as Amazon RDS (Relational Database Service). Instead of having aech application have its own dedicated database within their own instance we used RDS. This approach allowed me to store data from all of the applications, irrespective of their region. Each RDS instance was housed within its own security group, ensuring isolation and security.

To access the databases from our applications, I included the respective database endpoint in our `database`, `load_data`, and `app` files.

## Jenkins Integration

### Jenkinsfile Automation

I implemented a Jenkins pipeline (Jenkinsfile) to automate the deployment process. The pipeline consisted of stages that consisted of  `terraform init`, `terraform plan` and `terraform apply`. 

### Terraform Integration

Within the Jenkinsfile, stages were added to interact with Terraform scripts (`initTerraform`). These Terraform scripts were designed to create instances in both the east and west regions of AWS. The scripts also included necessary user data configurations, ensuring that the instances were provisioned with all required dependencies for deploying my applications.

To enable Jenkins to interact with AWS and deploy the applications, AWS credentials were configured within the Jenkins manager. These credentials were used by Jenkins during the execution of the Terraform scripts.

The pipeline successfully executed a multibranch pipeline, automating the deployment process for our applications.

## Applications

### Load Balancers

To optimize my infrastructure and enhance fault tolerance, load balancers were implemented for each regional instance. These load balancers were configured to distribute incoming traffic evenly between the two instances within each region. This load balancing strategy not only optimized resource utilization but also improved the reliability and availability of our applications.

