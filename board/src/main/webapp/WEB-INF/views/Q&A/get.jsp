<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>


<div class="card shadow mb-4 text-dark">

	<div class="card-header py-2">
		<h5 class="m-1 text-dark">해당 글 조회</h5>
	</div>
	<!-- 헤드라인 -->


	<div class="card-body">
		<div class='form-group'>
			<label class="font-weight-bold">번호</label>
			<input class='form-control' name='bno' value='${board.bno}' readonly='readonly'>
		</div>

		<div class='form-group'>
			<label class="font-weight-bold">제목</label>
			<input class='form-control' name='title' value='${board.title}' readonly='readonly'>
		</div>

		<div class='form-group'>
			<label class="font-weight-bold">내용</label>
			<textarea class='form-control' rows='9' name='content' readonly='readonly'>${board.content}</textarea>
		</div>

		<div class='form-group'>
			<label class="font-weight-bold">작성자</label>
			<input class='form-control' name='writer' value='${board.writer}' readonly='readonly'>
		</div>


		 <sec:authorize access="isAuthenticated()">
			<button id='addReplyBtn' class='btn btn-primary'>댓글 작성</button>
		</sec:authorize>
 
		<button type='button' data-oper='list' class="btn btn-primary">목록</button>
		<sec:authentication property="principal" var="pinfo" />
		<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq board.writer}">
				 <button type='submit' data-oper='remove' class='btn btn-primary float-right'>삭제</button>
				<p class="float-right">&nbsp;</p> 
				<button type='button' data-oper='modify' class="btn btn-primary float-right col-md-offset-1">수정</button>
			</c:if>
		</sec:authorize>


		<form id='operForm' action='/Q&A/modify' method='get'>
			<input type='hidden' id='bno' name='bno' value='${board.bno}'>
			<input type='hidden' id='writer' name='writer' value='${board.writer}'>
			<input type='hidden' name='pageNum' value='${cri.pageNum }'>
			<input type='hidden' name='amount' value='${cri.amount }'>
			<input type='hidden' name='keyword' value='${cri.keyword }'>
			<input type='hidden' name='type' value='${cri.type }"/>'>
			<input type="hidden" id='crsf' name="${_csrf.parameterName}" value="${_csrf.token}"/> 
		</form>
	</div>
	<!-- 테이블 바디-->
</div>
<!-- 게시글 -->


<div class="card shadow mb-4 text-dark">

	<div class="card-body">
		<ul class='list-group list-group-flush chat'></ul>
		<hr>
		<div class='reply-page'></div>
	</div>

</div>
<!-- 댓글 -->

<div class="modal" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title text-dark">댓글 작성하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class='form-group'>
					<label class='font-weight-bold '>댓글</label>
					<input class='form-control' name='reply' value='reply'>
				</div>
				<div class='form-group'>
					<label class='font-weight-bold'>작성자</label>
					<input class='form-control' name='replyer' value='replyer'>
				</div>
				<div class='form-group '>
					<label class='text-dark font-weight-bold'>날짜</label>
					<input class='form-control' name='replyDate' value='2020-01-14 14:23'>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-outline-dark">수정</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-outline-dark">삭제</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-outline-dark">등록</button>
				<button id='modalCloseBtn' type="button" class="btn btn-outline-dark">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- modal end -->


<script type="text/javascript" src="/resources/js/reply3.js"></script>
<script>
	$(document).ready(function (){
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno : bnoValue, page : page || 1},function(replyCnt, list){
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				if(list == null || list.length == 0){
					return;
				}
				
				var str = "";
				
				for(var i = 0; i < list.length; i++){
					str += "<li class='list-group-item' data-rno='" + list[i].rno + "'>";
					str += "<div><div class='header'>";
					str += "<i class='fa fa-comments fa-fw'> </i>"
					str += "<strong class='primary-font'>" + list[i].replyer + "</strong>";
 					str += "<small class='float-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>" 
					str += "<p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);
				showReplyPage(replyCnt);
			});
		}//end function
		
		var pageNum = 1;
		var replyPageFooter = $(".reply-page");
		
		function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt)
				endNum = Math.ceil(replyCnt/10.0);
			
			if(endNum * 10 < replyCnt)
				next = true;
			
			var str = "<ul class='pagination justify-content-center'>";
			
			if(prev)
				str += "<li class='paginate_button page-item previous'><a class='page-link' href='" + (startNum - 1) + "'>이전</a></li>";
				
			for(var i = startNum; i <= endNum; i++){
				var active = pageNum == i ? "active" : "";
				str += "<li class='paginate_button page-item " + active + "'><a class='page-link' href= '" + i + "'>" + i + "</a></li>";
			}
			
			if(next)
				str += "<li class='paginate_button page-item next'><a class='page-link' href='" + (endNum + 1) + "'>다음</a></li>";
			
			str += "</ul></div>";			
			replyPageFooter.html(str);
		}//end function
		
		
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			var targetPageNum = $(this).attr("href");
			pageNum = targetPageNum;
			showList(pageNum);
		});
		
		
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
	    
	    
	    $("#modalCloseBtn").on("click", function(e){
	    	modal.modal('hide');
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
	    
	    	
	    modalRegisterBtn.on("click",function(e){
	    		
	    	var reply = {
	    		reply : modalInputReply.val(),
	    		replyer : modalInputReplyer.val(),
	    		bno : bnoValue	//mapper.insert 검색 시 bno가 필요
	   		};
	    		
	   		replyService.add(reply, function(result){
	    		alert(result);	    			
	    		modal.find("input").val("");
	    		modal.modal("hide");
	    		showList(-1);
	    	});
	    });
	    
	    
	    $(".chat").on("click", "li", function(e){
	    			
	    	var rno = $(this).data("rno");
	    			
	    	replyService.get(rno, function(reply){
	    				
	    		modalInputReply.val(reply.reply);
	        	modalInputReplyer.val(reply.replyer);
	        	modalInputReplyer.val(reply.replyer).attr("readonly", "readonly");
	      		modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
	    		modal.data("rno", reply.rno);
	    		        
	    		modal.find("button[id != 'modalCloseBtn']").hide();
	    		modalModBtn.show();
	    		modalRemoveBtn.show();
	    		        
	    		$(".modal").modal("show");
	    	});
	    });
	    
	    
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
	    });//event end
	});
	
</script>
<script>
	$(document).ready(function() {	
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.find("#crsf").remove();
			operForm.find("#writer").remove();
			operForm.attr("action", "/Q&A/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.find("#writer").remove();
			operForm.find("#crsf").remove();
			operForm.attr("action", "/Q&A/list");
			operForm.submit();
		});
		
 		$("button[data-oper='remove']").on("click", function(e) {
			operForm.attr("method", "post");
			operForm.attr("action", "/Q&A/remove");
			operForm.submit();
		});
		 
	});
	//수정 버튼 클릭 시 bno,criteria을 전송
	//리스트 버튼 클릭 시 criteria만을 전송
</script>
<%@include file="../includes/footer.jsp"%>
