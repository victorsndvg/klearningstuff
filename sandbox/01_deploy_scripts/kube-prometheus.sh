#!/bin/bash
show=1
cmd="kubectl --namespace monitoring port-forward svc/grafana 3000"
count=`pgrep -cf "$cmd"`
msgstarted="-e Graphana Dashboard started"
msgstopped="Graphana Dashboard stopped"
dir="./kube-prometheus"

case $1 in
start)

   if [ ! -d "$dir" ]
   then
      git clone https://github.com/prometheus-operator/kube-prometheus.git $dir
   fi

   kubectl apply --server-side -f $dir/manifests/setup
   until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
   kubectl apply -f $dir/manifests/
   if [ $count = 0 ]; then
      nohup $cmd >/dev/null 2>&1 &
      echo $msgstarted
   else
      echo "Graphana Dashboard already running"
   fi
   ;;

stop)
   show=0
   if [ $count -gt 0 ]; then
      kill -9 $(pgrep -f "$cmd")
   fi
   kubectl delete --ignore-not-found=true -f $dir/manifests/ -f $dir/manifests/setup
   echo $msgstopped
   ;;
esac

# Show full command line # ps -wfC "$cmd"
if [ $show -gt 0 ]; then
   # Show URL
   echo "Graphana URL: http://localhost:3000"
   echo
fi
