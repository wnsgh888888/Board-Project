var replyService = (function(){

	function getList(param, callback, error){
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
		function(data) {
			if(callback)
				callback(data.replyCnt, data.list);
		}).fail(function(xhr, status, er){
			if(error)
				error();
		});
	}
	// 리스트페이지 데이터 getJSON 요청
	// 매개변수로 URL 자원인 bno,page를 받음 (페이지에 기본값 1)
	// url에 bno/page+.json
	// 성공 콜백함수의 매개변수로 ReplyList,ReplyCnt
	
	
	function add(reply, callback, error){
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result){
				if(callback)
					callback(result);
			},
			error : function(xhr, status, er){
				if(error)
					error(er);
			}
		});
	}
	// 댓글 추가 ajax 요청
	// 매개변수로 Reply을 받음
	// 방식은 post, url자원 없음, 데이터는 Reply, 타입은 json
	// 성공 콜백함수의 매개변수로 result를 받음
	
	
	function get(rno, callback, error){
		$.getJSON("/replies/" + rno + ".json", function(result){
			if(callback)
				callback(result);
		}).fail(function(xhr, status, er){
			if(error)
				error();
		});		
	}
	// 댓글 조회 getJSON 요청
	// 매개변수로 rno를 받음
	// url에 rno+.jsno, 콜백함수엔 result
	 
	
	function update(reply, callback, error){
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result){
				if(callback)
					callback(result);
			},
			error : function(xhr, status, er){
				if(error)
					error(er);
			}
		});
	}
	// 댓글 업데이트 ajax 요청
	// 매개변수로 Reply를 받음
	// 타입은 put, url은 Reply.rno, 데이터는 Reply, 형식은 json
	// 성공 시 콜백함수의 매개변수는 result
	
	
	function remove(rno, replyer, callback, error) {
	    $.ajax({
	    	type : 'delete',
	      	url : '/replies/' + rno,
	      	data:  JSON.stringify({ rno:rno, replyer:replyer }),
	     	contentType: "application/json; charset=utf-8",
	      	success : function(result, status, xhr) {
	        	if (callback)
	          		callback(result);	     
	      	},
	     	error : function(xhr, status, er) {
	        	if (error) 
	          		error(er);        
	      	}
		});
	}
	// 댓글 삭제 ajax 요청
	// 매개변수로 URL 자원인 rno를 받음
	// 타입은 delete, url에 rno추가
	// 성공 콜백함수의 매개변수는 result 
	
	
	
	function displayTime(timeValue) {

		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');
		} 
		else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	}
	
	
	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};
})();

