<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="includes/header.jsp"%>

<div class="container">
	<div class="row justify-content-center">

	<div class="col-xl-10 col-lg-12 col-md-9">
	<div class="card o-hidden border-0 shadow-lg my-5">
		<div class="card-body p-0">
			<!-- Nested Row within Card Body -->
			<div class="row">
				<div class="col-lg-6 d-none d-lg-block bg-register-image"></div>
				<div class="col-lg-6">
					<div class="p-5">
						<div class="text-center">
							<h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
						</div>
						<form role="form" class='user' method='post' action="/register">
							
							<div class="form-group">
								<input class="form-control" name="userName" type="text" placeholder="이름" autofocus>
							</div>

							<div class="form-group">
								<input class="form-control" name="userid" type="text" placeholder="아이디">
							</div>

							<div class="form-group">
								<input class="form-control" name="userpw" type="password" placeholder="비밀번호">
							</div>
							<hr>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<a href="login.html" class="btn btn-primary btn-user btn-block btn-register"> 등록 </a>
						</form>
						<c:forEach var='num' begin='0' end='4'>
									<br>
									</c:forEach>
						<hr>
						<div class="text-center">
							<a class="small" href="/customLogin">Already have an account? Login!</a>
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
	$(".btn-register").on("click", function(e) {
		e.preventDefault();
		$("form").submit();
	});
</script>
<%@include file="includes/footer.jsp"%>