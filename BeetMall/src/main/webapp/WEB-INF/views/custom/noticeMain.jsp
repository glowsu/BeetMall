<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/inc/menu_c.jspf"%>
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<style>
	*{margin:0px; padding:0px; list-style-type :none; font-family: 'Nanum Gothic', sans-serif;}
	.wrapTitle{
	   margin-top: 50px;
	   width: 100%;
	   height: 60px;
	   line-height: 60px;
	   /* color: #fff; */
	   color:black;
	   font-weight:bold;
	   font-size:2em;
	   text-indent: 0.4em;
	   /* background-color: rgb(224,102,102); */
	   margin-bottom:30px;
	}
	ul, li, a{
		list-style: none; padding:0; margin:0;
	}

	/*표*/
	table{
		border-spacing: 0;
		text-indent: initial;
	}
	th{
		height:50px;
		display: table-cell;
	    vertical-align: inherit;
	    font-weight: bold;
	    text-align: -internal-center;
	    border-bottom: 2px solid #ccc;
	    border-top: 2px solid #ccc;
   		background-color: #fcfcfc;
   		font-size: 16px;
	}
	td{
		height:50px;
		border-bottom:1px solid lightgray;
	}
	td:nth-child(1), td:nth-child(3){
		text-align:center;
		width:100px;
	}
	td:nth-child(2){
		padding-left:30px;
	}
	td:nth-child(2) a, a{
		color:black;
		cursor: pointer;
	}
	/*페이징*/
	.paging,th{
		margin-top:30px;
		text-align:center;
	}
	.wrap_paging, .option_change, table, fieldset, .paging{
		width:100%;
	}
	.paging a{
		display: inline-block;
	    height: 23px;
	    width:23px;
	    line-height: 22px;
	    border: 1px solid #ccc;
	    background-color: #fff;
	    text-decoration: none;
	    vertical-align: top;
	    overflow: hidden;
	}
   
   a:hover, a:active, a:visited, a:link {
   		color: black;
   }
   #NoticeleftMenu{
   		display:block;
   }
</style>
<script>
function showHideFaq(){
	location.href="knotice_view";
}
</script>
<div class="section">
	<div class="main">
		<div class="wrapTitle">공지사항</div>
		<fieldset>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td><a href="javascript:showHideFaq()"><strong>코로나19로 인한 픽업 서비스 중단 안내</strong></a></td>
					<td>21/04/21</td>
				</tr>
				
				<!-- 임시로 넣은 정보 -->
				<tr>
					<td>2</td>
					<td><a href="">개인정보 처리방침 개정안내</a></td>
					<td>21/04/21</td>
				</tr>
				<tr>
					<td>3</td>
					<td><a href="">개인정보 처리방침 개정안내</a></td>
					<td>21/04/21</td>
				</tr>
				<tr>
					<td>4</td>
					<td><a href="">개인정보 처리방침 개정안내</a></td>
					<td>21/04/21</td>
				</tr>
			</tbody>
			
		</table>
		<div class="wrap_paging">
			<div class="paging">
				<a href="#" title="" class=""><span style="cursor:pointer;">&#10094;</span></a>
				<a href="#" title="" class=""><span style="cursor:pointer;">1</span></a>
				<a href="#" title="" class=""><span style="cursor:pointer;">&#10095;</span></a>
			</div>
		</div>
		</fieldset>
		<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</div>
</div>