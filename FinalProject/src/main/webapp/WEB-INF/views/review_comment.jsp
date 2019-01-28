<%@page import="com.yaboja.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userseq = ((UserDto)session.getAttribute("dto")).getUserseq();
%>
<!DOCTYPE html>
<html>
<head>
<script src="vendor/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
var reviewboardseq = '${reviewboarddto.reviewboardseq}'; //게시글 번호
 
$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
    commentInsert(insertData); //Insert 함수호출(아래)
});
 
 
 
//댓글 목록 
function commentList(){
	
    $.ajax({
        url : '/controller/coment_list.do',
        type : 'get',
        data : {'reviewboardseq':reviewboardseq},
        success : function(data){
            var a =''; 
           var userseq = document.getElementById("userseq").value;
           var coupdate = '';
            $.each(data, function(key, value){
            	if(userseq == value.userseq){
            		coupdate = '<div style = "float:right;"><a onclick="commentUpdate('+value.reviewboardcomentseq+',\''+value.reviewboardcomentcontent+'\');"> 수정 </a>'+'<a onclick="commentDelete('+value.reviewboardcomentseq+');"> 삭제 </a> </div>';
            	}
            	
                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += coupdate;
                a += '<div class="commentInfo'+value.reviewboardcomentseq+'"> 작성자 : '+value.username+'</div>';
                a += '<div class="commentContent'+value.reviewboardcomentseq+'"> <p> 내용 : '+value.reviewboardcomentcontent +'</p>';
                a += '</div></div>';
            });
            
            $(".commentList").html(a);
        }
    });
}
 
//댓글 등록
function commentInsert(insertData){
    $.ajax({
        url : '/controller/coment_insert.do',
        type : 'post',
        data : insertData,
        success : function(data){
            if(data == 1) {
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=reviewboardcomentcontent]').val('');
            }
        }
    });
}
 
//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function commentUpdate(reviewboardcomentseq, reviewboardcomentcontent){
    var a ='';
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="reviewboardcomentcontent_'+reviewboardcomentseq+'" value="'+reviewboardcomentcontent+'"/>';
    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc('+reviewboardcomentseq+');">수정</button> </span>';
    a += '</div>';
    
    $('.commentContent'+reviewboardcomentseq).html(a);
    
}
 
//댓글 수정
function commentUpdateProc(reviewboardcomentseq){
    var updateContent = $('[name=reviewboardcomentcontent_'+reviewboardcomentseq+']').val();
    
    $.ajax({
        url : '/controller/coment_update.do',
        type : 'post',
        data : {'reviewboardcomentcontent' : updateContent, 'reviewboardcomentseq' : reviewboardcomentseq},
        success : function(data){
            if(data == 1) commentList(reviewboardseq); //댓글 수정후 목록 출력 
        }
    });
}
 
//댓글 삭제 
function commentDelete(reviewboardcomentseq){
	
	$.ajax({
        url : '/controller/coment_delete.do',
        type : 'post',
        data : { 'reviewboardcomentseq' : reviewboardcomentseq},
        success : function(data){
            if(data == 1) commentList(reviewboardseq); //댓글 삭제후 목록 출력 
        }
    });
}
 
 
 
 
$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});
 
 
 
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="hidden" id="userseq" value="<%= userseq%>"/>

</body>
</html>