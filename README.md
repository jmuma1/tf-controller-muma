# tf-controller-muma
Using this link (https://docs.gitops.weave.works/docs/terraform/using-terraform-cr/depends-on/) on leveraging depending management with the terraform flux tf-controller, I am trying to apply a yaml file called tf-resources.yaml in order to create an aws s3 bucket (random/main.tf), and then createin a separate directory (so-random/main.tf), its associated s3 bucket acl, which depends on the id of the s3 bucket created in the 'random/main.tf' directory. However, the example in the link uses an OCI Repository as its source. For my use case, my source is a Git Repository, so the example in the docs is not totally applicable for me. I made changes where necessary to adapt the example to my Git Repository source. When I run [tflctl get] to look at the status of [terraform plan/apply] for the 2 resources in tf-resources.yaml, I get a 'terraform plan' error via the tf-controller when it is time to create the second resource (aws-s3-bucket-acl); [ error running Plan: rpc error: code = Internal desc = variable "id" was required but not supplied ]. I am not sure why as I have provided a variables.tf file with a variable name that matches the variable name I provide in the [as: ] field in tf-resources.yaml

FOR MORE CONTEXT ON HOW I GET TO THIS POINT:
- I create an EKS cluster with flux installed in it (The terraform files for this are not provided)
- I run [ aws eks update-kubeconfig --region us-east-1 --name "name of eks cluster" --dry-run > ~/.kube/config ] to update the certificate in the kubeconfig file
- I run [ kubectl apply -f tf-controller.yaml ] to create the tf-controller that leverages terraform commands
- Finally, I run [ kubectl apply -f tf-resources.yaml] to attempt to create the aws-s3-bucket and its dependent aws-s3-bucket-acl
- Install flux binary
- Install tfctl cli
- ***NOTE: In tf-resources.yaml, I removed the secrets/Private Key for security reasons. If anyone plans to pull this down locally and try to recreate my steps, let me know and I will provide a new secret/private key to use for this issue
- When I check the details of the aws-s3-buckets-outputs secret that gets created, I see the base64 encoded id is in there. To further confirm that the right bucket id is outputted and stored in this aws-s3-buckets-outputs secret, I use a base64 converter, which assures me the converted code is the desired name/id of the s3 bucket
- The aws-s3-bucket is successfully created as it shows up in the console and after running [ tfctl get ] a couple times to the status update on the terraform plan/apply, tfctl eventually outputs [ Outputs written: main@sha1:45646546546544456458zfghghfgghfhfghfgh8g ] 
- But the second part of [tfctl get] output says [ error running Plan: rpc error: code = Internal desc = variable "id" was required but not supplied ]
- The containers then terminate and try to recreate, so the terraform workflow cycle repeats

Please Share Thoughts and Help Debug from this: https://github.com/jmuma1/tf-controller-muma/tree/1-flux-tf-controller-dependency-management-with-git-repository-source