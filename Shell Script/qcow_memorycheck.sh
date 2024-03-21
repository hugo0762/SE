for vm in $(virsh list --all --name  ); do
    echo "$vm"  $(virsh dommemstat $vm | grep actual)
    #echo $(virsh dommemstat $vm | grep actual)
    #echodd
done
