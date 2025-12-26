<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">
.w-px-100 { width: 100px; }
.h-px-100 { height: 100px; }
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="container">
		<div class="body-container row justify-content-center">
			<div class="col-md-10 my-3 p-3">

				<div class="body-title">
					<h3><i class="bi bi-person-square"></i> ${mode=="update" ? "정보수정":"회원가입"} </h3>
				</div>
				
				<div class="body-main">
					
					<form name="memberForm" method="post" enctype="multipart/form-data">
					
						<div class="d-flex align-items-center g-3 pb-4 border-bottom">
							<img src="${pageContext.request.contextPath}/dist/images/user.png" class="img-avatar d-block w-px-100 h-px-100 rounded">
							<div class="ms-3">
								<label for="selectFile" class="btn btn-primary me-2 mb-3" tabindex="0" title="사진 업로드">
									<span class="d-none d-sm-block">사진 업로드</span>
									<i class="bi bi-upload d-block d-sm-none"></i>
									<input type="file" name="selectFile" id="selectFile" hidden="" accept="image/png, image/jpeg">
								</label>
								<button type="button" class="btn-photo-init btn btn-light mb-3" title="초기화">
									<span class="d-none d-sm-block">초기화</span>
									<i class="bi bi-arrow-counterclockwise d-block d-sm-none"></i>
								</button>
								<div>Allowed JPG, GIF or PNG. Max size of 800K</div>
							</div>
						</div>
					
						<div class="row g-2 pt-4">
							<label for="userId" class="col-md-2 form-label fw-medium pt-1">아이디</label>
							<div class="col-md-10 wrap-userId">
								<div class="row g-2">
									<div class="col-md-6">
										<input class="form-control" type="text" id="userId" name="userId" value="${dto.userId}"
											${mode=="update" ? "readonly ":""} autofocus>									
									</div>
									<div class="col-md-6">
										<c:if test="${mode=='account'}">
											<button type="button" class="btn btn-light" onclick="userIdCheck();">아이디중복검사</button>
										</c:if>
									</div>
								</div>
								<c:if test="${mode=='account'}">
									<small class="form-control-plaintext help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
								</c:if>
							</div>
						
							<label for="userPwd" class="col-md-2 form-label fw-medium pt-1">패스워드</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-6">
										<input class="form-control" type="password" id="userPwd" name="userPwd" autocomplete="off" >
									</div>
								</div>
								<small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자를 포함 합니다.</small>
							</div>
	
							<label for="userPwd2" class="col-md-2 form-label fw-medium pt-1">패스워드확인</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-6">
										<input class="form-control" type="password" id="userPwd2" name="userPwd2" autocomplete="off" >
									</div>
								</div>
								<small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
							</div>
	
							<label for="userName" class="col-md-2 form-label fw-medium pt-1">이 름</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-6">
										<input class="form-control" type="text" id="userName" name="userName" value="${dto.userName}"
										${mode=="update" ? "readonly ":""}>
									</div>
								</div>
							</div>
	
							<label for="birth" class="col-md-2 form-label fw-medium pt-1">생년월일</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-6">
										<input class="form-control" type="date" id="birth" name="birth" value="${dto.birth}"
										${mode=="update" ? "readonly ":""}>
									</div>
								</div>
							</div>
	
							<label for="selectEmail" class="col-md-2 form-label fw-medium pt-1">이메일</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-3">
										<select name="selectEmail" id="selectEmail" class="form-select" onchange="changeEmail();">
											<option value="">선 택</option>
											<option value="naver.com" ${dto.email2=="naver.com" ? "selected" : ""}>네이버 메일</option>
											<option value="gmail.com" ${dto.email2=="gmail.com" ? "selected" : ""}>지 메일</option>
											<option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected" : ""}>한 메일</option>
											<option value="outlook.com" ${dto.email2=="outlook.com" ? "selected" : ""}>마이크로소프트</option>
											<option value="icloud.com" ${dto.email2=="icloud.com" ? "selected" : ""}>애플</option>
											<option value="direct">직접입력</option>
										</select>
									</div>
									<div class="col input-group">
										<input type="text" name="email1" class="form-control" maxlength="30" value="${dto.email1}" >
							    		<label class="input-group-text p-1" style="border: none; background: none;">@</label>
										<input type="text" name="email2" class="form-control" maxlength="30" value="${dto.email2}" readonly>
									</div>
								</div>
							</div>
	
							<label for="receiveEmail" class="col-md-2 form-label fw-medium pt-1">메일 수신</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-6">
										<div class="form-check pt-1">
											<input class="form-check-input" type="checkbox" name="receiveEmail" id="receiveEmail"
												value="1" ${empty dto || dto.receiveEmail == 1 ? "checked":""}>
											<label class="form-check-label" for="receiveEmail"> 동의</label>
										</div>
									</div>
								</div>
							</div>

							<label for="tel" class="col-md-2 form-label fw-medium pt-1">전화번호</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-6">
										<input class="form-control" type="text" id="tel" name="tel" value="${dto.tel}">
									</div>
								</div>
							</div>
		
							<label for="btn-zip" class="col-md-2 form-label fw-medium pt-1">우편번호</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-6">
										<input class="form-control" type="text" name="zip" id="zip" value="${dto.zip}" readonly tabindex="-1">
									</div>
									<div class="col-md-6">
										<button type="button" class="btn btn-light" id="btn-zip" onclick="daumPostcode();">우편번호검사</button>
									</div>
								</div>
							</div>

							<label for="addr2" class="col-md-2 form-label fw-medium pt-1">주 소</label>
							<div class="col-md-10">
								<div class="row g-2">
									<div class="col-md-12">
										<input class="form-control" type="text" name="addr1" id="addr1" value="${dto.addr1}" 
											readonly placeholder="기본주소" tabindex="-1">
									</div>
									<div class="col-md-12">
										<input class="form-control" type="text" name="addr2" id="addr2" value="${dto.addr2}"
											placeholder="상세주소">
									</div>
								</div>
							</div>
	
							<label for="agree" class="col-md-2 form-label fw-medium pt-1">약관 동의</label>
							<div class="col-md-10">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" name="agree" id="agree"
											checked
											onchange="form.sendButton.disabled = !checked">
									<label class="form-check-label" for="agree">
										<a href="#" class="text-primary border-link-right">이용약관</a>에 동의합니다.
									</label>
								</div>
							</div>

							<div class="col-md-12 text-center">
								<button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();"> ${mode=="update"?"정보수정":"회원가입"} <i class="bi bi-check2"></i></button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/';"> ${mode=="update"?"수정취소":"가입취소"} <i class="bi bi-x"></i></button>
								<input type="hidden" name="userIdValid" id="userIdValid" value="false">
							</div>

							<div class="col-md-12">
								<p class="form-control-plaintext text-center">${message}</p>
							</div>
						</div>

					</form>
					
				</div>

			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
window.addEventListener('DOMContentLoaded', ev => {
	let img = '${dto.profile_photo}';

	const avatarEL = document.querySelector('.img-avatar');
	const inputEL = document.querySelector('form[name=memberForm] input[name=selectFile]');
	const btnEL = document.querySelector('form[name=memberForm] .btn-photo-init');
	
	let avatar;
	if( img ) {
		avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
		avatarEL.src = avatar;
	}
	
	const maxSize = 800 * 1024;
	inputEL.addEventListener('change', ev => {
		let file = ev.target.files[0];
		if(! file) {
			if( img ) {
				avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
			} else {
				avatar = '${pageContext.request.contextPath}/dist/images/user.png';
			}
			avatarEL.src = avatar;
			
			return;
		}
		
		if(file.size > maxSize || ! file.type.match('image.*')) {
			inputEL.focus();
			return;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			avatarEL.src = e.target.result;
		}
		reader.readAsDataURL(file);			
	});
	
	btnEL.addEventListener('click', ev => {
		if( img ) {
			avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
			avatarEL.src = avatar;
		} else {
			avatar = '${pageContext.request.contextPath}/dist/images/user.png';
			inputEL.value = '';
			avatarEL.src = avatar;
		}
	});
});

function isValidDateString(dateString) {
	try {
		const date = new Date(dateString);
		const [year, month, day] = dateString.split("-").map(Number);
		
		return date instanceof Date && !isNaN(date) && date.getDate() === day;
	} catch(e) {
		return false;
	}
}

function memberOk() {
	const f = document.memberForm;
	let str, p;

	p = /^[a-z][a-z0-9_]{4,9}$/i;
	str = f.userId.value;
	if( ! p.test(str) ) { 
		alert('아이디를 다시 입력 하세요. ');
		f.userId.focus();
		return;
	}

/*	
	let mode = '${mode}';
	if( mode === 'account' && f.userIdValid.value === 'false' ) {
		str = '아이디 중복 검사가 실행되지 않았습니다.';
		$('.wrap-userId').find('.help-block').html(str);
		f.userId.focus();
		return;
	}
*/

	p =/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
	str = f.userPwd.value;
	if( ! p.test(str) ) { 
		alert('패스워드를 다시 입력 하세요. ');
		f.userPwd.focus();
		return;
	}

	if( str !== f.userPwd2.value ) {
        alert('패스워드가 일치하지 않습니다. ');
        f.userPwd.focus();
        return;
	}
	
	p = /^[가-힣]{2,5}$/;
    str = f.userName.value;
    if( ! p.test(str) ) {
        alert('이름을 다시 입력하세요. ');
        f.userName.focus();
        return;
    }

    str = f.birth.value;
    if( ! isValidDateString(str) ) {
        alert('생년월일를 입력하세요. ');
        f.birth.focus();
        return;
    }
    
    str = f.email1.value.trim();
    if( ! str ) {
        alert('이메일을 입력하세요. ');
        f.email1.focus();
        return;
    }

    str = f.email2.value.trim();
    if( ! str ) {
        alert('이메일을 입력하세요. ');
        f.email2.focus();
        return;
    }
    
    p = /^(010)-?\d{4}-?\d{4}$/;    
    str = f.tel.value;
    if( ! p.test(str) ) {
        alert('전화번호를 입력하세요. ');
        f.tel.focus();
        return;
    }

    f.action = '${pageContext.request.contextPath}/member/${mode}';
    f.submit();
}

function userIdCheck() {
	// 아이디 중복 검사

}

function changeEmail() {
    const f = document.memberForm;
	    
    let str = f.selectEmail.value;
    if( str !== 'direct' ) {
        f.email2.value = str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value = '';
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

/*
window.addEventListener('DOMContentLoaded', () => {
	const dateELS = document.querySelectorAll('form input[type=date]');
	dateELS.forEach( inputEL => inputEL.addEventListener('keydown', e => e.preventDefault()) );
});
*/
</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                let fullAddr = ''; // 최종 주소 변수
                let extraAddr = ''; // 조합형 주소 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택한 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택한 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일 때 조합
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소 작성
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode; // 5자리 우편번호
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>