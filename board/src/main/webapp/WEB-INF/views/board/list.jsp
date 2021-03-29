<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="card shadow mb-4">

	<div class="card-header py-3">
		<h3 class="m-1 text-dark">
			커뮤니티
			<button type="button" id='regBtn' class="btn btn-primary float-right">새 글 등록</button>
		</h3>
	</div>
	<!-- 헤드라인 -->


	<div class="card-body">
		<div class="table-responsive">
			<table class="table" width="100%" cellspacing="0">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var='board' items='${list}'>
						<tr>
							<td>${board.bno}</td>
							<td>
								<a class='move' href='${board.bno}'>
									${board.title} <span class="badge badge-primary badge-pill">${board.replyCnt}</span>
								</a>
							</td>
							<td>${board.writer}</td>
							<td>
								<fmt:formatDate value='${board.regdate}' pattern='yyyy-MM-dd' />
							</td>
							<td>
								<fmt:formatDate value='${board.updateDate}' pattern='yyyy-MM-dd' />
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 테이블 바디-->


		<div class="row-vw d-flex">

			<form id='searchForm' action='/board/list' method='get' class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search mr-auto">
				<div class="input-group">
					<select class="form-control bg-light border-0 small" name='type'>
						<option value='' ${criteria.type == null ? 'selected' : ''}>--</option>
						<option value='T' ${criteria.type eq 'T' ? 'selected' : ''}>제목</option>
						<option value='C' ${criteria.type eq 'C' ? 'selected' : ''}>내용</option>
						<option value='W' ${criteria.type eq 'W' ? 'selected' : ''}>작성자</option>
						<option value='TC' ${criteria.type eq 'TC' ? 'selected' : ''}>제목+내용</option>
						<option value='TW' ${criteria.type eq 'TW' ? 'selected' : ''}>제목+작성자</option>
						<option value='TWC' ${criteria.type eq 'TWC' ? 'selected' : ''}>제목+내용+작성자</option>
					</select>
					<input class="form-control bg-light border-0 small" type='text' name='keyword' value='${criteria.keyword}' />
					<input class="form-control bg-light border-0 small" type='hidden' name='pageNum' value='${criteria.pageNum}' />
					<input class="form-control bg-light border-0 small" type='hidden' name='amount' value='${criteria.amount}' />

					<div class="input-group-append">
						<button class="btn btn-primary">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form>
			<br>

			<ul class="pagination mr-4">
				<c:if test='${pageMaker.prev}'>
					<li class="paginate_button page-item previous" id="dataTable_previous"><a aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"
							href='${pageMaker.startPage - 1}'>이전</a></li>
				</c:if>

				<c:forEach var='num' begin='${pageMaker.startPage}' end='${pageMaker.endPage}'>
					<li class='paginate_button page-item  ${criteria.pageNum == num ? "active" : "" }' id="dataTable_previous"><a aria-controls="dataTable" data-dt-idx="0" tabindex="0"
							class="page-link" href='${num}'>${num}</a></li>
				</c:forEach>

				<c:if test='${pageMaker.next}'>
					<li class="paginate_button page-item next" id="dataTable_previous"><a aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"
							href='${pageMaker.endPage + 1}'>다음</a></li>
				</c:if>
			</ul>

		</div>
		<!-- 검색창/페이징 -->

		<div class="modal" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">알림창</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">처리가 완료되었습니다.</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
					</div>

				</div>
			</div>
		</div>
		<!-- 모달창 -->

		<form id='actionForm' action="/board/list" method='get'>
			<input type='hidden' name='pageNum' value='${criteria.pageNum}'>
			<input type='hidden' name='amount' value='${criteria.amount}'>
			<input type='hidden' name='type' value='${criteria.type}'>
			<input type='hidden' name='keyword' value='${criteria.keyword}'>
		</form>
		<!-- 전송 데이터 -->
	</div>
</div>

<script>
	$(document).ready(function() {

		var result = '${result}';
		checkModal(result);

		function checkModal(result) {

			if (result === '')
				return;
			if (parseInt(result) > 0)
				$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.");

			$("#myModal").modal("show");
		}
		//EL로 넘어간 값들은 문자열
		//게시글 등록 시 모달창 발생

		$("#regBtn").on("click", function() {
			self.location = "/board/register";
		});
		//전달해야할 값이 없으니 self.location 이용
		//새 글 등록

		var actionForm = $("#actionForm");

		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
		//게시글 제목을 누르면 게시글 번호를 추출
		//번호에 대한 input을 만들어 actionForm에 추가
		//게시글 조회 페이지로 값을 보내고 요청

		$(".page-item a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		//페이지 버튼을 누르면 페이지 값을 추출
		//페이지값에 대한 input의 값을 actionForm에 추가

		var searchForm = $("#searchForm");

		$("#searchForm button").on("click", function(e) {
			e.preventDefault();

			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요.");
				return false;
			}
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요.");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");
			searchForm.submit();
		});
		//타입과 키워드를 입력하지 않았을 때 알림창
		//검색 시 페이지 값은 1로 변경
	});
</script>


<%@include file="../includes/footer.jsp"%>
