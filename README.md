## 전자정부 표준 프레임워크 커스터마이징
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

