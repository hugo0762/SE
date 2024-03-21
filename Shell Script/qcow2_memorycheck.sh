# kvm 서버에 등록된 vm 별 할당 메모리 확인
for vm in $(virsh list --all --name  ); do
    echo "$vm"  $(virsh dommemstat $vm | grep actual)
    #echo $(virsh dommemstat $vm | grep actual)
    #echodd
done



./qcow2_memorycheck.sh > res.txt

cat res.txt | awk '{pring $1}'
cat res.txt | awk '{pring $1}'
