<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

	<div class="border-bottom m-1">
		<div class="row p-1">
			<div class="col-auto">
				<div class="row reply-writer">
					<div class="col-1"><i class="bi bi-person-circle text-muted icon"></i></div>
					<div class="col ms-2 align-self-center">
						<div class="name">김자바</div>
						<div class="date">2025-01-01</div>
					</div>
				</div>
			</div>
			<div class="col align-self-center text-end">
				<span class="reply-dropdown"><i class="bi bi-three-dots-vertical"></i></span>
				<div class="reply-menu d-none">
						<div class="deleteReplyAnswer reply-menu-item" data-replyNum="23" data-parentNum="13">삭제</div>
						<div class="notifyReplyAnswer reply-menu-item">신고</div>
				</div>
			</div>
		</div>

		<div class="p-2">
			내용 입니다.
		</div>
	</div>

