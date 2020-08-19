## 전자정부 표준 프레임워크 커스터마이징
***
### 파스타 클라우드 활용(공통)
1. 스프링프로젝트 LeeTaeHee-egov 변경(도메인의 호스트네임으로 사용)
2. 이클립스에서  LeeTaeHee-egov 프로젝트를 파스타에 배포 (MySQL 용)
3. LeeTaeHee-egov 프로젝트용 클라우드DB생성:서비스명은 egov-mysql-db
4. 파스타 클라우드에서 egov-mysql-db의 원격 접속 이름과 암호를 확인
5. 이미 생성된 phpmyadmin 어플리케이션명:LeeTaeHee-myadmin 실행
6. https://LeeTaeHee-myadmin.paas-ta.org 접속후 전자정부 프로젝트용 더미데이터 인서트
7. https://LeeTaeHee-egov.paas-ta.org 사이트에서 파스타 배포결과 확인
***

### 2020.08.19(수) 작업내역(아래)
1. DB인터페이스 확인 - 실행가능한 소스 https://github.com/miniplugin/Dbinterface_ora_ok.git
	(오라클 insert 후 커밋, -System.out.print(vo.toString())- )
2. 타일즈 템플릿(UI족-레이아웃 정리) 라이브러리 사용/전자정부프로젝트에 적용
3. 클라우드 파스타 mysql서비스 제거 후, 생성(name-egov-db 서비스 이름)
4. 클라우드 파스타 앱 제거 후, 이클립스 PUSH(name-egovadmin관리용 php앱 이름)

### 2020.08.18(화) 작업내역
1. 관리자 등록시 아이디 중복체크(RestAPI사용) 마무리
	- RestAPI 사용은 이클립스 내장 브라우저에서는 않되기 때문에, 크롬에서 사용
2. 서버 프로그램 시험준비 후 3교시부터 시험

### 2020.08.17(월) 작업내역(아래)
1. 관리자관리 기능 CRUD 작업 마무리
2. 관리자 등록시 아이디 중복체크(RestAPI 사용) 기능 추가
3. 전자정부 프로젝트*(관리자관리기능 추가한것) 파스타에 배포

### 2020.08.14(금) 작업내역(아래)

0. 관리자관리 경로 com/member/selectMember.do 로그인체크 추가
	로그인 체크 관련 파일 : egov-com-servlet.xml(서블렛파일) 인터셉터 관리
	뷰리졸버(viewresolver): 뷰단(jsp)단 해석기계(웹 페이지 루트, 확장자 지정)
	
1. 컨트롤러에 memberList 페이지 경로추가(아래)
	- edu.human.com.member.web(컨트롤러용 패키지)
	- MemberController.java @Controller 클래스 생성
	- com/member/selectMember.do

```
/** 
* 관리자 목록을 조회한다.
*/
@RequestMapping("/com/member/selectMember.do")
public List<EmployerInfoVO> selectMember(Model model) throws Exception{
	model.addAttribute("resultList",멤버서비스호출);
	return "com/member/list";
}
```
2. member View 페이지, update 페이지, insert 페이지 생성

```
- 우리가 기존에 작업한 스프링 프로젝트에서 
/*
	<form id="폼이름" name="폼이름">
	</form>
*/

- 전자정부 프로젝트에서는 
/*
	<form:form commandName="폼이름"  name="폼이름">
	</form:form>
*/
```
3. 로컬 PC에서 결과 확인 후, 파스타에 배포예정


### 2020.08.13(목) 작업내역(아래)
1. viewMember 쿼리 + DAO + Service 메서드 추가후 JUnit테스트 OK
2. jsp폴더(view폴더)에 inc/EgovIncleftment.jsp 파일수정

```
메뉴내용 추가(아래)
<li class="dept02">
<a href="javascript:fn_main_headPageAction('57','com/member/selectMember.do')">관리자관리</a></li>
```

### 2020.08.12(수)작업내역(아래)
1. 쿼리 생성: src/main.resources/egovframework/mapper/com/member/member_mysql.xml
2. DAO클래스에서 insertMember, updateMember, deleteMember 메서드 생성
3. Service 클래스에서 insertMember,updateMember,deleteMember 메서드 생성
4. JUnit 테스트로 CRUD 확인


###2020.08.11(화)작업내역(아래)
- JUnit 테스터로 DAO의 selectMember 실행하기

```
1. 전자정부 프로젝트는 기본 JUnit이 없기 때문에, 테스트 환경을 만들어야함.. Pom.xml 모듈 추가하기
2. src/test/java/~/TestMember.java 추가 / @ContextConfiguration 경로를 2개추가

3. egov-com-servlet.xml 파일에서 component-scan 부분에서 제워된(exclude)를 -> 포함시킴(include)
```

-DAO(@Repository), Service(@Service) 만들기

```
1. service/impl/MemberDAO.java(추상클래스 사용, extends EgovAbstractDAO 필수)

2. service/MemberService.java(인터페이스)

3. service/impl/MemberServiceImpl.java(구현클래스)
- @Resource 대신 @inject 사용
```

- 프로젝트에서 마이바티스 사용하기

```
1. maven Module 추가 ( pom.xml)
<!-- MyBatis 사용/ 데이터를 가져오기를 하는 메소드(ex.자바 <-> Mysql) -->
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis</artifactId>
	<version>3.2.8</version>
</dependency>
<dependency>
	<groupId>org.mybatis</groupId>
	<artifactId>mybatis-spring</artifactId>
	<version>1.2.2</version>
</dependency>

2. 관리자관리에 사용되는 테이블 확인: emplyrinfo

3. 관리자 관리 테이블과 get/set 하는 VO 만들기: EmployerInfoVO.java
- 테이블 생성쿼리에서 필드명 복사VO 자바파일에서 사용, 특이사항, 대->소문자 변환( Ctrl + shift + y 단축키 사용 )

4. Spring - MyBatis 설정파일 추가: context-mapper.xml
- configLocation: MyBatis 설정 파일 위치 mapper-config.xml 추가
- mapperLocation: 쿼리가 존재하는 폴더 위치  member_mysql.xml 추가(쿼리)
```


### 2020.08.10(월) 작업내역(아래)
***
### 파스타 클라우드 활용
	1. 스프링프로젝트 LeeTaeHee_mysql 변경
	2. 이클립스에서  LeeTaeHee_mysql 프로젝트를 파스타에 배포 (Hsql 용)
	3. LeeTaeHee_mysql 로컬 mysql서버와 연동처리
	4. 파스타 클라우드에서 Mysql 서비스 생성(원격 접속 이름과 암호를 확인가능)
	5. 원격 phpMyAdmin 툴(워크벤치와 비슷)을 파스타 클라우드에 PHP앱 생성후 배포
	6. LeeTaeHee_mysql 프로젝트를 클라우드용 DB사용으로 변경후 파스타에 재배포
	   http://LeeTaeHee_mysql.paas-ta.org
	7. egov_sht 프로젝트명 변경: egov_LeeTaeHee 파스타에 배포(Mysql 클라우드 사용)
	   http://egov_LeeTaeHee.paas-ta.org
	   
- context-datasource.xml : Hsql DB 사용 주석처리

```
<!-- hsql
<jdbc:embedded-database id="dataSource-hsql" type="HSQL">
	<jdbc:script location= "classpath:/db/shtdb.sql"/>
</jdbc:embedded-database> -->
```
- globals.properties : DB에 관련된 전역변수 지정(주:유니코드 에디터로 생성됨)

```
# DB서버 타입(mysql,oracle,altibase,tibero) - datasource 및 sqlMap 파일 지정에 사용됨
Globals.DbType = mysql(Mysql로 변경)
Globals.UserName=sa
Globals.Password=

# mysql - 주석해제
Globals.DriverClassName=net.sf.log4jdbc.DriverSpy
Globals.Url=jdbc:mysql://127.0.0.1:3306/sht

#Hsql - local hssql 사용시에 적용(주석처리)
#Globals.DriverClassName=net.sf.log4jdbc.DriverSpy
#Globals.Url=jdbc:log4jdbc:hsqldb:hsql://127.0.0.1/sampledb
```
- web.xml : 톰캣(WAS)가 실행될때 불러들이는 xml설정들(web.xml)

```
egov-com-servlet.xml(아래)
 - DispatcherServlet(서블렛배치에 관련된 설정/컴포넌트 스캔에 관련된 설정/@Controller,@Service,@Repository에 관련된 설정 수정)
 - <context:component-scan base-package="egovframework, edu">
 - 위에서 edu 추가 : 'edu.human.com' 패키지 추가로 해당패키지로 시작하는 모든 컴포넌트를 bean(실행가능한 클래스)으로 자동 등록하게 처리
```

- pom.xml : maven 설정 파일중 Hsql DB를 Mysql DB사용으로 변경

```
<!-- Hsql 주석처리
<dependency>
	<groupId>org.hsqldb</groupId>
	<artifactId>hsqldb</artifactId>
	<version>2.3.2</version>
</dependency>
 -->
<!-- mysql driver 주석 해제-->
<!--  -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.31</version>
</dependency>

<!-- log4jdbc driver 주석해제 / 기능 : Consol창에 쿼리보이기-->
<dependency>
    <groupId>com.googlecode.log4jdbc</groupId>
    <artifactId>log4jdbc</artifactId>
    <version>1.2</version>
    <exclusions>
        <exclusion>
            <artifactId>slf4j-api</artifactId>
            <groupId>org.slf4j</groupId>
        </exclusion>
    </exclusions>
</dependency>		
```

