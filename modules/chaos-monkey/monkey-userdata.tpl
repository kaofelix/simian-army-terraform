#!/bin/bash -xe
yum install -y docker
/etc/init.d/docker start
docker run \
    -e SIMIANARMY_CLIENT_AWS_REGION=${aws_region} \
    -e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
    -e SIMIANARMY_CHAOS_ASG_ENABLED=true \
    -e SIMIANARMY_CLIENT_LOCALDB_ENABLED=true \
    -e SIMIANARMY_JANITOR_ENABLED=false \
    -e SIMIANARMY_SCHEDULER_FREQUENCYUNIT=MINUTES \
    -e SIMIANARMY_CHAOS_ASG_PROBABILITY=360.0 \
    -e SIMIANARMY_CHAOS_LEASHED=false \
    mlafeldt/simianarmy

# /simianarmy/chaos/asg/maxterminationsperday
