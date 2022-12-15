# EagleRock API service

## What's done and not done

done
* Dockerfile + associated ci/ scripts to build, test and run the .Net locally or on the target EKS cluster
* Kubernetes configs deployed to test EKS cluster in AWS with test ECR register.  The eaglerock-api scales between 3 and 10 replicas.

not done
* .Net app build is MVP.  TODO: in the build phase, output a .dll artifact properly so that the production docker artifact is pre-compiled and does not contain Test related files or plain text source code.  This is more reliable and safer for prod as the container will start faster and use less CPU when starting (compiling at runtime is unnecessary).  I've not used .Net before, spent some time on this but couldn't quite get this to work properly.
* SSL on the ELB and on the eaglerock-api.  Its using HTTP port 80
* HelloWorld class should be called EagleRockApi
* /healthz endpoint doesn't actually do any health checking
* IP whitelist likely needed on the ELB (assuming the EagleBot devices come from a known IP range)

## Assumptions

ECR registry per AWS account
* dev/test images stay in the CI AWS ECR registry
* prod images are copied from CI to the prod ECR registry

self hosted gitlab runners
* runners in the CI account have a sufficient AWS role to perform ECR push/pull and login to EKS
* OIDC based access is finer grained and preferred.  I've not used gitlab before (but read some docs) and can see that OIDC is supported.  I'd need to test this out first before proposing a pseudo script to do this.

eaglerock-api ELB is associated with the kubernetes service directly
* this means during a kube cluster redeployment, there'd be a new ELB created on the new cluster for the duplicate eaglerock-api
* My assumption for significant upgrades is the DNS CNAME (that the EagleBot clients use) will be updated to point to the relevant ELB(s).  Or a routing layer added in the front to mask the dual ELB problem from EagleBot clients.  Either way, upgradability is solvable.

Logging, monitoring
* I've assumed container logs and metrics are transported somewhere useful.

