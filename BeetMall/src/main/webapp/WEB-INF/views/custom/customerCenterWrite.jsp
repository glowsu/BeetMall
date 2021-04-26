<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/inc/menu_c.jspf"%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
	*{margin:0px; padding:0px; list-style-type :none; font-family: 'Nanum Gothic', sans-serif; font-size:14px;}
	#NoticeleftMenu{
   		display:block;
   }
   #WriteMain>ul>li{
   		list-style-type:none;
   }
   #WriteMain{
   		/* border: 1px solid black; */
   }
   #WriteMain>ul{
    	padding-left: 0px;  		
   }
   #qmtitle{
   		width:95%;
   }
   #filefile{
   		margin-top: 10px;
   		margin-bottom: 10px;
   		width:100%;
   }
   #buttonsss{
   		text-align:right;
   }
   #Maintitle{
   		padding-top:20px;
   		padding-bottom:20px;
   }
   .buybutton{
		width:70px;
		height:35px;
		line-height:35px;
		text-align:center;
		margin:1px;
		padding:0px;
		border: none;
		background-color:#e06666;
		color:white;
		border-radius: 5px;
	}
	a:hover, a:active, a:visited, a:link {
   		color: black;
   }
</style>
<div class="section">
	<form method="post" action="cusomerCenterWriteOk">
		<div id="WriteMain">
			<div>
				<div id="Maintitle">제목 : <input type="text" id="qmtitle" name="qmtitle"/></div>
				<textarea id="content" name="content"></textarea>
			</div>
		</div>
		<div id="filefile">
			<input type="file" name="filename1"/>
		</div>
		<div id="buttonsss">
			<input type="submit" value="문의하기" class="buybutton">
			<input type="button" value="취소" class="buybutton">
		</div>
	</form>
</div>

<script>
/* $(document).ready(function() {
	  $('#summernote').summernote({
		  placeholder: '글써지는지 테스트',
          height: 400
          callbacks: {	//여기 부분이 이미지를 첨부하는 부분
				onImageUpload : function(files) {
					uploadSummernoteImageFile(files[0],this);
				},
				onPaste: function (e) {
					var clipboardData = e.originalEvent.clipboardData;
					if (clipboardData && clipboardData.items && clipboardData.items.length) {
						var item = clipboardData.items[0];
						if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
							e.preventDefault();
						}
					}
				}
			}
  	});
});
/**
* 이미지 파일 업로드
*/
function uploadSummernoteImageFile(file, editor) {
	data = new FormData();
	data.append("file", file);
	$.ajax({
		data : data,
		type : "POST",
		url : "/uploadSummernoteImageFile",
		contentType : false,
		processData : false,
		success : function(data) {
        	//항상 업로드된 파일의 url이 있어야 한다.
			$(editor).summernote('insertImage', data.url);
		}
	});
} */
	
</script>