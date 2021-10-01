<h1>3D 프린트 도안 및 설명</h1>
프로젝트의 IoT부분인 Raspberry Pi를 지탱하고 식판을 위에서 수직으로 찍기 위해 필요한 구조물을 위해 
3D Printing을 사용하게되었습니다.

<div align="center">
<img src="/3D_printing/asset/all.png">

</div>

<div align="left">
 
<h2>3D Printing 설계 및 출력</h2>
STL파일 제작 및 3D 도면 제작은 오픈소스 Tinkercad를 사용해서 제작했다. <br><br>
설계를 할때 주요 고려해던 사항 <br>
  ● 출력의 속도를 고려한 설계 <br>
  ● 빛이 잘 통하는 구조 <br>
  ● 전용 카메라와 바닥의 수직상 거리 <br><br>
출력 세부사항 <br>
  ● 채움의 정도 0% <br>
  ● 외벽의 두깨 1~0.5 mm <br>
  ● 출력 속도는 해당 기계의 최고 속도 <br>
  ● ... <br>

<h2>부속품 소개</h2>
<h3>top.stl</h3>
라즈베리파이와 카메라가 올라가는 부속품, <br>
구조물의 최상단의 위치해 지붕의 역할
<img src="/3D_printing/asset/top.png">
<h3>bottom.stl</h3>
식판을 놓고, 구조물을 지탱하는 부분 <br>
구조물의 하단에 위치해 구조물의 주춧돌 역할 <br>
<img src="/3D_printing/asset/bottom.png">
<h3>pillar.stl</h3>
총 6개의 기둥으로 top와 bottom을 이어주는 역할
<br>
<img src="/3D_printing/asset/pill.png">
  
<h2>부속품의 결합 및 구조물 소개 </h2>
<h3>Raspberry PI 와 top부분 결합 </h3>
Top 부속품 Center에 전용 카메라를 부착할 수 있는 구멍이 있다. <br>
이 부분에 전용 카메라를 결합하고 라즈베리파이와 전용 스크린을 Top부속품에 부착시키면 된다.<br>
※ IoT 부분 구성 : Raspberry Pi,전용 터치 스크린,전용 카메라 <br>
<img src="/3D_printing/asset/rasp1.png">
  
<h3>Top & Bottom에 기둥 결합 </h3>
Top & Bottom에 총 6개의 기둥을 결합 <br>
Top의 하단 부분 Bottom의 상단 부분에 기둥과 0.1mm 차이가 나는 구멍이 있다.
<img src="/3D_printing/asset/top2.png">


</div>
