for vm in $(virsh list --all --name ); do
    echo "$vm"  $(virsh dommemstat $vm | grep available)
    #echo $(virsh dommemstat $vm | grep actual)
    #echodd
done
