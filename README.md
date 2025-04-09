# 🌷 Z세대를 위한 셀렉샵 플랫폼
### 1조 과제 쇼핑몰 앱입니다.

<br>

## 🖼️ Overview
이 프로젝트는 **Z세대**의 취향을 반영하여 기획된 셀렉샵 플랫폼입니다.  
계절감 있는 **봄 테마 UI**, 간결하고 **사용자 친화적인 UX**, 그리고 트렌디한 요소들을 적극 반영하였습니다.

<br>

## 🪄 주요 기능 요약

### 📄 상품 리스트 페이지
<img src="https://github.com/user-attachments/assets/3606c9dd-7233-4d03-9bfb-2519c68d3d62" width="300" height="700"/>

- 앱 실행 시 가장 먼저 보이는 기본 화면
- 등록된 상품들이 리스트 형태로 정렬됨
- 각 상품은 이미지, 제목, 가격, 재고, 별점을  표시
- 항목을 탭하면 해당 상품의 **상세 페이지**로 이동
- 상품이 새로 등록되면 리스트에 즉시 반영됨 (`setState` 또는 상태관리 적용)

<br>

### 🛍️ 상품 등록
<img src="https://github.com/user-attachments/assets/3c79e8cb-c162-40dd-b759-74afafcedc5a" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/0e5981bd-e990-47b6-9338-ffd1b1621291" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/c3284e07-1db5-4c87-8606-dad9ff6e3a17" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/40958b10-c03a-4ad1-aedc-d1e21d134974" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/547f65ea-8dc2-4b8f-8652-80dad856dbe4" width="300" height="700"/>

- `상품명`, `가격`, `이미지`, `설명`, `재고`를 입력 후 상품 리스트에 추가
- 등록된 상품은 리스트 페이지에 실시간으로 반영
- 입력 필드는 TextField, 이미지 경로는 로컬 `assets` 사용

<br>

### 🔍 상세 페이지
<img src="https://github.com/user-attachments/assets/b4565245-8076-44d6-a7c9-c18cd5aed929" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/4ba24848-f3cd-4c78-938d-2775acb2e690" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/ad2826d6-a597-4e9d-b6e5-15b29264da08" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/c94f6fdd-d5d8-450b-9d6a-ca9dc413c8fd" width="300" height="700"/>

- 상품 이미지 및 설명 표시
- 수량 조절 기능 (`+`, `–` 버튼)
- 구매 후, 재고 차감

<br>

### 🛒 장바구니 페이지
<img src="https://github.com/user-attachments/assets/323c6ea6-e2ed-4d92-904c-80acfcd3f780" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/69f8103b-44f0-4dee-8e34-65f464531c3b" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/05539a6e-cf20-42b4-bc4b-16666e4b38a2" width="300" height="700"/>

- 장바구니에 추가된 상품 목록 표시
- 선택한 상품만 총 가격 계산
- 결제하기 버튼을 클릭하면 선택한 상품만 결제
- 결제 후, 재고 차감

<br>

### 💳 결제 처리
- 결제 버튼 클릭 시 상품 재고 차감
- 수량이 재고보다 많을 경우 경고 팝업 표시 (`CupertinoAlertDialog`)
- 재고가 0이 되면 결제 불가 알림 표시

<br>

###  📝 리뷰 작성
<img src="https://github.com/user-attachments/assets/9d71b773-3503-40a3-a486-19f93f2f4071" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/b1e18305-c70d-432d-8be4-722621925d55" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/bf54d3c0-cf21-48c7-ad71-8bc373ed07ae" width="300" height="700"/>
<img src="https://github.com/user-attachments/assets/bd7b74f2-c03e-4b70-84f2-c907f79da06c" width="300" height="700"/>

- **[리뷰 탭 전환]**: 상세 페이지 상단에서 "상품설명 ↔ 리뷰" 전환 가능
- **[리뷰 등록]**: 텍스트 입력 후 등록 시, 화면에 리뷰가 바로 반영됨
- 사용자가 리뷰를 작성하고 등록하면, 해당 상품의 리뷰 목록과 함께 **평균 평점**이 자동 갱신됩니다.
- UI 상단의 별점 표시(`⭐ 4.5 / 5`)가 리뷰 등록 직후 즉시 업데이트되어 사용자에게 즉각적인 피드백을 제공합니다.

<br>

###  🌙 다크모드 대응
<img src="https://github.com/user-attachments/assets/1d98ab79-c6ab-4f41-8519-4aeda185514f" width="300" height="700"/>

- 테마 설정에 따라 UI 스타일 자동 전환 (예: 배경, 텍스트 색상)

<br>

### 📂 사용된 기술 스택

- `Flutter` (StatefulWidget 기반 구조)
- 커스텀 수량 조절 컨트롤러 (`QuantityController`)
- 싱글톤 패턴 장바구니 모델 (`Cart`)
- 다크/라이트 테마 (`ThemeMode`)
- 리뷰 등록 시 `setState()`로 동적 UI 업데이트
- `setState()`에 의한 UI 실시간 반영


---
