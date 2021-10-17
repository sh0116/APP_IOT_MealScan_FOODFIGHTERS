![Logo](./Meal_Mil_Scan/assets/images/logo.jpg)

<H3 align="center"> <i> 잔반 줄이기, 이제 즐기세요 </i></H3>

## 팀 소개
- 설명 기입

## 프로젝트 소개
밀스캔 (MealScan)은 장병들의 식판 이미지를 이용한 잔반 데이터 분석과 이를 바탕으로한 잔반 챌린지 이벤트를 통해 군 내 잔반 문제를 해결하기 위하여 만들어진 모바일 애플리케이션입니다. 군 음식물 쓰레기가 [역대 최대치](https://www.edaily.co.kr/news/read?newsId=02223846625936528&mediaCodeNo=257)를 경신한 지금, 기존 방식보다 더 편리하고 재치있는 해결법으로 잔반 문제 해결에 한 발짝 더 다가가고자 합니다. 

밀스캔은 세가지 Task로 이루어져 있습니다.
1. 📷 **Scan**\
식사를 마친 후 밀스캔 하드웨어 (Raspberry Pi)에 식판 및 본인식별 QR을 스캔해주세요. 밀스캔이 전우님의 식판 이미지를 분석하여 해당 식사의 전체적인 잔반 클리어률, 그리고 반찬 별 클리어률을 계산합니다.

2. 🥊 **Challenge**\
서비스에 가입하실 때 기입하신 부대고유코드를 바탕으로 전우님이 참가할 수 있는 잔반 챌린지를 제시합니다. 챌린지에 참가하게 되면 챌린지 기간동안 누적된 전우님의 잔반 클리어률이 순위에 반영되고, 최종 우승 시 지휘관이 설정한 포상을 획득하게 됩니다. 챌린지 경쟁자는 개인별, 중대별, 대대별 등 부대 상황과 지휘관 등록에 따라 달라집니다.

2. 📊 **Explore**\
Scan 단계에서의 데이터는 챌린지 뿐만 아니라 간편하고 보기 쉽게 시각화되어 밀스캔을 통해 확인하실 수 있습니다. 또한 잔반 별 클리어률을 바탕으로 매 끼니 별 배식 추천을 제공하여 배식받을 때나 자율배식 할 때 필요 이상을 받지 않도록 적게 배식받을 메뉴를 추천합니다. 또한 이런 데이터들은 밀스캔이 국방부와 공유하여 각 군단별 영양사분들이 더 효과적인 식단을 짤 수 있도록 돕겠습니다. 

## 기능 세부 설명
 - Scan: 식판을 밀스캔 거치대에 놓고, 라즈베리파이 화면에 나온 규격에 식판을 맞춤, Click을 눌러 식판을 찍고, 본인식별 QR코드 또한 스캔
 
- Challenge: 진행 중 탭에서 참가 가능한 현재 진행 중인 챌린지 확인, 챌린지 정보에서 포상내용 등을 확인 후 참가등록, 참가 중 탭에서 참가 중 챌린지 확인, 참가 중 챌린지를 탭하면 챌린지 정보 및 최신 순위를 보여주는 리더보드 확인 가능
<table>
        <tbody>
		<tr>
			<td colspan=2>
				<br>
				<b> 🥊 Challenge </b><br>
				<br>
			</td>
		</tr>
		<tr>
            <td rowspan="2"><div align="center"><a href="https://raw.githubusercontent.com/osamhack2021/APP_IOT_MealScan_FOODFIGHTERS
            /Meal_Mil_Scan/assets/images/explore_screenshots.png"><img src="./Meal_Mil_Scan/assets/images/explore_screenshots.png" width="90%" height="90%"></a></div></td>
            <td width="33%">끼니 별 배식 추천</td>
        </tr>
        <tr>
            <td>다양한 차트 + 애니메이션을 이용한 데이터 시각화 </td>
        </tr>
   </tbody>
</table>



<table>
        <tbody>
		<tr>
			<td colspan=2>
				<br>
				<b> 📊 Explore (Data) </b><br>
				<br>
			</td>
		</tr>
		<tr>
            <td rowspan="2"><div align="center"><a href="https://raw.githubusercontent.com/osamhack2021/APP_IOT_MealScan_FOODFIGHTERS
            /Meal_Mil_Scan/assets/images/explore_screenshot.png"><img src="./Meal_Mil_Scan/assets/images/explore_screenshot.png" width="90%" height="90%"></a></div></td>
            <td width="33%">끼니 별 배식량 추천</td>
        </tr>
        <tr>
            <td>다양한 차트 + 애니메이션을 이용한 데이터 시각화 </td>
        </tr>
   </tbody>
</table>

<table>
        <tbody>
		<tr>
			<td colspan=2>
				<br>
				<b> ➕ Album </b><br>
				<br>
			</td>
		</tr>
		<tr>
            <td rowspan="2"><div align="center"><a href="https://raw.githubusercontent.com/osamhack2021/APP_IOT_MealScan_FOODFIGHTERS
            /Meal_Mil_Scan/assets/images/explore_screenshots.png"><img src="./Meal_Mil_Scan/assets/images/explore_screenshots.png" width="90%" height="90%"></a></div></td>
            <td width="33%">스캔한 식판 사진 모두 조회</td>
        </tr>
        <tr>
            <td>각 식판 별 잔반 클리어률 확인 </td>
        </tr>
   </tbody>
</table>

<br>

## 컴퓨터 구성 / 필수 조건 안내 (Prerequisites)
* ECMAScript 6 지원 브라우저 사용
* 권장: Google Chrome 버젼 77 이상

<br>

## 기술 스택 (Technique Used) 💻 

* **Backend**

|Firebase|
|:---:|
|<a href="https://firebase.google.com/"><img src="../asset/rasp.png" height="30px"></a>|

* **FrontEnd**  

|Dart|Flutter UI Framework|
|:---:|:---:|
|<a href="https://dart.dev/"><img src="https://en.wikipedia.org/wiki/Dart_(programming_language)#/media/File:Dart_programming_language_logo.svg" height="50px"></a>|<a href="https://flutter.dev/"><img src="https://en.wikipedia.org/wiki/Flutter_(software)#/media/File:Google-flutter-logo.svg" height="60px"></a>|

* **IOT**  

|Raspberry Pi|Python|
|:---:|:---:|
|<a href="https://www.raspberrypi.org/"><img src="../asset/raspberrypi_logo_icon_168030.png" height="50px"></a>|<a href="https://www.python.org/"><img src="https://en.wikipedia.org/wiki/Python_(programming_language)#/media/File:Python-logo-notext.svg" height="60px"></a>|

## 설치 안내 (Installation Process)
```bash
$ git clone git주소
$ yarn or npm install
$ yarn start or npm run start
```

## 프로젝트 사용법 (Getting Started)
**마크다운 문법을 이용하여 자유롭게 기재**

잘 모를 경우
구글 검색 - 마크다운 문법
[https://post.naver.com/viewer/postView.nhn?volumeNo=24627214&memberNo=42458017](https://post.naver.com/viewer/postView.nhn?volumeNo=24627214&memberNo=42458017)

 편한 마크다운 에디터를 찾아서 사용
 샘플 에디터 [https://stackedit.io/app#](https://stackedit.io/app#)
 
## 팀 정보 (Team Information)
- hong gil dong (hong999@gmail.com), Github Id: gildong999
- kim su ji (suji999@gmail.com), Github Id: suji999

## 저작권 및 사용권 정보 (Copyleft / End User License)
 * [MIT](https://github.com/osam2020-WEB/Sample-ProjectName-TeamName/blob/master/license.md)

This project is licensed under the terms of the MIT license.

※ [라이선스 비교표(클릭)](https://olis.or.kr/license/compareGuide.do)

※ [Github 내 라이선스 키워드(클릭)](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/licensing-a-repository)

※ [\[참조\] Github license의 종류와 나에게 맞는 라이선스 선택하기(클릭)](https://flyingsquirrel.medium.com/github-license%EC%9D%98-%EC%A2%85%EB%A5%98%EC%99%80-%EB%82%98%EC%97%90%EA%B2%8C-%EB%A7%9E%EB%8A%94-%EB%9D%BC%EC%9D%B4%EC%84%A0%EC%8A%A4-%EC%84%A0%ED%83%9D%ED%95%98%EA%B8%B0-ae29925e8ff4)
