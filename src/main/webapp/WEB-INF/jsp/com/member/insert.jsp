<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- 날짜 포맷 변경 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 관리</title>
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
</head>
<body>
	<!-- 전체 레이어 시작 -->
	<div id="wrap">
	    <!-- header 시작 -->
	    <div id="header_mainsize"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
	    <div id="topnavi"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncTopnav" /></div>        
	    <!-- //header 끝 --> 
	    <!-- container 시작 -->
	    <div id="container">
	        <!-- 좌측메뉴 시작 -->
	        <div id="leftmenu"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncLeftmenu" /></div>
	        <!-- //좌측메뉴 끝 -->
	            <!-- 현재위치 네비게이션 시작 -->
	            <div id="content">
	                <div id="cur_loc">
	                    <div id="cur_loc_align">
	                        <ul>
	                            <li>HOME</li>
	                            <li>&gt;</li>
	                            <li>사이트관리</li>
	                            <li>&gt;</li>
	                            <li><strong>게시판템플릿관리</strong></li>
	                        </ul>
	                    </div>
	                </div>
				<form:form commandName="insertForm" name="insertForm" method="post">
	                <div class="modify_user">
		                <table >
							<tr> 
							  <th width="20%" height="23" class="required_text" nowrap >
							  사용자 아이디</th>
							  <td width="80%" nowrap="nowrap">
							  	<c:out value="${memberVO.EMPLYR_ID}"></c:out>
							  	<input name="EMPLYR_ID" id="EMPLYR_ID" type="text" value="" />
							  </td>
							</tr>
							<tr> 
							  <th width="20%" height="23" class="required_text" nowrap >
							  사용자 암호</th>
							  <td width="80%" nowrap="nowrap">
							  	<input id="PASSWORD" name="PASSWORD" type="password" value=""/>
							  </td>
							</tr>
							<tr> 
							  <th width="20%" height="23" class="required_text" nowrap >
							  암호 힌트</th>
							  <td width="80%" nowrap="nowrap">
							  	<input id="PASSWORD_HINT" name="PASSWORD_HINT" type="text" value="" />
							  </td>
							</tr>
							<tr> 
							  <th width="20%" height="23" class="required_text" nowrap >
							  암호 정답</th>
							  <td width="80%" nowrap="nowrap">
							  	<input id="PASSWORD_CNSR" name="PASSWORD_CNSR" type="text" value="" />
							  </td>
							</tr>
							<tr> 
								<th width="20%" height="23" class="required_text" nowrap >
								사용자 이름</th>
								<td width="80%" nowrap="nowrap">
									<input name="USER_NM" type="text"value=""/>
								</td>
							</tr>
							<tr> 
						        <th width="20%" height="23" class="required_text" nowrap >
						        우편번호</th>
						        <td width="80%" nowrap="nowrap">
									<input name="ZIP" type="text" value=""/>
								</td>
							</tr>
							<tr> 
							  <th width="20%" height="23" class="required_text" nowrap >
							  집주소</th>
							  <td width="80%" nowrap="nowrap">
							  	<input name="HOUSE_ADRES" type="text" value=""/>
							  </td>
							</tr>
							<tr> 
								<th width="20%" height="23" class="required_text" nowrap >
								이메일</th>
								<td width="80%" nowrap="nowrap">
									<input name="EMAIL_ADRES" type="text" value=""/>
								</td>
							</tr>
							<tr> 
								<th width="20%" height="23" class="required_text" nowrap >
								등급</th>
								<td width="80%" nowrap="nowrap">
									<select name="GROUP_ID">
										<c:forEach var="auth" items="${authVO}">
											<option value="${auth.GROUP_ID}">${auth.GROUP_NM}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th width="20%" height="23" class="required_text" nowrap >
								소속기관</th>
								<td width="80%" nowrap="nowrap">
									<input name="ORGNZT_ID" type="text" value=""/>
								</td>
							</tr>
							<!-- 휴면계정 초기값 P 지정 -->
							<input name="EMPLYR_STTUS_CODE" type="hidden" value="P"/>
						</table>
					</div>
                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                      <!-- 목록/저장버튼  -->
                      <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                              <a href="#LINK" id="insert_member">
                              <spring:message code="button.create" /></a>
                          </td>
                          <td width="10"></td>
                          <td>
                              <a href="<c:url value='/com/member/selectMember.do'/>">
                              <spring:message code="button.list" /></a>
                          </td>
                        </tr>
                      </table>
                    </div>
                    <!-- 버튼 끝 -->
                    <input name="ESNTL_ID" type="hidden" value="${memberVO.ESNTL_ID}"/>
                    </form:form>
				</div>
				<!-- //content 끝 -->
	        </div>
	    <!-- //container 끝 -->
	    <!-- footer 시작 -->
	    <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
	    <!-- //footer 끝 -->
	</div>
	<!-- //전체 레이어 끝 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>	
<script>
	$(document).ready(function(){
		$("#EMPLYR_ID").blur(function(){
			//Ajax로 API서버와 통신
			var input_id_value = $(this).val();
			var urlvar = "<c:url value='/com/member/restViewMember.do?EMPLYR_ID=" +input_id_value +"'/>";
			//alert(urlvar);
			$.ajax({
				type:'get',
				url:urlvar,
				success:function(result){
					if(result == 1){//조건: 중복 아이디가 존재
						//전송 버튼 비활성화
						alert("아이디가 중복됩니다.");
					}else{
						//전송 버튼 활성화
						alert("사용 가능한 아이디입니다.");

					}
				},
				error:function(){
					alert("RestAPI서버가 작동하지 않습니다.");
				}
			});
		});
		$("#insert_member").click(function(){
			//유효성 검사(아래 if문)
			if($("#EMPLYR_ID").val() == '' ){
				alert("아이디는 필수입니다.");
				$("#EMPLYR_ID").focus();
				return;
			}
			if($("#PASSWORD").val() == '' ){
				alert("암호는 필수입니다.");
				$("#PASSWORD").focus();
				return;
			}
			if($("#PASSWORD_HINT").val() == '' ){
				alert("암호 힌트는 필수입니다.");
				$("#PASSWORD_HINT").focus();
				return;
			}
			if($("#PASSWORD_CNSR").val() == '' ){
				alert("암호 정답은 필수입니다.");
				$("#PASSWORD_CNSR").focus();
				return;
			}
			$("#insertForm").attr("action", "<c:url value = '/com/member/insertMember.do'/>");
			$("#insertForm").submit();
		});		
	});
</script>
</body>
</html>