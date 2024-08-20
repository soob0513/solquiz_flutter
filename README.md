# LSTM 모델 기반 태양광 발전량 예측 솔루션 (팀명 : 스물여섯,스물일곱) 
<br/>
 <img width="350" alt="NPSS_logo3" src="https://github.com/user-attachments/assets/8b42d8ca-b67c-4335-9205-ed21efcf037a"/>
<br/>
<br/>
 

## 💡 프로젝트 소개
#### · LSTM 모델을 활용해서 미세먼지 농도 시계열 데이터와 발전량 데이터를 분석, 예측하는 모델 제작<br/>
#### · 기상인자와 대기 상태 물질(6종)을 기반으로 미세먼지 농도를 예측하여 상관관계를 분석하고 발전소 환경에 따른 발전량의 인과관계를 도출<br/>
#### · Flutter를 사용한 태양광 발전량 예측 App 제작<br/>
#### · 현재 발전량 및 예측 발전량, 전기 시장의 REC, SMP와 더불어 기상정보를 App으로 확인 가능<br/>
#### · Ubuntu 22.04(Linux) 안에 HTML, CSS, JS, PHP를 사용하여 관리페이지 제작<br/>
#### · IoT 센서로 데이터를 수집하고, 모델에 데이터를 적용하여 정확도 향상<br/>
<br/>

## 💡 프로젝트 기간
#### 2024.07.11 ~ 2024.08.22 (7주)
<br/>

## 💡 프로젝트 개발 내용
#### · 버전관리 및 협업툴
&nbsp;&nbsp;&nbsp;&nbsp; - Git을 활용해 소스 코드 백업, 협업 등 효율적인 시간 분배<br/>
&nbsp;&nbsp;&nbsp;&nbsp; - 로컬과 서버 사이 Git을 두고 버전관리<br/>
&nbsp;&nbsp;&nbsp;&nbsp; - FileZilla를 통한 파일 공유<br/>

#### · 프론트엔드
&nbsp;&nbsp;&nbsp;&nbsp; - Figma를 활용한 UI/UX 설계<br/>
&nbsp;&nbsp;&nbsp;&nbsp; - 사용자를 고려하여 깔끔하고 직관적인 App 화면 구성<br/>
&nbsp;&nbsp;&nbsp;&nbsp; - DB에 저장된 정보를 Flutter를 통하여 UI 제공<br/>
&nbsp;&nbsp;&nbsp;&nbsp; - 사용자들에게 공지 사항이나 업데이트 내용을 전달 할 수 있는 관리자용 웹페이지 (PHP, HTML) 제작<br/>

#### · 백엔드
&nbsp;&nbsp;&nbsp;&nbsp; - Oracle을 통한 데이터베이스 설계<br/>
&nbsp;&nbsp;&nbsp;&nbsp; - 도메인을 통해 설정된 IP주소의 관리페이지 접근<br/>
&nbsp;&nbsp;&nbsp;&nbsp; - Node.js와 Oracle를 연동하여 사용자에게 DB에 저장된 태양광 관련 정보 조회<br/>

#### · 딥러닝
&nbsp;&nbsp;&nbsp;&nbsp; - 태양광 발전 예측 모델을 통한 내일의 발전량 예측 기능<br/>

#### · IoT
&nbsp;&nbsp;&nbsp;&nbsp; - Arduino 센서를 통하여 대기 상태 물질(6종)을 수집하고 상관관계를 분석<br/>
<br/>

## 💡 프로젝트 주요 기술
#### · 버전관리 및 협업툴 (git, github, Figma)<br/>
#### · App 제작 (Android Studio)<br/>
#### · Web 제작 (HTML, CSS, JS, PHP)<br/>
#### · 센서 데이터 수집 (Arduino)<br/>
#### · DB 연결 및 서버구축(Oracle, Linux, Apache, Node.js)<br/>
#### · 딥러닝 알고리즘 (Python keras)<br/>
<br/>

## 💡 기술스택
<table>
    <tr>
        <th width="125">구분</th>
        <th>내용</th>
    </tr>
    <tr>
        <td>데이터베이스</td>
        <td>
            <img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=Oracle&logoColor=white"/>
        </td>
    </tr>
    <tr>
        <td>APP</td>
        <td>
            <img src="https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white"/>
            <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white"/>
        </td>
    </tr>
    <tr>
        <td>Web</td>
        <td>
            <img src="https://img.shields.io/badge/HTML-E34F26?style=for-the-badge&logo=html5&logoColor=white">
            <img src="https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=css3&logoColor=white">
            <img src="https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E">
            <img src="https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white"/>
        </td>
    </tr>
    <tr>
        <td>하드웨어</td>
        <td>
            <img src="https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white"/>
        </td>
    </tr>
    <tr>
        <td>서버환경</td>
        <td>
             <img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=Node.js&logoColor=white"/>
             <img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white"/> 
             <img src="https://img.shields.io/badge/apache-%23D42029.svg?style=for-the-badge&logo=apache&logoColor=white"/> 
        </td>
    </tr>
  <tr>
        <td>모델링</td>
        <td>
         <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=Python&logoColor=white"/>
         <img src="https://img.shields.io/badge/PyTorch-%23EE4C2C.svg?style=for-the-badge&logo=PyTorch&logoColor=white" >
         <img src="https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white">
         <img src="https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white">
         <img src="https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black">
         <img src="https://img.shields.io/badge/TensorFlow-%23FF6F00.svg?style=for-the-badge&logo=TensorFlow&logoColor=white">
        </td>
   </tr>
   <tr>
        <td>개발도구</td>
        <td>
            <img src="https://img.shields.io/badge/android%20studio-346ac1?style=for-the-badge&logo=android%20studio&logoColor=white"/>
            <img src="https://img.shields.io/badge/Arduino-00979D?style=for-the-badge&logo=Arduino&logoColor=white"/>
            <img src="https://img.shields.io/badge/VSCode-007ACC?style=for-the-badge&logo=VisualStudioCode&logoColor=white"/>
            <img src="https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=Jupyter&logoColor=white"/>
        </td>
    </tr>
    <tr>
        <td>협업도구</td>
        <td>
            <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=Git&logoColor=white"/>
            <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white"/>
            <img src="https://img.shields.io/badge/Notion-%23000000.svg?style=for-the-badge&logo=notion&logoColor=white"/>
            <img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=Figma&logoColor=white"/>
            <img src="https://img.shields.io/badge/Canva-%2300C4CC.svg?style=for-the-badge&logo=Canva&logoColor=white"/>
            <img src="https://img.shields.io/badge/kakaotalk-ffcd00.svg?style=for-the-badge&logo=kakaotalk&logoColor=000000"/>
        </td>
    </tr>
</table>
<br/>


## 💡 시스템 아키텍처
<img width="630" alt="시스템아키텍처2" src="https://github.com/user-attachments/assets/d271ff70-8371-4ab1-903d-19fb21492bdb">
<br/>

## 💡 유스케이스
![유스케이스](https://github.com/user-attachments/assets/db7289bd-a8a0-48dd-909c-b60b5d3b2aed)
<br/>

## 💡 ER 다이어그램
![erd](https://github.com/user-attachments/assets/d3196960-95ed-47de-9c45-4b0258bf7177)
<br/>

## 💡 화면구성
#### [APP]
##### 1. 로그인/회원가입 화면<br/>
<img width="200px" src="https://github.com/user-attachments/assets/c65e7d78-c063-4789-9a65-af5f2f9b54dc">
<img width="200px" src="https://github.com/user-attachments/assets/85b8a39a-e19a-42b1-a1e4-1fcbc4fb0499">
<br/>

##### 2. 마이페이지 / 정보 수정 화면<br/>
<img width="200px" src="https://github.com/user-attachments/assets/083fa70e-f705-4153-b506-37df1da1f508">
<img width="200px" src="https://github.com/user-attachments/assets/29df1b70-4e7d-49b9-aafd-c0b376f7e092">
<br/>

##### 3. 발전소 등록 화면<br/>
<img width="200px" src="https://github.com/user-attachments/assets/c9b9471c-9f72-4b52-8fda-a084843cfd88">
<img width="200px" src="https://github.com/user-attachments/assets/0878ae98-835e-4c6e-aee0-3facfe374680">
<br/>

##### 4. 공지사항 / 메인페이지 / 발전소 수익 화면<br/>
<img width="200px" src="https://github.com/user-attachments/assets/ead2eeb4-11cc-413a-b202-7276058f23ce">
<img width="200px" src="https://github.com/user-attachments/assets/8585c951-49b2-484b-b42a-d2aa16adce1b">
<img width="200px" src="https://github.com/user-attachments/assets/c25f7ae5-4769-4223-850a-6406c4744881">
<br/>

##### 5. 발전량 예측 화면<br/>
<img width="200px" src="https://github.com/user-attachments/assets/719c41e0-1cb2-4243-9fee-5869000356fb">
<img width="200px" src="https://github.com/user-attachments/assets/0dc23c7e-c722-4332-9966-2bacb7825cfa">
<br/>

##### 6. 모집 게시판 화면<br/>
<img width="200px" src="https://github.com/user-attachments/assets/08537a6f-5bc8-4fe5-b156-d86674bcc65d">
<img width="200px" src="https://github.com/user-attachments/assets/420914d2-0cff-4e41-8c5c-5453b6573b0c">
<br/>
<img width="200px" src="https://github.com/user-attachments/assets/bb5a6987-b193-437a-9f76-4c9c3bf764e5">
<img width="200px" src="https://github.com/user-attachments/assets/f344eda6-0690-4abd-bb19-0f4f5c50c91f">
<br/>

#### [WEB (관리자 페이지)]
##### 1. 공지사항 등록 페이지<br/>
<img src="https://github.com/user-attachments/assets/7f6553ee-9cde-4bb2-9164-b47800f130e8"><br/>
##### 2. 회원 관리 페이지<br/>
<img src="https://github.com/user-attachments/assets/c6cb7334-b9b1-4dc9-aa49-3605ba875da5"><br/>
##### 3. 모집 게시판 관리 페이지<br/>
<img src="https://github.com/user-attachments/assets/8bf18fec-0964-4114-a3e7-8e0b67815314"><br/>
<br/>

## 💡 팀원역할
<table>
  <tr>
    <td align="center"><strong>김희원</strong></td>
    <td align="center"><strong>홍지연</strong></td>
    <td align="center"><strong>최수빈</strong></td>
    <td align="center"><strong>김준</strong></td>
    <td align="center"><strong>박태하</strong></td>
  </tr>
 <tr>
    <td align="center">팀장, PM, Back-End</td>
    <td align="center">Front-End, 하드웨어</td>
    <td align="center">Front-End, Back-End</td>
    <td align="center">Back-End, 하드웨어</td>
    <td align="center">Front-End</td>
  </tr>
 <tr>
    <td>· 리스크관리(기술적 문제, 팀워크 문제)<br/>· 프로젝트 일정/개인별 진행사항 파악, 회의 진행 및 회의록 작성<br/>· 모델 제작, 모델 학습<br/>· DB 설계 및 구축<br/>· APP-Server-DB 연동<br/>· WEB(관리자용) 제작  
          <br/>· APP 카카오 로그인 구현</td>
    <td>· APP 로고 디자인<br/>· APP - 로그인/회원가입/발전소등록 페이지<br/>· 프로토타입(시제품) 제작<br/>· PPT 제작<br/>· 시연 영상 제작</td>
    <td>· APP 디자인<br/>· APP - 공지사항/발전량 예측/메인/모집게시판/마이페이지 제작<br/>· APP-Server-DB 연동</td>
    <td>· DB 통신<br/>· IoT 하드웨어<br/>· 프로토타입(시제품) 제작<br/>· DB 연계<br/>· PHP-ESP wifi 통신<br/>· PHP-DB 통신</td>
    <td>· WEB(관리자용) 로그인 페이지 제작</td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/Heewoooon" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/ongji" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/soob0513" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/kinick1" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/SAMTAEGUEK" target='_blank'>github</a></td>
  </tr>
</table>
<br/>

## 💡 참고문헌


