### Semi Project
2024.06.24 ~ 2024.07.12 세미프로젝트 용 repositories 입니다.

### Delimate - USER와 RIDER 매칭을 통한 개인 거래 시스템

## 프로젝트 개요

Delimate는 사용자와 배달원을 매칭하여 개인 간(P2P) 거래를 중계하는 플랫폼입니다. 이 프로젝트는 사용자들이 손쉽게 배달을 요청하고, 라이더들이 해당 요청을 수락하여 배달을 수행할 수 있는 환경을 제공합니다. Spring MVC와 MyBatis를 사용해 백엔드 로직을 구현하였고, Oracle DB를 사용해 데이터베이스를 관리합니다. 이 프로젝트는 2024년 6월 24일부터 2024년 7월 16일까지 진행되었습니다.

## 개발 목표

- P2P 배달 중계 사이트 개발
- 사용자와 라이더 간의 실시간 소통을 지원하는 채팅 기능 구현
- 효율적이고 직관적인 사용자 인터페이스 제공

## 사용 기술 및 개발 환경
- 운영체제: Windows 10
- 프로그래밍 언어: JAVA, HTML5, Javascript, CSS3
- 프레임워크 및 라이브러리: Spring MVC, JSP, MyBatis, Lombok
- 데이터베이스: Oracle DB
- 개발 도구: Eclipse
- WAS: Tomcat
- 협업 도구: Git, GitHub, Notion

## 주요 구현 기능
회원가입 및 로그인
- 회원가입 기능: 사용자가 제공한 정보를 바탕으로 회원가입을 처리하며, 비밀번호는 BCryptPasswordEncoder로 암호화하여 저장합니다. 회원가입 성공 시 플래시 메시지를 통해 성공 알림을 제공하고, 기본 페이지로 리다이렉트합니다.
- 로그인 기능: 사용자가 로그인 요청을 보내면, UserService를 통해 사용자의 정보를 조회하고 비밀번호를 검증합니다. 로그인 성공 시, 사용자의 세션에 loginUser 정보를 저장하고, 이전 페이지로 리다이렉트합니다. 또한, 관리자의 경우 별도의 알림 메시지가 제공됩니다.

주문 수락 및 채팅방 개설
- 채팅방 개설: 사용자가 배달 주문을 요청하고 라이더가 이를 수락하면, 자동으로 채팅방이 생성됩니다. 이를 통해 사용자와 라이더 간 실시간 소통이 가능해집니다.
- 1대1 채팅 기능: WebSocket과 Spring의 STOMP 프로토콜을 활용하여 실시간 양방향 통신을 구현했습니다. 클라이언트는 /app 경로를 통해 메시지를 전송하며, 서버는 /topic 경로를 통해 다수의 클라이언트에게 메시지를 브로드캐스트합니다. SimpMessagingTemplate을 사용해 특정 주제(topic)에 메시지를 전송하고, 이를 구독한 클라이언트들이 실시간으로 메시지를 수신할 수 있도록 하였습니다.

데이터베이스 설계
- users (사용자 정보): 플랫폼 사용자의 기본 정보를 저장합니다.
- orders (주문 정보): 사용자가 생성한 주문 정보를 관리하며, 주문 관련 이미지는 orders_img 테이블에 저장됩니다.
- chat_room & message (채팅 기능): 사용자 간의 채팅 방과 메시지를 관리합니다.
- inquiries, inq_ans, inq_img (문의 관련 기능): 사용자가 등록한 문의사항과 관련된 답변 및 이미지를 관리합니다.
- reports (신고 정보): 사용자 간의 신고 내용을 저장합니다.
- reviews (리뷰 정보): 주문에 대한 리뷰 정보를 저장하며, 주문 정보와 연결되어 있습니다.
- riders & vehicles (라이더와 차량 정보): 라이더 및 차량 정보를 관리하는 별도의 엔터티입니다.

## 프로젝트 참여 소감

이번 프로젝트에서 저는 회원가입과 로그인, 주문 수락에 따른 채팅방 개설, 1대1 채팅 기능을 담당했습니다. 
사용자 인증과 실시간 소통의 중요성을 체감하며, 개발자로서 많은 성장을 이루었습니다. 
Github와 Notion을 통한 협업은 팀워크의 가치를 깨닫게 해주었고, 다양한 기술을 통합하는 과정에서 실질적인 경험을 쌓을 수 있었습니다.

### 💫같은 로직이라도 목적에 따라 다른 방식을 선택할 수 있음을 많이 깨달았던 프로젝트였습니다.
