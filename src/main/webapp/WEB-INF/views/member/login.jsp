<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="./../includes/header.jsp" %>
<%@include file="./../includes/menuBar.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>

<style>

   html{

   }
   button{
         width: 300px;
         height:30px;
   }
   
input[type=text] {
    width:400px;
    height: 54px;
    padding: 0 19px;
    border: 1px solid #ccc;
    border-radius: 3px;
    background-color: #fff;
    font-size: 14px;
    line-height: 20px;
    outline: none;
}

input[type=password] {
    width:400px;
    height: 54px;
    padding: 0 19px;
    border: 1px solid #ccc;
    border-radius: 3px;
    background-color: #fff;
    font-size: 14px;
    line-height: 20px;
    outline: none;
}

button, input[type="submit"] {
	background-color: #8FA691;
	border: 1px solid #8FA691;
	border-radius: 5px;
	margin: 0;
	outline: none;
	color: #FFFFFF;
	padding: 15px 180px;
	cursor: pointer;
	margin-bottom: 5px;
}
        
   
   a {
   text-decoration: none;
   color: black;
   
   }
   
   #fb-root {
   	text-align:center;
   }
   
   .findIdPwd {
   	position: absolute;
   	right: 0%;
   }
   
   .container {
       width:400px;
       position: relative;
   }
   
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
</head>


<body>

	<div class = "container" align="center">
	<br><br><br>
		<h3>로그인</h3>
		<br>
		<form action="/member/login"  method="post">
			<input type="text" name="emailAccount" id="emailAccount" size="20" placeholder="아이디를 입력해주세요."><br>
			<input type="password" name="pwd" id="pwd" size="20"  placeholder="비밀번호를 입력해주세요."><br><br>
	
			<a class = "findIdPwd" href="/member/findIdPwd">아이디/비밀번호 찾기</a><br><br>
			<input type="submit" value="로그인"><br> <br>
		</form>
		
		<!-- 카카오로 로그인 -->
		<a href="https://kauth.kakao.com/oauth/authorize?client_id=01b574850137dfee5c295348e0be136f&redirect_uri=http://localhost/member/kakaoLogin&response_type=code">
			<img alt="" src="/resources/images/kakao-login-btn.png">
		</a><br>
		
		<!-- 네이버로 로그인 -->
		<div id="naverIdLogin"></div>
		
		<!-- 구글 로그인 -->
		<!-- <div class="g-signin2" data-onsuccess="onSignIn"></div> -->
		<!-- <img alt="" style="height:55px;" src="/resources/images/google-login-btn.png"> -->
		<div class="g-signin2" data-onsuccess="onSignIn">
		</div><br>
		

		<input type="hidden" id="result" value="${result }">
	</div>

   <script>
    $(document).ready(function() {
       
        var result = $("#result").val();
        alertResult(result);
        history.replaceState({},null,null)
        
        function alertResult(result){
           if (result ==='' || history.state){
              return;
           }
           alert(result);
        }
        
        /* 네이버로 로그인 버튼 */
        var naverLogin = new naver.LoginWithNaverId(
       		{
       			clientId: "7Uw4MdMci9xWvrvnp_e8",
       			callbackUrl: "http://localhost/member/naverCallback",
       			isPopup: false, /* 팝업을 통한 연동처리 여부 */
       			loginButton: {color: "green", type: 3, height: 48} /* 로그인 버튼의 타입을 지정 */
       		}
       	);
       	
       	/* 설정정보를 초기화하고 연동을 준비 */
       	naverLogin.init();

       		
    });
    
	    /* 구글 로그인 */
	   	function onSignIn(googleUser) {
		  	var profile = googleUser.getBasicProfile();
		  	console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		  	console.log('Name: ' + profile.getName());
		  	console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
		  	
		  	var email = profile.getEmail();
		  	var name = profile.getName();
		  	var googleToken = profile.getId();
	      	console.log("ID Token: " + googleToken);
	      	
	      	$.ajax({
				url : '/member/googleLogin',
				data : {emailAccount : email, memName : name, googleToken : googleToken},
				dataType : 'text',
				type : 'POST',
				success : function(result) {
					if(result == 'success') {
						alert("로그인 되었습니다.");
						window.location.replace("/");
					}else {
						alert("오류가 생겼습니다. 잠시 후 다시 시도해주세요.");
					}
				}
			});	// $.ajax
		 }

   </script>
</body>
</html>