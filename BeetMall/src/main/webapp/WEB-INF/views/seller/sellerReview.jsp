<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 오늘의 날짜를 계산해서 오늘 기준으로 년도, 월, 일이 언제인지를 기준으로 값이 입력 될 수 있도록 한다. -->
<c:set var='today' value="<%=new java.util.Date()%>" />
<c:set var='monthPtn'>
	<fmt:formatDate value="${today }" pattern="yyyy-MM" />
</c:set>
<c:set var='datePtn'>
	<fmt:formatDate value="${today }" pattern="yyyy-MM-dd" />
</c:set>
<c:set var='yearCheck'>
	<fmt:formatDate value="${today }" pattern="yyyy" />
</c:set>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/xstyle_sellerReview.css">

<script>
////////////////////////////////전역변수 선언 /////////////////////////////////

let sortStr = 0;// 정렬 기준을 위한 변수

let startCalendarDataValue = "";//선택된 날짜의 데이터를 저장해 높는 변수
let endCalendarDataValue = "";//선택된 날짜의 데이터를 저장해 높는 변수

let yearCheck="";//날짜 변경을 년별로 했었는지 체크하기 위한 yearCheck 변수 선언
let dateCheck = "";//년별, 월별, 일별인지 체크하기 위한 변수 선언

let startDate =null;// startDate 선택된 값을 가져온다.
let endDate = null;// endDate 선택된 값을 가져온다.
let mcatenumLength = null;// mcatenum에 데이터 선택된것이 몇개 있는지 확인한다.
let searchTxt =null;// 검색 데이터
let mcatenumDataArr = new Array();

//날짜를 년별, 월별, 일별을 바꿀 경우 그 조건에 맞게 input 박스를 change 한다.
function typeChange(e){
	let optionCheck = $(e).val();
	
	if(optionCheck=="년별"){
		// 년별 넣을때 스타트와 엔드를 드롭박스로 만든다.
		// start date
		let start = "<select id='categoryCalendar_start'>";
			for(let i=2018; i<=${yearCheck};i++){
				start += "<option>"+i+"</option>";
			}
			start += "</select>";
		
		// end date
		let end = "<select id='categoryCalendar_end'>";
			for(let i=2018; i<=${yearCheck};i++){
				//마지막 년도는 selected 하도록 한다.
				if(i==${yearCheck}){
					end += "<option selected>"+i+"</option>";
				} else {
					end += "<option>"+i+"</option>";
				}
			}
			end += "</select>";	
			
		// tag를 변수를 넣어서 치환한다.
		$("#categoryCalendar_start").replaceWith(start);
		$("#categoryCalendar_end").replaceWith(end).attr('selected',${yearCheck});
		yearCheck="년별";
	}else if(optionCheck=="월별"){
		// 년별을 눌렀었을 경우에는 태그가 변경 되었기 때문에 다시 치환해줘야 한다.
		if(yearCheck=="년별"){
			let start = "<input class='categorySearch_container_child' ";
				start+= " type='month' min='2018-01' max='${monthPtn }' id='categoryCalendar_start'/>";
				
			let end = "<input class='categorySearch_container_child' ";
				end+= " type='month' min='2018-01' max='${monthPtn }' id='categoryCalendar_end'/>";
			
			$("#categoryCalendar_start").replaceWith(start);
			$("#categoryCalendar_end").replaceWith(end);
					
		} else{ // 년별 선택이 아니었을 경우 원래대로 넣는다.
			$("#categoryCalendar_start").attr('type','month').attr('max','${monthPtn}');
			$("#categoryCalendar_end").attr('type','month').attr('max','${monthPtn}');
		}
		yearCheck="";
	}else if(optionCheck=="일별"){
		// 년별을 눌렀었을 경우에는 태그가 변경 되었기 때문에 다시 치환해줘야 한다.
		if(yearCheck=="년별"){
			let start = "<input class='categorySearch_container_child' ";
				start+= " type='date' min='2018-01-01' max='${datePtn }' id='categoryCalendar_start'/>";
				
			let end = "<input class='categorySearch_container_child' ";
				end+= " type='date' min='2018-01-01' max='${datePtn }' id='categoryCalendar_end'/>";
			
			$("#categoryCalendar_start").replaceWith(start);
			$("#categoryCalendar_end").replaceWith(end);
					
		} else{// 년별 선택이 아니었을 경우 원래대로 넣는다.
			$("#categoryCalendar_start").attr('type','date').attr('max',"${datePtn}");
			$("#categoryCalendar_end").attr('type','date').attr('max',"${datePtn}");
		}
		yearCheck="";
	}
	
}


//대분류 카테고리 클릭시 : 데이터 베이스로 불러왔던 중분류 카테고리를 선택된 대분류 카테고리 종류에 따라 값을 불러와 li로 넣는 기능

$(document).on('click',"#category>li",function(){
	// 선택된 카테고리 넘버를 변수에 넣어둔다.
	let cateNum = $(this).val();
	// 태그를 이용해 선택된 카테고리의 중분류 카테고리를 담는 변수를 생성한다.
	let tag ="";
	
	// category 대분류 클릭시 색상 변화
	$('#category>li').css('font-weight','normal');
	$(this).css('font-weight','bold');
	
	
	// 카테고리 리스트가 널이 아닐경우
	<c:if test="${cateList!=null }">
		//  카테고리 넘버가 무엇인지에 따라서 불러온다, 카테고리 넘버가 1이면 중분류 카테고리 1번의 값들을 불러온다.
		<c:forEach var="mcateList" items="${cateList}">
			if(${mcateList.catenum}==cateNum){
				tag += "<li value='${mcateList.catename}'>"
						+"<input type='hidden' name='mcatenum' value='${mcateList.mcatenum}'/>"
						+"<a href='#' onclick = 'return false;'/>${mcateList.mcatename}</a></li>";
			}
		</c:forEach>
		$('#mcategory').html(tag);
	</c:if>

});



// 중분류 카테고리 선택시 추가하는 기능 categoryManagement
$(document).on('click', '#mcategory>li', function(){
	/*========================  category에 포함  ==========================*/
	
	// 선택한 목록의 중분류 이름, 번호를 구한다.
	let selectName = $(this).text();
	let selectNum = $(this).children().val();
	
	// li 개수 구하여 10개 이상은 고르지 못하도록 막는다
	let liLength = $('#categoryManagement>li').length;
	if(liLength>=10){
		return alert('최대 10개의 품목만 선택 가능합니다.');
		
	}
	
	
	// li에 존재하는 품목 이름이 있으면 추가하지 못하도록 제한해야 한다.
	for(let i=0; i<liLength; i++){
		let getSelect = $('#categoryManagement>li:nth-child('+(i+1)+')').text();
		let gtPosition = getSelect.indexOf(">")+1;
		let boxPosition = getSelect.indexOf("⊠");
		let result = getSelect.substring(gtPosition,boxPosition);
		if(result===selectName){
			return alert("선택되어 있는 품목은 추가 할 수 없습니다.");	
		}
	}
	
	// 선택된 목록 추가 ( Management에서도 보여주고, 차트, 엑셀에도 추가가 되어야 한다.)
	let tag = "<li value="+selectNum+">"+"<input type='hidden' value="+selectName+">"+"<a href='#' onclick='return false'>"+$(this).attr('value')+"&gt;"+selectName+"<span>⊠</span></a></li>";
	$('#categoryManagement').append(tag);
	

	
});


	/////////////////////////////////////// 중분류 삭제 할 때 사용할 기능
//append로 값을 동적으로 추가해줄 경우 새로 html이 실행 된 것이 아니기 때문에 html에서는 그 값을 읽지 못한다.
// 그렇기 때문에 document를 사용해 다시 html을 읽기만 해서 싹 둘러보고 찾아서 삭제한다고 생각하면 된다.
$(document).on('click','#categoryManagement>li',function(){
	
	// 삭제하기 위해서는 어떤 것이 선택되었는지?
	// 그리고 삭제하는 데이터가 추가 된 것 중에 몇번째에 있는지 알 수 있어야 한다.
	let liLength = $('#categoryManagement>li').length;
	
	// 선택된 목록의 이름과 번호를 구한다.
	let selectName = $(this).text();
	let selectNum = $(this).children().val();
	
	
	// 선택된 아이템의 텍스트를 걸러야 한다.
	let selectGtPosition = selectName.indexOf(">")+1;
	let selectBoxPosition = selectName.indexOf("⊠");
	let selectNameResult = selectName.substring(selectGtPosition,selectBoxPosition);
	
	// 이건 선택되서 아래에 내려온것들 클릭했을때 지워주는거 ex) 채소>땅콩
	$(this).remove();
	
})// 삭제 함수 끝



// 조회 누를경우 db 불러오기
$(function(){
	$('#searchingBtn').click(function(){
		// 월별 일별에 사용될 스플릿 값 저장할 전역변수 생성!
		
		
		mcatenumDataArr = []; //초기화
		dateCheck = $('#categoryDate option:selected').val();// dateCheck가 무엇이 되어있는지 확인한다.
		startDate = $('#categoryCalendar_start').val();// startDate 선택된 값을 가져온다.
		endDate = $('#categoryCalendar_end').val();// endDate 선택된 값을 가져온다.
		mcatenumLength = $('#categoryManagement>li').length; // mcatenum에 데이터 선택된것이 몇개 있는지 확인한다.
		searchTxt = $('#searchTxt').val();// 적은 텍스트를 확인한다.
		//=======================제한사항 걸러내기 3가지 ===========================//
		// 날짜 시작, 종료를 입력하지 않을 경우 걸러낸다.
		if(startDate == '' ||endDate == ''){
			alert('검색할 시작 날짜와 종료 날짜를 반드시 선택해야 합니다.');
			return false;
		}
		
		// 날짜 시작, 종료의 기준일을 반대로 누르는 사람 있으면 걸러야 한다..
		if(startDate > endDate){
			alert('검색 시작 날짜를 종료 날짜보다 미래로 지정 할 수 없습니다.');
			return false;
		}		
		
		//========================제한사항 걸러내기 끝 ===============================//
		
		if(dateCheck== "년별"){
			startDate = startDate+"-01-01";
			endDate = endDate+"-12-31";
		}
		
		if(dateCheck== "월별"){
			let endSplit = endDate.split("-");
			endSplit[0] = parseInt(endSplit[0],10);
			endSplit[1] = parseInt(endSplit[1],10);
			// 마지막 날짜 구하기
			let lastDay = new Date(endSplit[0],endSplit[1],0).getDate();
			
			startDate = startDate+"-01";
			endDate = endDate+"-"+lastDay;
		}
		
		
		if(mcatenumLength != 0){
			for(let i = 0; i < mcatenumLength; i++){
				mcatenumDataArr.push($('#categoryManagement>li:nth-child('+(i+1)+')').val());
			}
		} else {
			mcatenumDataArr = [0];
		}
		
		paging(1, sortStr, mcatenumDataArr, searchTxt, startDate, endDate);
		
		
	})
	
})

// 정렬방법 고르기
function sortChange(result){
	let resultData = $(result).val();

	if(startDate == null || startDate == '' ){
		startDate = "!$#@%";
		endDate = "!$#@%";
	}
	if(searchTxt == null || searchTxt == '' ){
		searchTxt = "!$#@%";
	}
	if(mcatenumDataArr == null || mcatenumDataArr == '' ){
		mcatenumDataArr = [0];
	}
	
	if(resultData == "최신순"){
		sortStr = 0;
		paging(1, 0, mcatenumDataArr, searchTxt, startDate, endDate);
	} else if(resultData == "평점높은순"){
		sortStr = 1;
		paging(1, 1, mcatenumDataArr, searchTxt, startDate, endDate);
	} else {
		sortStr = 2;
		paging(1, 2, mcatenumDataArr, searchTxt, startDate, endDate);
	}
	
}

//페이징
function paging(pageNum, sortStr, mcatenumDataArr, searchTxt, startDate, endDate){
	// 제한사항 걸러내기....
	if(sortStr == undefined){
		sortStr = 0;
	}
	if(mcatenumDataArr == undefined || mcatenumDataArr == ''){
		mcatenumDataArr = [0];
	}
	
	if(searchTxt == undefined || searchTxt == "!$#@%"){
		searchTxt = "";
	}
	if(startDate == undefined || startDate == "!$#@%"){
		startDate = "";
		endDate = "";
	}
	
	
	let url = "SellerReviewPaging";
	let param = "pageNum="+pageNum+"&totalRecord="+${resultData.totalRecord}+"&sortStr="+sortStr;
		param += "&mcatenumDataArr="+mcatenumDataArr+"&searchTxt="+searchTxt+"&startDate="+startDate+"&endDate="+endDate;
	
	$.ajax({
		url: url,
		data: param,
		type: "post",
		success: function(result){
			// 데이터 불러와 table 형식으로 만들기
			let tag = "<li>상품명</li>";
				tag += "<li>평점</li>";
				tag += "<li>포토</li>";
				tag += "<li>리뷰 내용</li>";
				tag += "<li>등록자</li>";
				tag += "<li>등록일</li>";
				tag += "<li>답변 여부</li>";

			result2 = $(result[0]);
			result2.each( function (idx, vo){
				tag += "<li>" + vo.productname + "</li>";
				tag += "<li>" + vo.reviewscore + "</li>";
				if(vo.reviewimg != null){
					let data = vo.reviewimg;
					tag += "<li style=\"background-image: url(\'<%=request.getContextPath()%>/resources/img/"+data+"\'); background-size: 100% 100%;\" )></li>";
				} else {
					tag += "<li>-</li>";
				}
				tag += "<li><a href='javascript:void(0)' onclick='javascript:popupOpen(this)'><input type='hidden' name='reviewnum' value='"+vo.reviewnum+"' />"+vo.reviewcontent+"</a></li>";
				tag += "<li>" + vo.userid + "</li>";
				tag += "<li>" + vo.reviewwritedate + "</li>";
				if(vo.reviewanswer != null){
					tag += "<li><input type='hidden' value='"+vo.reviewanswer+"' >답변 완료</li>";
				} else {
					tag += "<li>미답변</li>";
				}
			})
			$('#reviewList').html(tag);
	
	
			// 시작하기 전, startDate가 값이 없으면 paging 누를때 에러가 발생하기 때문에 임의의 특수문자로 설정해놓는다.
			if(startDate == null || startDate == '' ){
				startDate = "!$#@%";
				endDate = "!$#@%";
			}
			if(searchTxt == null || searchTxt == '' ){
				searchTxt = "!$#@%";
			}
	
			
			// 페이징 처리	
			let pagingTag = "";

			let pagingData = result[1];
			if(pagingData.pageNum != 1){
				pagingTag += '<a class="arrow pprev" href="javascript:paging(1,'+sortStr+','+mcatenumDataArr+',\''+ searchTxt +'\',\''+startDate+'\',\''+ endDate+'\')"></a>';
				pagingTag += '<a class="arrow prev" href="javascript:paging('+(pagingData.pageNum-1)+','+sortStr+','+mcatenumDataArr+',\''+ searchTxt +'\',\''+startDate+'\',\''+ endDate+'\')"></a>';
			}
			for(let i = pagingData.startPageNum; i <= pagingData.totalPage; i++){
				if(pagingData.pageNum == i){
					pagingTag += '<a class="active" href="#" onclick="return false;">'+(i)+'</a>';
				} else {
					pagingTag += '<a class="arrow" href="javascript:paging('+(i)+','+sortStr+','+mcatenumDataArr+',\''+ searchTxt +'\',\''+startDate+'\',\''+ endDate+'\')">'+(i)+'</a>';
				}
			}
			
			if(pagingData.totalPage != pagingData.pageNum){
				pagingTag += '<a class="arrow next" href="javascript:paging('+(pagingData.pageNum+1)+','+sortStr+','+mcatenumDataArr+',\''+ searchTxt +'\',\''+startDate+'\',\''+ endDate+'\')"></a>';
				pagingTag += '<a class="arrow nnext" href="javascript:paging('+pagingData.totalPage+','+sortStr+','+mcatenumDataArr+',\''+ searchTxt +'\',\''+startDate+'\',\''+ endDate+'\')"></a>';
			}

			$('.page_nation').html(pagingTag);
		}, error: function(){
			console.log('페이징 실패');
		}
	})
}
</script>

<section>
	<%@include file="/WEB-INF/views/inc/sellerHeader.jsp"%>
	<!-- 본문 시작 -->
	<article>
		<div class='seller_title'>리뷰관리</div>
		<div class="wrap">
			<!-- 리뷰 보기 -->
			<div class="wrapTitle">리뷰보기</div>
			<div class="wrapContainer">

				<ul id="reviewInfo">
					<li style="font-weight: bold;">새 리뷰</li>
					<li>${resultData.newReview }건</li>
					<li style="font-weight: bold;">미답변</li>
					<li>${resultData.nullReview }건</li>
					<li style="font-weight: bold;">사용자 총 평점</li>
					<li>${resultData.totalScore }/5</li>
					<li style="font-weight: bold;">전체 리뷰 수</li>
					<li>${resultData.totalReview }건</li>
				</ul>
			</div>
			<!-- 리뷰 보기 끝 -->

			<!-- 리뷰 검색 -->
			<div class="wrapTitle">리뷰 검색</div>
			<div class="wrapContainer">
				<div id="categoryList">
					<div id="categoryListMiddle">
						<!-- 대분류 카테고리!!!! -->
						<ul id="category">
							<!-- 카테고리 리스트에서 모든 카테고리 리스트를 가져오지만 우선 대분류만 보이게 한다.-->
							<c:if test="${cateList!=null}">
								<!-- 변수 i를 선언해주고 -->
								<c:set var="i" value="1" />
								<!-- 변수 i 즉, catenum이 i와 일치하는 데이터 하나를 가지고 오면 
											i를 더해주어 다음 조건을 만들어 다음 번호 것만 가져오게 한다 -->
								<c:forEach var="categoryList" items="${cateList}">
									<c:if test="${categoryList.catenum==i}">
										<li value="${categoryList.catenum}"><a href="#" onclick="return false">${categoryList.catename}</a><span>&gt;</span></li>
										<c:set var="i" value="${i+1 }" />
									</c:if>
								</c:forEach>
								<c:remove var="i" />
							</c:if>
						</ul>

						<!-- 중분류 카테고리 -->
						<ul id="mcategory"></ul>
					</div>

					<!-- 중분류 카테고리 선택하면 선택된 사항이 삽입되는 위치 -->
					<ul id="categoryManagement"></ul>

					<!-- 날짜 적용 할 수 있는 기능들 모여있는 컨테이너 -->
					<div id="categorySearch_container" style='display:flex; justify-content: space-between'>
						<div>
							<select class="categorySearch_item" id="categoryDate" name="categoryDate" onchange="typeChange(this)">
								<option value="년별">년별</option>
								<option value="월별" selected>월별</option>
								<option value="일별">일별</option>
							</select> 
							<input type="month" min="2018-01" max="${monthPtn }" id="categoryCalendar_start" /> 
							<b>&nbsp;&nbsp;~&nbsp;&nbsp;</b> 
							<input type="month" min="2018-01" max="${monthPtn }" id="categoryCalendar_end" />
						</div>
						<div>
							<input type="text" id="searchTxt" name="searchTxt" placeholder="리뷰 내용"/>
							<button id="searchingBtn" style='margin:0 10px'>조회</button>
						</div>
					</div>
					

				</div>
				<!-- categoryList 끝 -->
			</div>
			<!-- 리뷰 검색 끝 -->

			<!-- 리뷰 출력 -->

			<div id="sortContainer">
				<select id="sortSelect" onchange="javascript:sortChange(this)">
					<option selected="selected" value="최신순">최신순</option>
					<option value="평점높은순">평점높은순</option>
					<option value="평점낮은순">평점낮은순</option>
				</select>
			</div>

			<ul id="reviewList">
				<li>상품명</li>
				<li>평점</li>
				<li>포토</li>
				<li>리뷰 내용</li>
				<li>등록자</li>
				<li>등록일</li>
				<li>답변 여부</li>
				<c:if test="${reviewList != null }">
					<c:forEach var="result" items="${reviewList}" varStatus="i">
						<li>${result.productname }</li>
						<li>${result.reviewscore }</li>
						<c:if test="${result.reviewimg != null }">
							<li style="background-image: url('<%=request.getContextPath()%>/resources/img/${result.reviewimg}'); background-size: 100% 100%;" )></li>
						</c:if>
						<c:if test="${result.reviewimg == null }">
							<li>-</li>
						</c:if>
						<li>
							<a href="javascript:void(0)" onclick="javascript:popupOpen(this)">
								<input type="hidden" name="reviewnum" value="${result.reviewnum }" />
									${result.reviewcontent }
							</a>
							</li>
						<li>${result.userid }</li>
						<li>${result.reviewwritedate }</li>
						<c:if test="${result.reviewanswer != null }">
							<li><input type="hidden" value="${result.reviewanswer }" >답변 완료</li>
						</c:if>
						<c:if test="${result.reviewanswer == null }">
							<li>미답변</li>
						</c:if>
					</c:forEach>
				</c:if>
			</ul>
			<!-- 리뷰 출력 끝 -->
			<!--------------페이징 표시-------------------->
			
			<c:if test="${resultData != null }">
				
				<div class="page_wrap">
					<div class="page_nation">
						<c:if test="${resultData.pageNum != 1 }">
							<a class="arrow pprev" href="javascript:paging(1)"></a> 
							<a class="arrow prev" href="javascript:paging(${resultData.pageNum-1}"></a> 
						</c:if>
							<c:forEach var="i" begin="${resultData.startPageNum }" end="${resultData.totalPage }" >
								<c:if test="${resultData.pageNum == i }">
									<a class="active" href="#" onclick="return false;">${i}</a> 
								</c:if>
								<c:if test="${resultData.pageNum != i }">
									<a class="arrow" href="javascript:paging(${i})">${i}</a>
								</c:if>
							</c:forEach>
						<c:if test="${resultData.totalPage != resultData.pageNum }">
							<a class="arrow next" href="javascript:paging(${resultData.pageNum+1})"></a>
							<a class="arrow nnext" href="javascript:paging(${resultData.totalPage})"></a>
						</c:if>
					</div>
				</div>
				
			</c:if>
		</div>
	</article>
	<!-- 본문 끝 -->
	
</section>
<div id="modal"></div>
<div id="popup"></div>
<div id="report"></div>
<script>
	// 팝업창 만들기! 
	function popupOpen(data){
		
		// 상품명
		let reviewnum = $(data).children().val();
		let productname = $(data).parent().prev().prev().prev().text();
		let reviewscore = $(data).parent().prev().prev().text();
		let reviewcontent = $(data).text().trim();
		let userid = $(data).parent().next().text();
		let reviewwritedate = $(data).parent().next().next().text();
		let reviewanswer = $(data).parent().next().next().next().text();
		
		console.log(reviewnum);
		
		if(reviewanswer == '답변 완료'){
			reviewanswer = $(data).parent().next().next().next().children('input').val();
		}
		console.log(reviewanswer);
		
		let tag = '<div class="wrapContainer_Edit1">';
			tag += '<form method="post" action="javascript:reviewAnswer()" id="popupFrm">';
			tag += '<input type="hidden" name="reviewnum" value="' + reviewnum + '">';
			tag += '<div class="wrapTitle" style="text-align: center; font-weight: bold">고객 리뷰</div>';
			tag += '<ul id="reivewManagement">';
			tag += '<li><b>구매상품</b> <div>' + productname + '</div></li>';
			tag += '<li><input type="hidden" name="userid" value="'+ userid+'"><b>등록자</b> ' + userid + '</li>';
			tag += '<li><b>등록일</b> ' + reviewwritedate + '</li>';
			tag += '<li><b>평점</b><div> ' + reviewscore + '</div></li>';
			tag += '</ul>';	
			tag += '<div>';
			tag += '<br />';
			tag += '<b>&nbsp;&nbsp;&nbsp;리뷰 내용</b><br />';
			tag += '<div id="reviewContent">';
			tag += '<img src="<%=request.getContextPath() %>/resources/img/xprofile_img.png" id="repMenu_img" />';
			tag += '<p>' + reviewcontent + '</p>';
			tag += '</div>';
			tag += '</div>';
			tag += '<div id="reviewAnswer">';
				if( reviewanswer == '미답변'){
					tag += '<textarea id="reviewanswer" name="reviewanswer" rows="5" cols="50" style="width:670px; margin:0 15px;"></textarea>';
				} else {
					tag += '<div style="border-top:1px solid #ddd;">';
					tag += '<p style="margin: 20px 10px ">' + reviewanswer + '<p>';
					tag += '</div>';
				}
			tag += '<div id="popupBtnContainer">';
				if( reviewanswer == '미답변'){
					tag += '<input class="normalBtn" type="submit" value="확인" >';
					tag += '<input class="normalBtn" type="button" onclick="popupClose()" value="닫기"> ';
					tag += '<input class="normalBtn" type="button" onclick="popupreport(\''+reviewnum+'\',\''+userid+'\')" value="신고">';
				} else {
					tag += '<input class="normalBtn" type="button" onclick="popupClose()" value="닫기"> ';
					tag += '<input class="normalBtn" type="button" onclick="popupreport(\''+reviewnum+'\',\''+userid+'\')" value="신고">';
				}
				tag += '</div>';
			tag += '</div>';

			tag += '</form>';
			tag += '</div>';
		
		$('#popup').html(tag);
		
		let windowWidth = $(window).scrollLeft();
		let windowHeight = $(window).scrollTop() + (window.innerHeight/2) - 250;
		
		$('body').css('overflow','hidden');
		$('#modal').css('display','block').css('top', $(window).scrollTop() +"px").css('left',windowWidth+'px');
		$('#popup').css('display','block').css('top',windowHeight+'px').css('left',windowWidth+'px');
		
	}
	
	// 팝업창 닫기
	function popupClose(){
		$('body').css('overflow','auto');
		$('#modal').css('display','none');
		$('#popup').css('display','none');
	}
	
	// 신고 창 띄우기
	function popupreport(reviewnum, userid){
		
		let tag = '<div class="wrapContainer_Edit1" style="width:300px; height:auto;">';
			tag += '<form method="post" action="javascript:reportUpdate()" id="reportFrm">';
			tag += '<input type="hidden" name="userid" value="' + userid + '" >';
			tag += '<input type="hidden" name="reviewnum" value="' + reviewnum + '">';
			tag += '<div class="wrapTitle">신고하기</div>';
			tag += '<div id="reportReason">';
			tag += '<p>신고사유</p>';
			tag += '<select name="reportReason">';
			tag += '<option>비방/욕설</option>';
			tag += '<option>허위</option>';
			tag += '<option>성희롱</option>';
			tag += '<option>기타</option>';
			tag += '</select>';
			tag += '</div>';
			tag += '<div>';
			tag += '<textarea rows="10" cols="40" id="reportContent" name="reportContent"></textarea>';
			tag += '</div>';
			tag += '<div id="reportBtn">';
			tag += '<input type="submit" class="normalBtn" value="보내기" />';
			tag += '<input type="button" class="normalBtn" value="취소" onclick="reportClose()"/>';
			tag += '</div>';
			tag += '</form>';
			tag += '</div>';
			
		$('#report').html(tag);
		
		
		let windowWidth = $(window).scrollLeft();
		let windowHeight = $(window).scrollTop() + (window.innerHeight/2)-100;
		$('#report').css('display','block').css('left',windowWidth+"px").css('top',windowHeight+"px");
	}
	
	//신고창 닫기
	function reportClose(){
		$('#report').css('display','none');
	}
	
	// 리뷰 답변 등록하기
	function reviewAnswer(){
		let strLength = $('#reviewanswer').val().length;
		
		if( strLength > 300 ){
			alert('글자수는 300자를 초과 할 수 없습니다');
		}
		
		
		// 제한사항 걸러내기....
		if(sortStr == undefined){
			sortStr = 0;
		}
		if(mcatenumDataArr == undefined || mcatenumDataArr == ''){
			mcatenumDataArr = [0];
		}
		
		if(searchTxt == undefined || searchTxt == "!$#@%"){
			searchTxt = "";
		}
		if(startDate == undefined || startDate == "!$#@%"){
			startDate = "";
			endDate = "";
		}
		
		if(startDate == null || startDate == '' ){
			startDate = "!$#@%";
			endDate = "!$#@%";
		}
		if(searchTxt == null || searchTxt == '' ){
			searchTxt = "!$#@%";
		}

		
		let url = "SellerReviewAnswer";
		let param = $('#popupFrm').serialize();
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			success:function(){
				alert('답변이 성공적으로 등록되었습니다')
				popupClose();
				paging( $('.active').text(), sortStr, mcatenumDataArr, searchTxt, startDate, endDate );
			} ,
			error:function(){
				alert('답변 등록이 실패하였습니다');
			}
		})
	}
	
	// 신고 접수
	function reportUpdate(){
		let strLength = $('#reportContent').val().length;
		
		if( strLength > 300 ){
			alert('글자수는 300자를 초과 할 수 없습니다');
		}
		
		
		// 제한사항 걸러내기....
		if(sortStr == undefined){
			sortStr = 0;
		}
		if(mcatenumDataArr == undefined || mcatenumDataArr == ''){
			mcatenumDataArr = [0];
		}
		
		if(searchTxt == undefined || searchTxt == "!$#@%"){
			searchTxt = "";
		}
		if(startDate == undefined || startDate == "!$#@%"){
			startDate = "";
			endDate = "";
		}
		
		if(startDate == null || startDate == '' ){
			startDate = "!$#@%";
			endDate = "!$#@%";
		}
		if(searchTxt == null || searchTxt == '' ){
			searchTxt = "!$#@%";
		}

		console.log()
		
		let url = "SellerReviewReport";
		let param = $('#reportFrm').serialize();
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			success:function(){
				alert('신고가 접수되었습니다')
				reportClose();
				paging( $('.active').text(), sortStr, mcatenumDataArr, searchTxt, startDate, endDate );
			} ,
			error:function(){
				alert('신고 접수에 실패하였습니다');
			}
		})
	}
</script>


