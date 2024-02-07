eSlim / inspur 서버 바이오스 HDD RAID 설정
※ 서버에 HDD 장착 후 정상 녹색 점등 확인

1. 서버 On 후, ‘Del’ 키 입력으로 바이오스 진입<br><br>
![e1](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e1.png)

2. 바이오스 진입 후 ‘Advanced’ 탭으로 이동<br><br>
![e2](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e2.png) 

3. ‘Advanced’ 탭 제일 하단, ‘AVAGO Configuration Utility’ 진입<br><br>
![e3](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e3.png) 

4. ‘Main Menu’ 진입<br><br>
![e4](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e4.png)

5. ‘Configuration Management’ 진입<br><br>
![e5](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e5.png)

6. ‘Clear Configuration’ 을 통해 설정 값을 초기화<br><br>
![e6](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e6.png)

7. Confirm 설정을 ‘Enabled’ 로 설정<br><br>
![e7](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e7.png)

8. ‘Yes’ 설정<br><br>
![e8](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e8.png)

9. 정상 동작했다는 내용 확인 후 ‘OK’ 확인<br><br>
![e9](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e9.png)

10. 6번의 앞 경로로 진입하여 ‘Create Virtual Drive’ 진입<br><br>
![e10](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e10.png)

11. ‘Select RAID Level’ 을 통해 RAID 5 설정<br><br>
![e11](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e11.png) 

12. ‘Select Drives’를 진입하여 구성될 HDD Enabled 설정 
모든 HDD 에 대해 구성할 경우 하단의 Check All 를 통해 한번에 Enabled 후 Apply Changes<br><br>
![e12](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e12.png) 

13. 정상 동작했다는 내용 확인 후 ‘OK’ 확인<br><br>
![e13](https://github.com/hugo0762/SE/blob/main/Server_RAID/images/e13.png) 
※ RAID 지정 후에는 모든 HDD 가 동일하게 점등되는 부분 확인 가능

14. 설치 완료.


