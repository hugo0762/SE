

MSA 시작
/usr/bin/sh /home/sysadmin/onpremise/onpremise_config/plura_auto_startup.sh > plura_auto_startup.log 2>&1
MSA 종료
/usr/bin/sh /home/sysadmin/onpremise/onpremise_config/plura_auto_shutdown.sh > plura_auto_stutdown.log 2>&1
kvm 종료
ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "sudo shutdown now"

시간 확인 sysamdin 계정
ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "date"
시간 동기화
/usr/bin/sh /home/sysadmin/ansible/cronjob/a_ntpdate.sh
/usr/bin/sh /home/sysadmin/ansible/cronjob/a_chrony.sh


ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "sudo systemctl restart chronyd"
================================================
가상머신 파일 개수 확인
ls /etc/libvirt/qemu/*.xml | wc -l
ls /var/lib/libvirt/images/*.qcow2 | wc -l


================================================
가상머신 복제
virt-clone --original 011052-solr --name 011054-solr --file /var/lib/libvirt/images/011054-solr.qcow2

가상머신 시작 cmd
virsh start 011052-solr

가상머신 다운 cmd
virsh shutdown 011052-solr

가상머신 삭제 cmd
virsh undefine 011052-solr
※ qcow2 파일은 삭제가 안되므로 수동 삭제

가상머신 용량 증설
qemu-img resize /var/lib/libvirt/images/011021-solr.qcow2 +600G
mount
fdisk -l
mknod /dev/vda4 b 8 4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인
chown root:disk /dev/vda4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인
fdisk /dev/vda
p
n
p
4
enter
enter
t
4
8e
p
w
reboot
fdisk /dev/vda
p
q
pvcreate /dev/vda4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인
vgs
vgextend rl /dev/vda4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인
pvscan
vgdisplay rl
lvresize -r -l+100%FREE /dev/rl/root 
df -h
reboot


================================================
solr shard 추가
http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard3&collection=weblogDetect&createNodeSet=10.10.11.41:8983_solr

solr 추가 동기화
https://flow.team/l/PwNet

netlog
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/netlog-solr/zk-net1/collections/netlog/shards/active 
syslog
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/syslog-solr/zk-sys1/collections/syslog/shards/active 
weblog
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/weblog-solr/zk-web1/collections/weblog/shards/active
applog
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/applog-solr/zk-app1/collections/applog/shards/active

resourcelogDetect
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/resourcelogDetect-solr/zk-resdetect1/collections/resourcelogDetect/shards/active
tracelog
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/tracelog-solr/zk-trace1/collections/tracelog/shards/active


syslog-solr(스토리지명)-albert 스토리지관리 확인 가능
zk-sys1(주키퍼명)-albert 솔라시스템관리-주키퍼관리 확인 가능
syslog(컬렉션명)-albert 솔라시스템관리-컬렉션관리 확인 가능
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/syslogDetect-solr/zk-sysdetect1/collections/syslogDetect/shards/active 
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/weblogDetect-solr/zk-webdetect1/collections/weblogDetect/shards/active
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/netlogDetect-solr/zk-netdetect1/collections/netlogDetect/shards/active
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/applogDetect-solr/zk-appdetect1/collections/applogDetect/shards/active

curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul//zk-trace1/collections/applogDetect/shards/active

================================================
https://flow.team/l/PNrX2

DELETE FROM SolrShard WHERE isUse=0;

SELECT solrShard, solrNode FROM SolrNode WHERE solrShard = (SELECT solrShard FROM SolrShard WHERE isUse=0);
					   
					   


SELECT n.solrShard, n.solrNode FROM SolrNode n LEFT JOIN SolrShard s ON n.solrShard = s.solrShard WHERE s.isUse=0;

DELETE n FROM SolrNode n LEFT JOIN SolrShard s ON n.solrShard = s.solrShard WHERE s.isUse=0;

================================================
포트미러링 설정
KVM 서버 해당 인터페이스 promisc 설정
ifconfig brm0 promisc


nic 가상머신 포트 미러링
tc qdisc add dev brm0 ingress
nic 가상머신 포트 미러링 확인
tc qdisc show dev brm0
가상머신 nic 인터페이스 미러링 설정
tc filter add dev brm0 parent ffff: protocol ip u32 match u8 0 0 action mirred egress mirror dev vnet1

tc filter add dev brm0 parent ffff: protocol ip u32 match u8 0 0 action mirred egress mirror dev vnet1 pipe \
action mirred egress mirror dev vnet1

설정 제거
tc qdisc del dev brm0 ingress


내부 테스트 
tcpdump -i brm0 -n -X "tcp port 80"  | grep hello
tcpdump -i enp7s0 -n -X "tcp port 80"  | grep hello

http://172.16.10.99/hello
