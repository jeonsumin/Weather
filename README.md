#
날씨앱

## 기능상세 
- 도시 이름을 입력하면 현재 날씨 정보를 가져와 화면에 표시
- 도시 이름을 잘못 입력하면 서버로부터 응답받은 에러 메시지가 알럿으로 표시 

## 활용 기술 
- Current Weather API
- URLSession 

## DEMO 
![ezgif com-gif-maker](https://user-images.githubusercontent.com/51107183/148495734-abb7ae0c-a882-4944-8510-f03b1eb49ddb.gif)


## 배운 내용
#### 웹 통신과 Protocol
- 인터넷 상에서의 통신을 말한다.
- 많은 정보를 주고 받기에 인터넷에는 엄격한 규약이 존재 Protocol 

##### HTTP( Hyper Text Transfer Protocol)
> Hyper Text를 전송하기위한 프로토콜

- HTTP 통신 
<img width="1312" alt="스크린샷 2022-01-07 오전 10 22 31" src="https://user-images.githubusercontent.com/51107183/148475898-52c0e4a5-7c1a-4f8a-afd9-85912c8d9795.png">

- HTTP  패킷
<img width="602" alt="스크린샷 2022-01-07 오전 10 23 38" src="https://user-images.githubusercontent.com/51107183/148475953-924c830d-635c-42f3-a199-f68662309a81.png">

- HTTP Method 
	- **GET** : 리소스를 요청할때 사용 
	- **POST** : 리소스를 새로 만들때 사용 
	- **PUT** :  리소스를 전체 수정할 때 사용 
	- **PATCH** : 리소스를 일부 수정할 때 사용 
	- **DELETE** : 리소스를 삭제할 때 사용 
	- **HEAD** : 정상 작동 여부를 확인 할 때 사용 
	- **OPTIONS** : 해당 URL이 어떤 메소드를 지원하는지 확인할 때 사용 
	- **CONNECT** : 클라이언트가 프록시를 통하여 서버와 SSL 통신을 하고자 할때 사용 
	- **TRACE** : 통신 관리 및 디버깅할 때 사용 

- HTTP Status 
	- 100번대 Informational : 요청 정보를 처리중 
	- 200번대 Success : 요청을 정상적으로 처리 
	- 300번대 Redirection : 요청을 완료하기 위해 추가 동작 필요 
	- 400번대 Client Error : 서버가 요청을 이해하지 못함
	- 500번대 Server Error : 서버가 요청 처리 실패 

#### URLSession 
> 특정한 url 을 이용하여 데이터를 다운로드하고 업로드하기 위한 API 

 - 공유 세션 (shared Session) 
 
 ```
 URLSession.shared()  
 ```
 
 - 기본세션 (Default Session)
 ```
 URLSession(configureation: .default)
 ```
 
  - 임시세션 (Eqhemeral Session)
 ```
 URLSession(configureation: .ephemeral)
 ```

  - 백그라운드 세션 (Background Session)
 ```
 URLSession(configureation: .background)
 ```
 
 #### URLSessionTask 

- URLSessionDataTask
- URLSessionUploadTask
- URLSessionDownloadTask
- URLSessionStreamTask
- URLSessionWebSocketTask 

#### URLSession Life Cycle
1. Session Configuration 을 결정하고, Session을 생성 
2. 통신한 URLrhk Request 객체를 설정 
3. 사용할 Task 를 결정하고 그에 맞는 Completion Handler 나 Delegate 메소드들을 작성 
4. 해당 Task를 실행 
5. Task 완료 후 Completion Handler 클로저가 호출 됨 

