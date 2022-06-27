#!/bin/bash
show=1
DEMO=pi
# DEMO=tensorflow-benchmarks
msgstarted="-e MPI-Operator started"
msgstopped="MPI-Operator stopped"
dir="./mpi-operator"

case $1 in
start)

   if [ ! -d "$dir" ]
   then
      git clone https://github.com/kubeflow/mpi-operator $dir
   fi

   kubectl apply -f $dir/deploy/v2beta1/mpi-operator.yaml
   #kubectl apply -f $dir/manifests/overlays/kubeflow
   #kubectl kustomize base | kubectl apply -f -
   echo $msgstarted
   ;;

launch-demo)
   # Deploy MPI Job
   # kubectl apply -f $dir/examples/v2beta1/$DEMO.yaml
   DEMO=pi
   kubectl create -f $dir/examples/v2beta1/$DEMO/$DEMO.yaml
   ;;
delete-demo)
   # Delete MPI Job
   kubectl delete -f $dir/examples/v2beta1/$DEMO/$DEMO.yaml
   ;;
log)
   if [ -z "$2" ]
   then
      jobname="pi-launcher"
   else
      jobname=$2
   fi

   PODNAME=$(kubectl get pods -l job-name=$jobname -o name)
   kubectl logs -f ${PODNAME}
   ;;

stop)
   kubectl delete --ignore-not-found=true -f $dir/deploy/v2beta1/mpi-operator.yaml
   echo $msgstopped
   ;;
esac

# Show full command line # ps -wfC "$cmd"
if [ $show -gt 0 ]; then
   # Show URL
   kubectl get crd | grep mpi
   echo
fi
