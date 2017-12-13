# Simian Army Terraform

This contains a Terraform module to bring up an EC2 instance running [Netflix's Simian Army](https://github.com/Netflix/SimianArmy),
their first implementation of chaos monkey and some sample code.

## simian-army module

The module brings up an EC2 instance running a [Simian Army docker image](https://hub.docker.com/r/mlafeldt/simianarmy/). Most configuration
properties in the image are exposed through terraform module variables with the same default values. You can refer to these properties
[here](https://github.com/mlafeldt/docker-simianarmy/blob/master/docs/configuration-properties.md).
The naming should be adapted by converting / to _ and dropping the redundant simianarmy prefix, whereas a property listed as
"/simianarmy/client/aws/accountkey" become "client_aws_accountkey".

Also keep in mind that properties with boolean values should not use unquoted `true` and `false` keywords in terraform
as those get converted to `"0"` and `"1"` and the image needs the actual words `"true"` and `"false"` as strings.

## Sample ASG

This just brings up an AWS Auto Scaling Group that manages 1 instance running [yocto-httpd](https://github.com/felixb/yocto-httpd) in order
for the monkey to have something to attack and so we're able to see it in action.

## Using it on your own infrastructure

In order to make use of the Simian Army module, you only need to copy the `./modules/simian-army` folder to where you keep your own Terraform modules.
Then on your `main.tf` or whatever other `.tf` file you find appropriate, use the module like this:

```hcl
module "simian_army" {
  name_prefix = "<optional name prefix that will be appended to the instance name>"
  source = "./modules/simian-army" # adapt this if you're using a different folder
  ami_id = "<AMI you would like to use for your simian army instace>"
  sshkeyname = "<SSH key so you can log into your simian army box and have a look inside>"
  subnet_id = "<ID of the subnet for your simian army instance>"
  vpc_id = "<ID of the VPC for your simian army instance>"

  # Configure your chaos monkey with your preferred values.
  chaos_leashed = "false"
  chaos_asg_enabled = "true"
  scheduler_frequency = "1"
  scheduler_frequencyunit = "HOUR"
  chaos_asg_probability = "1.0"
}
```

## Interacting With Your Simian Army Instance

The public ip of the instance is exposed through a terraform output from the module as `public_ip` and then again through the example code as `simian_army_public_ip`.
So when running this example you can run

```
terraform output simian_army_public_ip
```

to get the public ip of the instance. You can use this in your commands so you don't need to worry about the actual ip, for example:

* SSH into the instance
    ```
    ssh -i <path to your key> ec2-user@$(terraform output simian_army_public_ip)
    ```

* Make Rest API calls
    ```
    curl "http://$(terraform output simian_army_public_ip):8080/simianarmy/api/v1/chaos"
    ```
