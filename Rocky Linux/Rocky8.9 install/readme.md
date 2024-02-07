※선 작업
eSlim&inspur 혹은 Huawei 서버에 따른 RAID 설정 후 진행
<br><br>
1. 서버 부팅 후, 각 서버 종류에 맞게 boot 진행<br><br>
- eSlim&inspur : F11 <br><br>
![r1](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r1.png)

- Huawei : Ctrl+S or 부트매니저 설정 F11(remote keyboard F3) <br><br>
![r2](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r2.png)
<br><br>
Ctrl+S : USB를 인식 못하는 현상 발생
부트매니저 F11 : 사전 바이오스 비밀번호 확인 필요
=> 위 방법으로 진행하기 어려운 경우 자동 인식 되도록 대기


2. 리눅스 이미지 USB 로 선택<br><br>
![r3](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r3.png)

3. ‘Test this media & install Rocky Linux 8.9’ 클릭<br><br>
![r4](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r4.png)

4. 테스트 진행에 따른 이상 여부 확인 및 인스톨러 시작 메세지 확인<br><br>
![r5](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r5.png)
<br><br>
![r6](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r6.png)

5. 언어 선택 - 한국어 -> ‘계속 진행’ 클릭(※ 데모)<br><br>
![r7](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r7.png)

6. 설치 목적지 클릭<br><br>
![r8](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r8.png)

7. RAID 된 HDD 로 설정 후 완료<br><br>
![r9](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r9.png)


8. root 비밀번호 클릭<br><br>
![r10](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r10.png)

9. 사용할 root 계정 비밀번호 설정<br><br>
![r11](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r11.png)

10. 오른쪽 하단 설치 시작<br><br>
![r12](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r12.png)

11. 설치 진행<br><br>
![r13](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r13.png)

12. 설치 완료 후 오른쪽 하단 ‘시스템 재시작’<br><br>
![r14](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r14.png)

13. 재부팅 이후, 라이센스 정보 클릭<br><br>
![r15](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r15.png)

14. 라이센스 내용 확인 후 동의 후 완료<br><br>
![r16](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r16.png)

15. 환영 메세지 다음 클릭<br><br>
![r17](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r17.png)

15. 위치 정보 서비스는 서비스에 따라 ON/OFF 택일 후 다음<br><br>
![r18](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r18.png)

16. 전체 이름 / 사용자 이름 지정 후 다음<br><br>
![r19](https://github.com/hugo0762/SE/blob/main/Rocky%20Linux/Rocky8.9%20install/images/r19.png)

