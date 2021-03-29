<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="includes/header.jsp"%>

<!DOCTYPE html>
<html lang="en">



<div class="container">

	<!-- Outer Row -->
	<div class="row justify-content-center">

		<div class="col-xl-10 col-lg-12 col-md-9">

			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="row">
						<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
						<div class="col-lg-6">
							<div class="p-5">
								<div class="text-center">
									<h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
								</div>
								<form class="user" role="form" method='post' action="/login">
									<div class="form-group">
										<input class="form-control" placeholder="아이디" name="username" type="text" autofocus>
									</div>
									<div class="form-group">
										<input class="form-control" placeholder="비밀번호" name="password" type="password" value="">
									</div>
									<div class="form-group">
										<div class="custom-control custom-checkbox small">
											<input name="remember-me" type="checkbox" value="Remember Me" class="custom-control-input" id="customCheck">
											<label class="custom-control-label" for="customCheck">Remember Me</label>
										</div>
									</div>
									<a href="/board/list" class="btn btn-primary btn-user btn-block login"> 로그인 </a>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<c:forEach var='num' begin='0' end='5'>
									<br>
									</c:forEach>
								</form>
								<hr>

								<div class="text-center">
									<a class="small" href="/join">Create an Account!</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>

</div>

<!-- Bootstrap core JavaScript-->
<script src="../resources/vendor/jquery/jquery.min.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="../resources/js/sb-admin-2.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';
		checkModal(result);

		function checkModal(result) {
			if (result === '')
				return;
			if (result === 'failure')
				$(".modal-body").html("회원가입에 실패하셨습니다.");
			if (result === 'success')
				$(".modal-body").html("회원가입이 완료되었습니다.");
			$("#myModal").modal("show");
		}

		$(".login").on("click", function(e) {
			e.preventDefault();
			$("form").submit();
		});
	});
</script>

<c:if test="${logout != null }">
	<script>
		$(document).ready(function() {
			alert("로그아웃하셨습니다.");
		});
	</script>
</c:if>




<%@include file="includes/footer.jsp"%>