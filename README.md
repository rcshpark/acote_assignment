# 아코테 과제전형

## 개요

이 Flutter 애플리케이션은 github api를 사용하여 사용자를 조회하여 화면에 보여준 뒤, 특정 사용자를 클릭했을 때, 해당 사용자의 레파지토리 리스트를 보여주는 기능을 구현한 애플리케이션입니다.
단위 테스트와 E2E 테스트 코드를 포함하고 있습니다.


## 기능

- 사용자 불러오기
- 페이지네이션
- 클릭한 사용자의 레파지토리 불러오기
- 10,20,30.. 번째 리스트에는 배너 표시
- 배너 클릭 시, 해당 url로 이동 
- 단위 테스트, E2E 테스트


## 의존성

이 애플리케이션은 다음과 같은 의존성을 사용합니다:
- `flutter_riverpod`: 상태 관리용.
- `firebase_storage`: Firebase Storage에서 이미지를 저장하고 가져오기 위해 사용.
- `freezed`: 불변 클래스와 union 타입을 생성하기 위해 사용.
- `json_serializable`: JSON 직렬화/역직렬화를 자동화하기 위해 사용.
- `url_launcher`: 배너 클릭 시 url 이동을 위해 사용.
- `http`: HTTP 통신을 위해 사용.


## 실행 방법

1. 저장소를 클론합니다.
- git clone https://github.com/rcshpark/acote_assignment.git

2. 프로젝트 디렉토리로 이동하여 의존성을 설치합니다.
- cd 프로젝트 클론 경로 
- flutter pub get

3. build_runnder 를 실행하여 코드를 생성합니다.
- flutter pub run build_runner build

4. 앱을 실행합니다.
- flutter run 


## 프로젝트 아키텍처
```bash
lib
├── core
│ └── usecase
├── data
│ ├── const
│ ├── data_source
│   └──── mock
│   └──── remote
│ ├── dto
│ ├── exception
│ ├── repository
│ └── translator
├── domain
│ ├── model
│ ├── repository
│ └── usecase
├── presentation
│ ├── screen
│ └── view_model
└── main.dart
```

아키텍처는 Clean Architecture와 MVVM 패턴을 사용하여 진행했습니다.
테스트를 위해 mock 과 remote 파일을 분리하여 진행했습니다.
riverpod을 선택한 이유는 상태와 비즈니스 로직을 분리할 수 있게 도와주며, 전역 상태 관리를 쉽게 할 수 있고, 러닝커브도 bloc에 비해 낮은 것 같아서 이 과제에서 적용시켜 보면 좋겠다 라는 마음에 선택하게 되었습니다.

## 테스트에 대하여
단위 테스트인 경우, 프로젝트에서 선언한 provider 의 기능에 대해 테스트를 진행했습니다.
1. 사용자 조회
2. 특정 사용자의 레파지토리 조회
3. 에러상황 (이 부분 테스트 진행 시에는 data/const/mock_data 의 mock data를 errorResult 로 사용하여 테스트를 진행했습니다.)

End to End 테스트 경우, 시나리오를 작성하여 진행했습니다.
1. 사용자가 앱을 실행시킨다.
2. 사용자는 10,20,30.. 번째의 리스트마다 배너를 확인한다.
3. 배너를 클릭하면 특정 url로 이동된다.
4. 리스트의 첫번째 사용자를 클릭한다.
5. 클릭한 사용자의 레파지토리 리스트가 보인다.
6. 뒤로가기 버튼을 클릭한다.
7. 돌아온 화면에 이상이 있는지 없는지 확인한다. 
8. 사용자가 스크롤을 했을 때, 페이지네이션 기능이 동작한다.

7번까지의 시나리오에는 문제가 없이 테스트가 통과 되는 것을 확인했습니다. 
페이지네이션 동작 테스트는 기존의 리스트 개수와 페이지네이션 동작 후 리스트의 개수를 비교하여 기대값을 요구했는데 테스트 결과 실패하였습니다.