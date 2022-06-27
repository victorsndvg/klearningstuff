#!/bin/bash
show=1
cmd="$HOME/bin/px"
count=`pgrep -cf "$cmd" live`
msgstarted="-e Pixie started"
msgstopped="Pixie stopped"

case $1 in
start)
   $cmd auth login
   $cmd deploy
   $cmd demo deploy px-sock-shop
   if [ $count = 0 ]; then
      nohup $cmd live >/dev/null 2>&1 &
      echo $msgstarted
   else
      echo "Graphana Dashboard already running"
   fi
   ;;

stop)
   show=0
   if [ $count -gt 0 ]; then
      kill -9 $(pgrep -f "$cmd" live)
   fi
   $cmd demo delete px-sock-shop
   $cmd delete
#   # Delete Pixie operator.
#   kubectl delete namespace px-operator
#   # Delete Pixie vizier.
#   kubectl delete namespace pl
#   # Delete Pixie ClusterRole, ClusterRoleBinding objects.
#   kubectl delete clusterroles -l "app=pl-monitoring"
#   kubectl delete clusterrolebindings -l "app=pl-monitoring"
   echo $msgstopped
   ;;
esac

# Show full command line # ps -wfC "$cmd"
if [ $show -gt 0 ]; then
   # Show URL
   echo "Pixie URL: http://localhost:3000"
   echo
fi
