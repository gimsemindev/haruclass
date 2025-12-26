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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
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
					<h3><i class="bi bi-app"></i> 자유 게시판 </h3>
				</div>
				
				<div class="body-main">

					<table class="table board-article">
						<thead>
							<tr>
								<td colspan="2" align="center">
									<c:out value="${dto.subject}"></c:out>
								</td>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td width="50%">
									이름 : ${dto.userName}
								</td>
								<td align="right">
									${dto.reg_date} | 조회 ${dto.hitCount}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" valign="top" height="200" style="border-bottom: none;">
									${dto.content}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" class="text-center p-3">
									<button type="button" class="btn btn-outline-primary btnSendBoardLike" title="좋아요"><i class="bi bi-hand-thumbs-up"></i>&nbsp;&nbsp;<span id="likeCount">3</span></button>
								</td>
							</tr>
													
							<tr>
								<td colspan="2">
									이전글 : 
	                                <c:if test="${not empty prevDto}" >
	                                	<a href="${pageContext.request.contextPath}/bbs/article?${query}&num=${prevDto.num}"><c:out value="${prevDto.subject}" /></a>
	                                </c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									다음글 :
	                                <c:if test="${not empty nextDto}" >
	                                	<a href="${pageContext.request.contextPath}/bbs/article?${query}&num=${nextDto.num}"><c:out value="${nextDto.subject}" /></a>
	                                </c:if>	
								</td>
							</tr>
						</tbody>
					</table>
					
					<table class="table table-borderless mb-2">
						<tr>
							<td width="50%">
								<c:choose>
									<c:when test="${sessionScope.member.userId == dto.userId}">
									<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/bbs/update?num=${dto.num}&page=${page}';">수정</button>
									</c:when>
									<c:otherwise>
									<button type="button" class="btn btn-light" disabled>수정</button>
									</c:otherwise>
								</c:choose>
								
					    		<c:choose>
									<c:when test="${sessionScope.member.userId == dto.userId || sessionScope.member.userLevel >= 51}">
									<button type="button" class="btn btn-light" onclick="deleteOk();">삭제</button>
									</c:when>
									<c:otherwise>
									<button type="button" class="btn btn-light" disabled>삭제</button>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="text-end">
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/bbs/list?${query}';">리스트</button>
							</td>
						</tr>
					</table>

					<div class="reply">
						<form name="replyForm" method="post">
							<div class="form-header">
								<span class="bold">댓글</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가해 주세요.</span>
							</div>
							
							<table class="table table-borderless reply-form">
								<tr>
									<td>
										<textarea class="form-control" name="content"></textarea>
									</td>
								</tr>
								<tr>
								   <td align="right">
										<button type="button" class="btn btn-light btnSendReply">댓글 등록</button>
									</td>
								 </tr>
							</table>
						</form>
						
						<div id="listReply"></div>
					</div>

				</div>
			</div>
		</div>
	</div>
</main>

<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userLevel >= 51}">
	<script type="text/javascript">
		function deleteOk() {
			if(confirm('게시글을 삭제하시겠습니까?')) {
				let params = 'num=${dto.num}&${query}';
				let url = '${pageContext.request.contextPath}/bbs/delete?' + params;
				location.href = url;
			}
			
		}
	</script>
</c:if>


<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>