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

This just brings up an AWS Auto Scaling Group that manages up to 1 instance running [yocto-httpd](https://github.com/felixb/yocto-httpd) in order
for the monkey to have something to attack and so we're able to see it in action.
