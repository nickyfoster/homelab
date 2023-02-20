# Amazon EKS Production ready demo cluster

This repo includes IaaC state for spinning up EKS cluster inside AWS. The cluster will be configured as production ready with multiAZ storage, ALB and externalDNS addon.

## Prerequisites

- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) on your workstation/server
- Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) on your workstation/server
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) on your workstation/server

## Content

- [manifests](/manifests) - kubernetes yaml samples that are used throughout the blog


## Access EKS

Update kubeconfig with the following command:

```
aws eks update-kubeconfig --region AWS_REGION --name CLUSTER_NAME --alias eks-dev
```


