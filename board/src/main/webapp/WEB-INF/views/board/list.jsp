<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

	<div class="card shadow mb-0">
	
		<div class="card-header py-3">
			<h3 class="m-1 text-dark">
				공지사항
			<button type="button" class="btn btn-primary float-right">새 글 등록</button>
			</h3>
		</div><!-- 헤드라인 -->


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
								<td><a class='move' href='${board.bno}'> ${board.title}
										[${board.replyCnt}] </a></td>
								<td>${board.writer}</td>
								<td><fmt:formatDate value='${board.regdate}'
										pattern='yyyy-MM-dd' /></td>
								<td><fmt:formatDate value='${board.updateDate}'
										pattern='yyyy-MM-dd' /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div><!-- 테이블 바디-->


		<div class="row-vw d-flex">		
		
			<form id='searchForm' action='/board/list' method='get'
				class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search mr-auto">
				<div class="input-group">
					<select class="form-control bg-light border-0 small" name='type'>
						<option value='' ${criteria.type == null ? 'selected' : ''}>--</option>
						<option value='T' ${criteria.type eq 'T' ? 'selected' : ''}>제목</option>
							<option value='C' ${criteria.type eq 'C' ? 'selected' : ''}>내용</option>
						<option value='W' ${criteria.type eq 'W' ? 'selected' : ''}>작성자</option>
						<option value='TC' ${criteria.type eq 'TC' ? 'selected' : ''}>제목+내용</option>
						<option value='TW' ${criteria.type eq 'TW' ? 'selected' : ''}>제목+작성자</option>
						<option value='TWC' ${criteria.type eq 'TWC' ? 'selected' : ''}>제목+내용+작성자</option>
					</select> <input class="form-control bg-light border-0 small" type='text' name='keyword' value='${criteria.keyword}' />
						<input class="form-control bg-light border-0 small" type='hidden' name='pageNum' value='${criteria.pageNum}' />
						<input class="form-control bg-light border-0 small" type='hidden' name='amount' value='${criteria.amount}' />
	
					<div class="input-group-append">
						<button class="btn btn-primary">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form><br><!-- 검색창 -->
		
			<ul class="pagination justify-content-end inline-block mr-4">
				<c:if test='${pageMaker.prev}'>
				<li class='page-item'>
					<a class="page-link" href='${pageMaker.startPage - 1}'>이전</a>	
				</li>
				</c:if>
						
				<c:forEach var='num' begin='${pageMaker.startPage}' end='${pageMaker.endPage}'>
				<li class='page-item' ${criteria.pageNum == num ? "active" : "" }>
					<a class="page-link" href='${num}'>${num}</a>
				</li>
				</c:forEach>
							
				<c:if test='${pageMaker.next}'>
				<li class='paginate_button next'>
					<a class="page-link" href='${pageMaker.endPage + 1}'>다음</a>	
				</li>
				</c:if>
			</ul><!-- 페이징 -->
			
		</div><!-- 검색창/페이징 -->
		
	</div>




<%@include file="../includes/footer.jsp"%>
