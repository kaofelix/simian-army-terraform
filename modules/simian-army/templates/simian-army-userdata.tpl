#!/bin/bash -xe
yum install -y docker
/etc/init.d/docker start

REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | awk -F\" '/region/ {print $4}')

docker run \
       -e SIMIANARMY_RECORDER_SDB_DOMAIN=${recorder_sdb_domain} \
       -e SIMIANARMY_CLIENT_LOCALDB_ENABLED=${client_localdb_enabled} \
       -e SIMIANARMY_CLIENT_CLOUDFORMATIONMODE_ENABLED=${client_cloudformationmode_enabled} \
       -e SIMIANARMY_SCHEDULER_FREQUENCY=${scheduler_frequency} \
       -e SIMIANARMY_SCHEDULER_FREQUENCYUNIT=${scheduler_frequencyunit} \
       -e SIMIANARMY_SCHEDULER_THREADS=${scheduler_threads} \
       -e SIMIANARMY_CALENDAR_OPENHOUR=${calendar_openhour} \
       -e SIMIANARMY_CALENDAR_CLOSEHOUR=${calendar_closehour} \
       -e SIMIANARMY_CALENDAR_TIMEZONE=${calendar_timezone} \
       -e SIMIANARMY_CALENDAR_ISMONKEYTIME=${calendar_ismonkeytime} \
       -e SIMIANARMY_CHAOS_LEASHED=${chaos_leashed} \
       -e SIMIANARMY_CHAOS_BURNMONEY=${chaos_burnmoney} \
       -e SIMIANARMY_CHAOS_TERMINATEONDEMAND_ENABLED=${chaos_terminateondemand_enabled} \
       -e SIMIANARMY_CHAOS_MANDATORYTERMINATION_ENABLED=${chaos_mandatorytermination_enabled} \
       -e SIMIANARMY_CHAOS_MANDATORYTERMINATION_WINDOWINDAYS=${chaos_mandatorytermination_windowindays} \
       -e SIMIANARMY_CHAOS_MANDATORYTERMINATION_DEFAULTPROBABILITY=${chaos_mandatorytermination_defaultprobability} \
       -e SIMIANARMY_CHAOS_ASG_ENABLED=${chaos_asg_enabled} \
       -e SIMIANARMY_CHAOS_ASG_PROBABILITY=${chaos_asg_probability} \
       -e SIMIANARMY_CHAOS_ASG_MAXTERMINATIONSPERDAY=${chaos_asg_maxterminationsperday} \
       -e SIMIANARMY_CHAOS_ASGTAG_KEY=${chaos_asgtag_key} \
       -e SIMIANARMY_CHAOS_ASGTAG_VALUE=${chaos_asgtag_value} \
       -e SIMIANARMY_CHAOS_SHUTDOWNINSTANCE_ENABLED=${chaos_shutdowninstance_enabled} \
       -e SIMIANARMY_CHAOS_BLOCKALLNETWORKTRAFFIC_ENABLED=${chaos_blockallnetworktraffic_enabled} \
       -e SIMIANARMY_CHAOS_DETACHVOLUMES_ENABLED=${chaos_detachvolumes_enabled} \
       -e SIMIANARMY_CHAOS_BURNCPU_ENABLED=${chaos_burncpu_enabled} \
       -e SIMIANARMY_CHAOS_BURNIO_ENABLED=${chaos_burnio_enabled} \
       -e SIMIANARMY_CHAOS_KILLPROCESSES_ENABLED=${chaos_killprocesses_enabled} \
       -e SIMIANARMY_CHAOS_NULLROUTE_ENABLED=${chaos_nullroute_enabled} \
       -e SIMIANARMY_CHAOS_FAILEC2_ENABLED=${chaos_failec2_enabled} \
       -e SIMIANARMY_CHAOS_FAILDNS_ENABLED=${chaos_faildns_enabled} \
       -e SIMIANARMY_CHAOS_FAILDYNAMODB_ENABLED=${chaos_faildynamodb_enabled} \
       -e SIMIANARMY_CHAOS_FAILS3_ENABLED=${chaos_fails3_enabled} \
       -e SIMIANARMY_CHAOS_FILLDISK_ENABLED=${chaos_filldisk_enabled} \
       -e SIMIANARMY_CHAOS_NETWORKCORRUPTION_ENABLED=${chaos_networkcorruption_enabled} \
       -e SIMIANARMY_CHAOS_NETWORKLATENCY_ENABLED=${chaos_networklatency_enabled} \
       -e SIMIANARMY_CHAOS_NETWORKLOSS_ENABLED=${chaos_networkloss_enabled} \
       -e SIMIANARMY_CHAOS_NOTIFICATION_GLOBAL_ENABLED=${chaos_notification_global_enabled} \
       mlafeldt/simianarmy
