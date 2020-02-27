# Example of using ansible for container orchestration

## Setup

 1. Create AWS account
 2. Add AWS credentials for the profile `ansible-orchestration`
 3. Add your public ssh key in `instance-mod/variables.tf`
 3. Install `terraform`
 4. Install python dependencies: `pipenv install`
 5. Run `terraform apply`
 6. Run `ansible playbook install.yaml`
 6. Run `ansible playbook --extra-vars version=latest --extra-vars tg_name=<terraform output tg-name> deploy.yaml`
