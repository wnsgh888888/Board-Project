<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">해당 글 조회</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">글 입력 폼</div>


			<div class="panel-body">
				<div class='form-group'>
					<label>번호</label> <input class='form-control' name='bno'
						value='<c:out value="${board.bno}"/>' readonly='readonly'>
				</div>

				<div class='form-group'>
					<label>제목</label> <input class='form-control' name='title'
						value='<c:out value="${board.title}"/>' readonly='readonly'>
				</div>

				<div class='form-group'>
					<label>내용</label>
					<textarea class='form-control' rows='3' name='content'
						readonly='readonly'><c:out value="${board.content}" /></textarea>
				</div>

				<div class='form-group'>
					<label>작성자</label> <input class='form-control' name='writer'
						value='<c:out value="${board.writer}"/>' readonly='readonly'>
				</div>
				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.writer}">
					<button data-oper='modify' class='btn btn-default'>수정</button>
				</c:if>
				</sec:authorize>
				
				<button data-oper='list' class='btn btn-default'>리스트</button>

				<form id='operForm' action='/board2/modify' method='get'>
					<input type='hidden' id='bno' name='bno'
						value='<c:out value="${board.bno}"/>'> <input
						type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum }"/>'> <input
						type='hidden' name='amount'
						value='<c:out value="${cri.amount }"/>'> <input
						type='hidden' name='keyword'
						value='<c:out value="${cri.keyword }"/>'> <input
						type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
				</form>				
			</div><!-- body end -->
		</div><!-- panel end -->
	</div>
</div>


<div class='row'>
	<div class='col-lg-12'>
		<div class='panel panel-default'>

			<div class='panel-heading'>
				<i class='fa fa-comments fa-fw'></i> 댓글
				<sec:authorize access="isAuthenticated()">
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>새 댓글 작성</button>
				</sec:authorize>
			</div>

			<div class='panel-body'>
				<ul class='chat'></ul>
			</div>

			<div class='panel-footer'></div>

		</div>
	</div>
</div>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 작성하기</h4>
			</div>
			
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
			
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
        		<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
        		<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
        		<button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
			</div>
		</div>
	</div>
</div><!-- modal end -->


<script type="text/javascript" src="/resources/js/reply2.js"></script>
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
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "<div><div class='header'>";
					str += "<strong class='primary-font'>[" + list[i].rno + "]" + list[i].replyer + "</strong>";
 					str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>" 
					str += "<p>" + list[i].reply + "</p></div></li>";
				}
				
				replyUL.html(str);
				showReplyPage(replyCnt);
			});
		}//end function
		
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
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
			operForm.attr("action", "/board2/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board2/list");
			operForm.submit();
		});
	});
</script>

<%@include file="../includes/footer.jsp"%>
