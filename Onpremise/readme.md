

MSA 시작<br>
/usr/bin/sh /home/sysadmin/onpremise/onpremise_config/plura_auto_startup.sh > plura_auto_startup.log 2>&1
<br>
MSA 종료<br>
/usr/bin/sh /home/sysadmin/onpremise/onpremise_config/plura_auto_shutdown.sh > plura_auto_stutdown.log 2>&1
<br>
kvm 종료<br>
ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "sudo shutdown now"
<br>
<br>
시간 확인 sysamdin 계정<br>
ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "date"<br>

시간 동기화<br>
/usr/bin/sh /home/sysadmin/ansible/cronjob/a_ntpdate.sh<br>
/usr/bin/sh /home/sysadmin/ansible/cronjob/a_chrony.sh<br>

<br>
ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "sudo systemctl restart chronyd"
<br>
================================================<br>
가상머신 파일 개수 확인
<br>
ls /etc/libvirt/qemu/*.xml | wc -l
<br>
ls /var/lib/libvirt/images/*.qcow2 | wc -l
<br><br>

================================================<br>
가상머신 복제<br>
virt-clone --original 011052-solr --name 011054-solr --file /var/lib/libvirt/images/011054-solr.qcow2
<br>
가상머신 시작 cmd<br>
virsh start 011052-solr
<br>
가상머신 다운 cmd<br>
virsh shutdown 011052-solr
<br>
가상머신 삭제 cmd<br>
virsh undefine 011052-solr
<br>
※ qcow2 파일은 삭제가 안되므로 수동 삭제
<br>
가상머신 용량 증설<br>
qemu-img resize /var/lib/libvirt/images/011021-solr.qcow2 +600G
<br>
mount
<br>
fdisk -l<br>
mknod /dev/vda4 b 8 4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인<br>
chown root:disk /dev/vda4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인<br>
fdisk /dev/vda<br>
p<br>
n<br>
p<br>
4<br>
enter<br>
enter<br>
t<br>
4<br>
8e<br>
p<br>
w<br>
reboot<br>
fdisk /dev/vda<br>
p<br>
q<br>
pvcreate /dev/vda4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인<br>
vgs<br>
vgextend rl /dev/vda4 -> ※경로가 바낄수 있음. fisk -l 먼저 확인<br>
pvscan<br>
vgdisplay rl<br>
lvresize -r -l+100%FREE /dev/rl/root <br>
df -h<br>
reboot<br>

<br><br><br>
================================================<br>
solr shard 추가<br>
http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard3&collection=weblogDetect&createNodeSet=10.10.11.41:8983_solr
<br>
solr 추가 동기화<br>
https://flow.team/l/PwNet
<br>
netlog<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/netlog-solr/zk-net1/collections/netlog/shards/active 
<br>
syslog<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/syslog-solr/zk-sys1/collections/syslog/shards/active 
<br>
weblog<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/weblog-solr/zk-web1/collections/weblog/shards/active
<br>
applog<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/applog-solr/zk-app1/collections/applog/shards/active
<br>
resourcelogDetect<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/resourcelogDetect-solr/zk-resdetect1/collections/resourcelogDetect/shards/active
<br>
tracelog<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/tracelog-solr/zk-trace1/collections/tracelog/shards/active
<br>
<br>
syslog-solr(스토리지명)-albert 스토리지관리 확인 가능<br>
zk-sys1(주키퍼명)-albert 솔라시스템관리-주키퍼관리 확인 가능<br>
syslog(컬렉션명)-albert 솔라시스템관리-컬렉션관리 확인 가능<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/syslogDetect-solr/zk-sysdetect1/collections/syslogDetect/shards/active 
<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/weblogDetect-solr/zk-webdetect1/collections/weblogDetect/shards/active
<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/netlogDetect-solr/zk-netdetect1/collections/netlogDetect/shards/active
<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul/applogDetect-solr/zk-appdetect1/collections/applogDetect/shards/active
<br>
curl -x "" -v http://iapis.qubitsec.internal/infra/solr/zookeepers/kr-seoul//zk-trace1/collections/applogDetect/shards/active
<br>
================================================<br>
https://flow.team/l/PNrX2
<br>
DELETE FROM SolrShard WHERE isUse=0;
<br>
SELECT solrShard, solrNode FROM SolrNode WHERE solrShard = (SELECT solrShard FROM SolrShard WHERE isUse=0);
					   
					   


SELECT n.solrShard, n.solrNode FROM SolrNode n LEFT JOIN SolrShard s ON n.solrShard = s.solrShard WHERE s.isUse=0;

DELETE n FROM SolrNode n LEFT JOIN SolrShard s ON n.solrShard = s.solrShard WHERE s.isUse=0;

================================================<br><br>
포트미러링 설정<br>
KVM 서버 해당 인터페이스 promisc 설정<br>
ifconfig brm0 promisc<br>


nic 가상머신 포트 미러링<br>
tc qdisc add dev brm0 ingress
<br>
nic 가상머신 포트 미러링 확인<br>
tc qdisc show dev brm0
<br>
가상머신 nic 인터페이스 미러링 설정<br>
tc filter add dev brm0 parent ffff: protocol ip u32 match u8 0 0 action mirred egress mirror dev vnet1
<br>

tc filter add dev brm0 parent ffff: protocol ip u32 match u8 0 0 action mirred egress mirror dev vnet1 pipe \
action mirred egress mirror dev vnet1
<br>
설정 제거<br>
tc qdisc del dev brm0 ingress
<br>

내부 테스트 <br>
tcpdump -i brm0 -n -X "dst 172.16.10.99 and tcp port 80"  | grep hello
<br>
tcpdump -i enp7s0 -n -X "dst 172.16.10.99 and tcp port 80"  | grep hello
<br>
tcpdump -i brm0 -n -X "tcp port 80"  | grep hello
<br>
tcpdump -i enp7s0 -n -X "tcp port 80"  | grep hello
<br>
http://172.16.10.99/hello
<br>
<br>
================================================<br>
ping 테스트 통신 안되는 경우<br>
기본 route 설정 확인<br>
<br>
route 
<br>
기본 route 설정<br>
route add default gw [gw addr] dev [NIC]
<br>
route add default gw 172.16.0.1 dev br172
<br><br>
기본 route 설정 해제<br>
route del default gw [gw addr] dev [NIC]
<br>
route del default gw 172.16.0.1 dev br172

