시흥시청 업데이트 2차 준비 자료

0. 랜케이블 변경 -> 서비스가 안될텐데, 할지는..

1. solr net 추가 -> 기존 데이터를 유지하고 진행한다면, 증축 solr 는 기존 데이터가 없는데 괜찮은지 확인 필요


[ansible hosts 파일 solr 추가 ip 등록]
기존 10.10.11.50 설정된 부분 찾아 아래 추가 필요

[solr 머신 복제]54~59 추가 되어 있음->확인 필요

virt-clone --original 011052-solr --name 011080-solr --file /var/lib/libvirt/images/011080-solr.qcow2

virt-clone --original 011052-solr --name 011081-solr --file /var/lib/libvirt/images/011081-solr.qcow2

virt-clone --original 011052-solr --name 011082-solr --file /var/lib/libvirt/images/011082-solr.qcow2

virt-clone --original 011052-solr --name 011083-solr --file /var/lib/libvirt/images/011083-solr.qcow2

virt-clone --original 011052-solr --name 011084-solr --file /var/lib/libvirt/images/011084-solr.qcow2

virt-clone --original 011052-solr --name 011085-solr --file /var/lib/libvirt/images/011085-solr.qcow2

virt-clone --original 011052-solr --name 011086-solr --file /var/lib/libvirt/images/011086-solr.qcow2

virt-clone --original 011052-solr --name 011087-solr --file /var/lib/libvirt/images/011087-solr.qcow2

virt-clone --original 011052-solr --name 011088-solr --file /var/lib/libvirt/images/011088-solr.qcow2

virt-clone --original 011052-solr --name 011089-solr --file /var/lib/libvirt/images/011089-solr.qcow2

[solr 80, 82, 84, 86, 88 번 10.10.10.10 서버로 이동]

scp /var/lib/libvirt/images/011080-solr.qcow2 011082-solr.qcow2 011084-solr.qcow2 011086-solr.qcow2 011088-solr.qcow2 root@10.10.10.10:/var/lib/libvirt/images/

scp /etc/libvirt/qemu/011080-solr.xml 011082-solr.xml 011084-solr.xml 011086-solr.xml 011088-solr.xml root@10.10.10.10:/etc/libvirt/qemu/

[solr 81, 83, 85, 87, 89 번 10.10.10.11 서버로 이동]

scp /var/lib/libvirt/images/011081-solr.qcow2 011083-solr.qcow2 011085-solr.qcow2 011087-solr.qcow2 011089-solr.qcow2 root@10.10.10.11:/var/lib/libvirt/images/

scp /etc/libvirt/qemu/011081-solr.xml 011083-solr.xml 011085-solr.xml 011087-solr.xml 011089-solr.xml root@10.10.10.11:/etc/libvirt/qemu/

[solr 80~89 ip, hostname 변경]
nmtui

[solr app 기동]

~/solr/bin/solr restart -cloud

[solr 추가 및 shard 설정]

먼저 웹페이지에서 기존 shard 구성 내용 확인 필요.

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard3&collection=netlog&createNodeSet=10.10.11.54:8983_solr

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard4&collection=netlog&createNodeSet=10.10.11.56:8983_solr

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard5&collection=netlog&createNodeSet=10.10.11.58:8983_solr

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard6&collection=netlog&createNodeSet=10.10.11.80:8983_solr

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard7&collection=netlog&createNodeSet=10.10.11.82:8983_solr

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard8&collection=netlog&createNodeSet=10.10.11.84:8983_solr

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard9&collection=netlog&createNodeSet=10.10.11.86:8983_solr

http://10.10.11.50:8983/solr/admin/collections?action=CREATESHARD&shard=shard10&collection=netlog&createNodeSet=10.10.11.88:8983_solr

[solr master 서버 웹 페이지에서 slave 추가]

Collections -> netlog

81, 83, 85, 87, 89


===========================================================================

서비스 종료

/usr/bin/sh /home/sysadmin/onpremise/onpremise_config/plura_auto_shutdown.sh

시간 확인

ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "date"

/usr/bin/sh /home/sysadmin/ansible/cronjob/a_ntpdate.sh

/usr/bin/sh /home/sysadmin/ansible/cronjob/a_chrony.sh

KVM 서버 종료

ansible -i /home/sysadmin/ansible/hosts all-hosts -m shell -a "sudo shutdown now"

서비스 기동

/usr/bin/sh /home/sysadmin/onpremise/onpremise_config/plura_auto_startup.sh
