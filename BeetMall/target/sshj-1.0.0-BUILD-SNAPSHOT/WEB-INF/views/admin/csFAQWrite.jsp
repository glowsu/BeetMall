<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ include file="/inc/top.jspf" %>
<%@ include file="/inc/leftBar.jspf" %> 
<link rel ="stylesheet" href="<%=request.getContextPath() %>/resources/css/sshj_admin.css" type="text/css"> 

<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet"> 

<style>
	#mypageMenubar{
		display:block;
	}
	
	*{margin:0px; padding:0px; list-style-type :none; font-family: 'Nanum Gothic', sans-serif; }

	a:hover, a:active, a:visited, a:link {
   		color: black;
    }
    a{
    	color:black;
    }
	answer_line{
		width:100%; 	
		background-color:#f6f6f6; 
		height:20px; 
	}
	#qmtitle, select{border:none;}
	#qmtitle{width:300px; color:lightgray;}
	#qmtitle{width:500px}
	.write_btn{width:150px; margin-left:20px;}
	a{color:black;}
  	/*왼쪽 메뉴바*/
  	label{
  		margin-bottom:0;
  		display:block;
  	}
  	/*제목 바*/
  	#topBar{ 
	  	position:absolute;
	  	top:200px;
	  	left:-25px;
	  	font-size:20px;
  	}
  	#topBar>p{
  		padding-left:60px; 
  		color:white;
  	}
  	input{
  		border:none;
  		font-weight:normal;
  	}
   /*표*/
   form{
	   	position:absolute;
	   	top:147px;
	   	left:180px;
	   	width:1351px;
   }
   
   th, .th{
   		background-color:#E9E9E9;
	}
	.td, form input{
	  background-color:#F8F7F7;
	} 
	table{
		width:100%;	
		border-spacing: 0;
		text-indent: initial;	
		border-top:2px solid lightgray;
		border-bottom:2px solid lightgray;
		font-size:15px;
	}
	th, .th{
		height:40px;
		font-size:15px;
		width:80px; text-align:center;
		display: table-cell;
	    vertical-align: inherit;
	    font-weight: bold;
	    text-align: -internal-center; 
	}
	th:not(#smallTitle){
	    border-right:1px solid lightgray;
	}
	thead, .answer_content, .td{
		border-bottom: 1px solid #ccc;
	    border-top: 1px solid #ccc;
	    width:100%;
	}
	tr{
		display: table-row;
	    vertical-align: inherit;
	    border-color: inherit;
	    height:40px;
	    border-bottom:1px solid lightgray;
	}
	.td, .qmcontent{
		padding-left:20px;
		
	}
	.qmcontent{
		margin: 20px 0 20px;
	}
	td, .td{
		height:40px;
	}
	.tr_head{
		font-weight:bold;
	}
	.tr_head li{
		float:left;
	}
	.td, .th{ line-height:40px;}
	.td{
		width:30%; line-height:40px; 
	} 
	.td{
		width:0;
	}
	#bottommm{
		text-align:center;  
		margin-top: 950px;
		position:relative;
		left:-782px;
	}
	#bottommm>input{
		border:1px solid gray;
	}
	.write_btn{
		height:40px;
	}
	#write_btn{
		width:150px;
	}
	#cancle_btn{
		position:relative;
		top:38px;
		left:200px;
	}
	
	input[type="submit"].btn:hover, input[type="button"].btn:hover{
   	  background: #b3b3b3;
	  color:white;
	  display: inline-block;
	  outline: 0;
	} 
	#noticeSubject{
		color:lightgray;
	}
</style>
<div id="body1">
<div class="container">
	<div id="topBar">
		<p><strong>자주 묻는 질문 등록</strong></p>   
	</div>
	<div id="box"> 	
	<form method="post" action="noticeWriteOk">
		<table>
			<tbody> 
				<tr class="tr_head">
					<th class="menu" >FAQ 번호</th>
					<td class="td" colspan="3">
						<div id="faqNum">
							65812
						</div>
					</td>
				</tr>
				
			<tr class="tr_head">
				<th class="menu" >대상</th>
				<td class="td" colspan="3">
					<div id="cate">
					<select>
						<option value="전체" selected>전체</option> 
						<option value="소비자" >소비자</option>
						<option value="판매자">판매자</option> 
					</select>
					</div>
				</td>
			</tr>
			<tr class="tr_head">
				<th class="menu" >카테고리</th>
				<td class="td" colspan="3">
					<div id="cate">
					<select>
						<option value="카테고리" selected>카테고리</option> 
						<option value="상품" >상품</option>
						<option value="회원/포인트">회원/포인트</option>
						<option value="판매">판매</option>
						<option value="주문/결제">주문/결제</option>
						<option value="배송">배송</option>
						<option value="판매">교환</option>
					</select>
					</div>
				</td>
			</tr>
				<tr class="tr_head">
					<th class="menu">제목</th>
					<td  class="td"><input type="text" name="noticeSubject" id="noticeSubject" placeholder="제목을 입력하세요"/></td>
				</tr>
				<tr class="tr_head">
					<th class="menu">등록일</th>
					<td  class="td">
						<div id="writedate">
							2021/02/23
						</div>
					</td>
				</tr> 
				<tr>
					<th id="smallTitle" colspan="4">자주 묻는 질문 내용</th>
				</tr>
				<tr>
					<td class="question_content" colspan="4">
						<textarea id="qmcontent" name="qmcontent" class="summernote" placeholder="자주 묻는 질문 내용을 입력해주세요."></textarea>
					</td>	
				</tr>
			</tbody>
		</table>
			<div id="bottommm">
				<input type="button" value="취소" class="btn write_btn" id="cancle_btn" onClick="location.href='<%=request.getContextPath() %>/recipeView'"/>
				<input type="submit" value="작성하기" class="btn write_btn" id="write_btn"/>				
			</div>
		</form>
		</div>
</div>
</div>
<script>
$(document).ready(function() {
	  $('.summernote').summernote({
		  height: 500,                 // 에디터 높이 
		  focus: true,
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
}


</script>