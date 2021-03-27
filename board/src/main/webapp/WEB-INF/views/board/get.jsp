<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<div class="card shadow mb-4">

	<div class="card-header py-3">
		<h3 class="m-1 text-dark">해당 글 조회</h3>
	</div>
	<!-- 헤드라인 -->


	<div class="card-body">
		<div class='form-group'>
			<label>번호</label>
			<input class='form-control' name='bno' value='${board.bno}' readonly='readonly'>
		</div>

		<div class='form-group'>
			<label>제목</label>
			<input class='form-control' name='title' value='${board.title}' readonly='readonly'>
		</div>

		<div class='form-group'>
			<label>내용</label>
			<textarea class='form-control' rows='3' name='content' readonly='readonly'>${board.content}</textarea>
		</div>

		<div class='form-group'>
			<label>작성자</label>
			<input class='form-control' name='writer' value='${board.writer}' readonly='readonly'>
		</div>

		<sec:authentication property="principal" var="pinfo" />
		<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq board.writer}">
				<button type='button' data-oper='modify' class="btn btn-success">수정</button>
			</c:if>
		</sec:authorize>

		<button type='button' data-oper='list' class="btn btn-primary">리스트</button>

		<form id='operForm' action='/board/modify' method='get'>
			<input type='hidden' id='bno' name='bno' value='${board.bno}'>
			<input type='hidden' name='pageNum' value='${cri.pageNum }'>
			<input type='hidden' name='amount' value='${cri.amount }'>
			<input type='hidden' name='keyword' value='${cri.keyword }'>
			<input type='hidden' name='type' value='${cri.type }"/>'>
		</form>
	</div>
	<!-- 테이블 바디-->
</div>
<!-- 게시글 -->


<div class="card shadow mb-4">

	<div class="card-header py-3">
		<i class='fa fa-comments fa-fw'></i> 댓글
		<sec:authorize access="isAuthenticated()">
			<button id='addReplyBtn' class='btn btn btn-secondary btn-xs pull-right'>새 댓글 작성</button>
		</sec:authorize>
	</div>

	<div class="card-body">
		<ul class='chat'></ul>
	</div>

	<div class='card-footer'></div>
</div>
<!-- 댓글 -->


<div class="modal" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">댓글 작성하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class='form-group'>
					<label>댓글</label>
					<input class='form-control' name='reply' value='reply'>
				</div>
				<div class='form-group'>
					<label>작성자</label>
					<input class='form-control' name='replyer' value='replyer'>
				</div>
				<div class='form-group'>
					<label>날짜</label>
					<input class='form-control' name='replyDate' value='2020-01-14 14:23'>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 모달창 -->


<script type="text/javascript" src="../resources/js/reply.js"></script>
<!-- reply ajax funtion-->
<!-- 통신하여 값을 비동기적으로 얻어내는 -->

<script>
	$(document).ready(function (){
		
		var bnoValue = '<c:out value="${board.bno}"/>'; 
		var replyUL = $(".chat");   //댓글 태그
		
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno : bnoValue, page : page || 1}, function(replyCnt, list){
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				//마지막 페이지로 이동
				
				if(list == null || list.length == 0){
					return;
				}
				//댓글이 없는 경우 함수 종료
				
				var str = "";
				
				for(var i = 0; i < list.length; i++){
					str += "<li class='' data-rno='" + list[i].rno + "'>";
					str += "<div><div class='header'>";
					str += "<strong class='primary-font'>[" + list[i].rno + "]" + list[i].replyer + "</strong>";
 					str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>" 
					str += "<p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);   //댓글 추가
				showReplyPage(replyCnt);   //페이징
			});
		}//end function
		
		var pageNum = 1;   		
		var replyPageFooter = $(".card-footer");   //페이지 태그
		
		function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt)
				endNum = Math.ceil(replyCnt/10.0);
			
			if(endNum * 10 < replyCnt)
				next = true;
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev)
				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>이전</a></li>";
				
			for(var i = startNum; i <= endNum; i++){
				var active = pageNum == i ? "active" : "";
				str += "<li class='page-item" + active + "'><a class='page-link' href= '" + i + "'>" + i + "</a></li>";
			}
			
			if(next)
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>다음</a></li>";
			
			str += "</ul></div>";			
			replyPageFooter.html(str);
		}
		
		
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			var targetPageNum = $(this).attr("href");
			pageNum = targetPageNum;
			showList(pageNum);
		});
		// 페이지 아이콘을 누르면 숫자가 pageNum에 저장 (이벤트 위임)
		
		
	    var modal = $(".modal");
	    var modalInputReply = modal.find("input[name='reply']");
	    var modalInputReplyer = modal.find("input[name='replyer']");
	    var modalInputReplyDate = modal.find("input[name='replyDate']");
	    
	    var modalModBtn = $("#modalModBtn");
	    var modalRemoveBtn = $("#modalRemoveBtn");
	    var modalRegisterBtn = $("#modalRegisterBtn");
	   
	    var replyer = null;	    
	    <sec:authorize access="isAuthenticated()">
	    	replyer = '<sec:authentication property="principal.username"/>';   
	    </sec:authorize>
	 
	    var csrfHeaderName ="${_csrf.headerName}"; 
	    var csrfTokenValue="${_csrf.token}";
	    
	    
	    $(document).ajaxSend(function(e, xhr, options) { 
	        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
	    });
	        
	    
	    $("#addReplyBtn").on("click", function(e){
	    	modal.find("input").val("");
	    	modal.find("input[name = 'replyer']").val(replyer);
	    	modal.find("input[name = 'replyer']").attr("readonly","readonly");
	    	modalInputReplyDate.closest("div").hide();
	    	
	    	modal.find("button[id != 'modalCloseBtn']").hide();
	    	modalRegisterBtn.show();
	    	
	    	$(".modal").modal("show"); 
	    });
	    // 새 댓글 버튼을 눌렀을 때
	    
	    	
	    modalRegisterBtn.on("click", function(e){
	    		
	    	var reply = {
	    			bno : bnoValue,	// mapper.insert 검색 시 bno가 필요
	    			reply : modalInputReply.val(),
	    			replyer : modalInputReplyer.val(),
	   		};
	    		
	   		replyService.add(reply, function(result){
	    		alert(result);	    			
	    		modal.find("input").val("");
	    		modal.modal("hide");
	    		showList(-1);
	    	});
	    });
	    // 등록 버튼을 눌렀을 때
	    
	    
	    $("#modalCloseBtn").on("click", function(e){
	    	modal.modal('hide');
	    });
	    // 닫기 버튼을 눌렀을 때	
	    
	    
	    $(".chat").on("click", "li", function(e){
	    			
	    	var rno = $(this).data("rno");
	    			
	    	replyService.get(rno, function(reply){
	    				
	    		modalInputReply.val(reply.reply);
	        	modalInputReplyer.val(reply.replyer);	
	      		modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
	    		        
	    		modal.find("button[id != 'modalCloseBtn']").hide();
	    		modalModBtn.show();
	    		modalRemoveBtn.show();
	    		        
	    		$(".modal").modal("show");
	    	});
	    });
	    // 댓글 클릭 시 (이벤트 위임)
	    
	    
	    modalModBtn.on("click", function(e){
	    	
	    	var originalReplyer = modalInputReplyer.val();
	    	var reply = {rno : modal.data("rno"),
						reply : modalInputReply.val(),
						replyer : originalReplyer};
	    				
	    	if(!replyer){
	   			alert("로그인후 수정이 가능합니다.");
	   		 	modal.modal("hide");
	   		 	return;
		   	}

	   		if(replyer != originalReplyer){	   	 
	   			alert("자신이 작성한 댓글만 수정이 가능합니다.");
	   		 	modal.modal("hide");
	   		 	return;
	   		}
	   		
	    	replyService.update(reply, function(result){
	    		alert(result);
	    		modal.modal("hide");
	    		showList(pageNum);
	    	});
	    });
	    //댓글 수정 클릭 시
	    
	    
	    modalRemoveBtn.on("click", function(e){
	    	
	    	var rno = modal.data("rno");
	    	
 	    	if(!replyer){
	    		alert("로그인 후 삭제가 가능합니다.");
	    		modal.modal("hide");
	    		return;
	    	}
	    	
	    	var originalReplyer = modalInputReplyer.val();
	    	
	    	if(replyer != originalReplyer){
	    		alert("자신이 작성한 댓글만 삭제가능합니다.");
	    		modal.modal("hide");
	    		return;
	    	} 
	    	
	    	replyService.remove(rno, originalReplyer, function(result){
	    		alert(result);
	    		modal.modal("hide");
	    		showList(pageNum);
	    	});
	    });
	    //댓글 삭제 클릭 시
	    
	    
	});
</script>


<script>
	$(document).ready(function() {	
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
	});
	//수정 버튼 클릭 시 bno,criteria을 전송
	//리스트 버튼 클릭 시 criteria만을 전송
	
</script>

<%@include file="../includes/footer.jsp"%>
