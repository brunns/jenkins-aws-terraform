# jenkins-aws-terraform

Simplest possible Jenkins on AWS using Terraform.

## Some useful commands

    terraform plan
    terraform apply

    ssh -t centos@54.152.49.27 'less /var/log/cloud-init-output.log +F' # See what's going on
    ssh -t centos@54.152.49.27 'curl 0.0.0.0:8080' # Is Jenkins running?
    

    terraform destroy
