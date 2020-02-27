# Example of using ansible for container orchestration

## Setup

 1. Create AWS account
 2. Add AWS credentials for the profile `ansible-orchestration`
 3. Add your public ssh key in `instance-mod/variables.tf`
 3. Install `terraform`
 4. Install python dependencies: `pipenv install`
 5. Run `terraform apply`
 6. Run `ansible playbook install.yaml`
 7. Run `ansible playbook --extra-vars version=1.5 --extra-vars tg_name=<terraform output tg-name> deploy.yaml`
 8. Open lb-dns (terraform output) in browser!
