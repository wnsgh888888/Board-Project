<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시판</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			
			
			<div class="panel-heading">
				리스트<button id='regBtn' type='button' class='btn btn-xs pull-right'>새 글 등록</button>
			</div> <!-- 제목 -->
			
			
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>

					<c:forEach var='board' items='${list}'>
						<tr>
							<td>${board.bno}</td>
							<td>
								<a class='move' href='${board.bno}'>
								${board.title} [${board.replyCnt}]
								</a>
							</td>
							<td>${board.writer}</td>
							<td><fmt:formatDate value='${board.regdate}' pattern='yyyy-MM-dd' /></td>
							<td><fmt:formatDate value='${board.updateDate}' pattern='yyyy-MM-dd' /></td>
						</tr>
					</c:forEach>
				</table><!-- 테이블 -->
				
				
				<div class="row">
					<div class="col-lg-12">
						<form id='searchForm' action='/board3/list' method='get'>
							<select name='type'>
								<option value='' ${criteria.type == null ? 'selected' : ''} >--</option>
								<option value='T' ${criteria.type eq 'T' ? 'selected' : ''} >제목</option>
								<option value='C' ${criteria.type eq 'C' ? 'selected' : ''} >내용</option>
								<option value='W' ${criteria.type eq 'W' ? 'selected' : ''} >작성자</option>
								<option value='TC' ${criteria.type eq 'TC' ? 'selected' : ''} >제목+내용</option>
								<option value='TW' ${criteria.type eq 'TW' ? 'selected' : ''} >제목+작성자</option>
								<option value='TWC' ${criteria.type eq 'TWC' ? 'selected' : ''} >제목+내용+작성자</option>
							</select>
							
							<input type='text' name='keyword' value='${criteria.keyword}'/>
							<input type='hidden' name='pageNum' value='<c:out value="${criteria.pageNum}"/>'/>
							<input type='hidden' name='amount' value='<c:out value="${criteria.amount}"/>'/>
							<button class='btn btn-default'>검색</button>
						</form>
					</div>
				</div><!-- 검색창 -->
				<!-- 키워드를 입력해야하기 때문에 form태그를 따로 만듬 -->
				<!-- 공통폼과 같은 criteria를 받음 -->
				
				<div class='pull-right'>
					<ul class="pagination">
						<c:if test='${pageMaker.prev}'>
						<li class='paginate_button previous'>
							<a href='${pageMaker.startPage - 1}'>이전</a>	
						</li>
						</c:if>
						
						<c:forEach var='num' begin='${pageMaker.startPage}' end='${pageMaker.endPage}'>
						<li class='paginate_button ${criteria.pageNum == num ? "active" : "" }'>
							<a href='${num}'>${num}</a>
						</li>
						</c:forEach>
						
						<c:if test='${pageMaker.next}'>
						<li class='paginate_button next'>
							<a href='${pageMaker.endPage + 1}'>다음</a>	
						</li>
						</c:if>
					</ul>
				</div><!-- 페이지 버튼 -->
				
				
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">알림창</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div><!-- 모달창 -->
			
			
				<form id='actionForm' action="/board3/list" method='get'>
					<input type='hidden' name='pageNum' value='${criteria.pageNum}'>
					<input type='hidden' name='amount' value='${criteria.amount}'>
					<input type='hidden' name='type' value='${criteria.type}'>
					<input type='hidden' name='keyword' value='${criteria.keyword}'>
				</form><!-- 공통 폼태그 -->
			
										
			</div><!-- 리스트 페이지 -->	
		</div><!-- /.panel -->
	</div><!-- /.col-lg-12 -->
</div><!-- /.row -->

<script>
	$(document).ready(function(){	
		
		var result = '${result}';				
		checkModal(result);		
		
		function checkModal(result){
			if(result === '')
				return;
			if(parseInt(result) > 0)
				$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.");			
			$("#myModal").modal("show");			
		}	
		//EL로 넘어간 값들은 문자열
		//게시글 등록 시 모달창 발생
		
		
		$("#regBtn").on("click",function(){
				self.location = "/board3/register";
		});	
		//새 글 등록 요청
		
		
		var actionForm = $("#actionForm");

		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action","/board3/get");
			actionForm.submit();
		});
		//게시글 제목을 누르면 게시글 번호를 추출
		//번호에 대한 input을 만들어 actionForm에 추가
		//게시글 조회 페이지로 값을 보내고 요청
		
		
		$(".paginate_button a").on("click",function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		//페이지 버튼을 누르면 페이지 값을 추출
		//페이지값에 대한 input의 값을 actionForm에 추가
		
		
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click",function(e){
			e.preventDefault();
			
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요.");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
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