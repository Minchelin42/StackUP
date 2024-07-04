# 👩🏻‍💻 StackUP
<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/0cc1954c-49d4-4024-b6d1-eacb48f2b063" width="100" height="100"/>

### 온라인 강의를 탐색하고 원하는 강의를 수강할 수 있는 앱
- iOS 1인 개발 / BackEnd 협업
- 최소 버전 iOS 16.0
- 개발 기간 2주

## 📝 주요 기능
- 회원가입 및 로그인(유효성 검사)
- 프로필 수정 및 탈퇴
- 새로 나온 강의 / 인기 강의(결제 많은 순) / 강의 추천을 통한 강의 조회
- 카테고리를 통한 강의 검색
- 강의 수강(결제)
- 강의 수강 후기 작성
- 고객센터 1:1 대화
- 저장한 강의 및 수강중인 강의 내역 조회

## ⚒️ 사용 기술 및 라이브러리
`SwiftUI` `Combine` `Alamofire` `Kingfisher` `SocketIO` `UIKit` `DTO` `iamport` `SwiftConcurrency` `MVVM` `SPM`

## ⚒️ 기술 적용

- **Task**을 통해 비동기 작업 캡슐화, 관찰 및 제어
- **SocketIO**을 통한 실시간 양방향 통신으로 클라이언트와 서버 간의 메시지 전송을 실시간으로 처리
- **DTO**를 통해  데이터 계층 간의 객체 전송을 단순화하고 효율화하여 시스템 모듈 간의 결합도를 낮춤
- **Portone** 연동을 통해 여러 결제 대행사(PG) 및 간편결제를 WebView 기반으로 구현
- SwiftUI에서 **Router Pattern**을 통해 뷰 전환을 제어하고, 앱의 네비게이션 흐름에 대한 유지보수가 용이하도록 구현
- **propertyWrapper**를 통해 UserDefaults 값을 저장 및 접근할 수 있도록 구현하여 코드의 재사용성을 높이고 데이터 저장 로직을 간결하게 만듦

## 📷 스크린샷

|홈 화면|강의 상세 화면|마이페이지|
|:---:|:---:|:---:|
|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/a7d4ea16-7311-43c2-a41f-f39f14387d99" width="200" height="390"/>|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/f1fb2d3f-8ae8-44f6-8da1-0aad71df93a0" width="200" height="390"/>|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/157aa68b-d5e2-4671-a82d-1965ee6aeea2" width="200" height="390"/>|

|후기 작성|수강신청 내역|찜한 강의|
|:---:|:---:|:---:|
|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/0492ddda-0d50-40c8-8c0c-66ba491e39d4" width="200" height="390"/>|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/92c3d935-aa3b-4a98-aa7b-c76d598b4eae" width="200" height="390"/>|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/f930a61c-fd00-46c9-8fac-8a2a0b8180ed" width="200" height="390"/>|

|강의 검색|강의 검색 결과|고객센터|
|:---:|:---:|:---:|
|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/5232a626-90ff-4dbb-8859-b8bb8341580f" width="200" height="390"/>|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/18e63635-5d5f-4ece-bf6c-7d7bcb4a2dc4" width="200" height="390"/>|<img src="https://github.com/Minchelin42/TechMasterSwiftUI/assets/126135097/28c00482-f7bb-42bd-a657-bb9b31ae0e9a" width="200" height="390"/>|

## 💥 트러블슈팅

### 1️⃣ 복잡한 화면 전환 로직에 대한 불편함

Navigation을 이용한 화면 전환 로직이 복잡하여 한 곳에서 관리하기 위해 Router Pattern 도입

```Swift
public final class Router: ObservableObject {
    @Published public var route = NavigationPath()
    public init() { }
    
    @MainActor
    public func push<T: Hashable>(view: T) {
        route.append(view)
    }
    
    @MainActor
    public func pop() {
        route.removeLast()
    }
    
    @MainActor
    public func pop(depth: Int) {
        route.removeLast(depth)
    }
    
    @MainActor
    public func popToRoot() {
        route = NavigationPath()
    }
    
    @MainActor
    public func switchView<T: Hashable>(view: T) {
        guard !route.isEmpty else { return }
        var tempRoute = route
        tempRoute.removeLast()
        tempRoute.append(view)
        route = tempRoute
    }
}
```

### 2️⃣ 프로필 수정 API 통신 이후 pop 됐을 때 바로 데이터가 적용되지 않음
초기 상황 : 프로필 수정 alert 버튼 확인을 누르면 API 통신 -> router.pop을 이용하여 화면 전환

발생한 문제 : 이러한 방식을 사용할 경우 프로필 수정 API 보다 이전 화면에서 프로필 조회 API가 먼저 완료될 경우 변경된 프로필로 조회해서 가져올 수 없음

해결 방안 : viewModel에서 editProfile 통신 후 receiveValue에서 값을 받으면 output.pop에 대한 값을 변경하여 해당 output 값이 변하는 시점을 **onChange**를 통해 파악하고 이때 router.pop이 실행되도록 변경

```Swift
    func transform() {
        input.editProfileButtonTapped
            .sink { [weak self] query in
                guard let self else { return }
                Task { await self.editProfile(query: query) }
            }
            .store(in: &cancellables)
    }
    
    func editProfile(query: ProfileQuery) async {
        do {
            try await Network.shared.multipartAPICall(model: ProfileResponseDTO.self, router: ProfileRouter.editProfile, query: query)
                .sink { result in
                    switch result{
                    case .finished:
                        print("Fetch Success")
                    case .failure:
                        print("Fetch Failed")
                        print(result.self)
                    }
                } receiveValue: { [weak self] resultProfile in
                    guard let self else { return }
                    self.output.pop = true
                }
                .store(in: &cancellables)
        } catch {
            print("edit Profile 실패")
        }
    }
```


```Swift
     VStack {
        //EditProfileView
    }
    .onChange(of: viewModel.output.pop) { newValue in
        if newValue {
            router.pop()
        }
    }
```
