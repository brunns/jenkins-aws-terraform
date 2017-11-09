# jenkins-aws-terraform

Simplest possible Jenkins on AWS using Terraform.

## Some useful commands

    terraform plan -var-file my.ftvars
    terraform apply -var-file my.ftvars && instance_ip=`terraform output instance-ip`

    ssh -t centos@$instance_ip 'less +F /var/log/cloud-init-output.log' # See what's going on
    ssh -t centos@$instance_ip 'curl 0.0.0.0:8080' # Is Jenkins running?

    terraform destroy -var-file my.ftvars
