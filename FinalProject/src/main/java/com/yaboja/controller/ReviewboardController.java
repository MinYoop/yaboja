package com.yaboja.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yaboja.biz.CoinBiz;
import com.yaboja.biz.ReviewboardBiz;
import com.yaboja.biz.ReviewboardcomentBiz;
import com.yaboja.biz.UserBiz;
import com.yaboja.dto.ReviewboardDto;
import com.yaboja.dto.ReviewboardcomentDto;
import com.yaboja.dto.UserDto;

@Controller
public class ReviewboardController {

   @Autowired
   UserBiz userBiz;
   @Autowired
   private CoinBiz coinBiz;
   @Autowired
   ReviewboardcomentBiz reviewboardcomentBiz;
   @Autowired
   private ReviewboardBiz reviewBiz;

   ///////////////// ////////////////// 후기 게시판
   ///////////////// /////////////////////////////////////

   @RequestMapping(value="/reviewboard.do")
      public String reviewboard(Model model,HttpSession session) {
         List<ReviewboardDto> reviewboardList = reviewBiz.selectList();
        
         List<UserDto> userList = new ArrayList<UserDto>();
         
         for(int i = 0 ; i < reviewboardList.size() ; i ++) {
            userList.add(userBiz.selectOne1(String.valueOf(reviewboardList.get(i).getUserseq())));
         }
         System.out.println("///글제목:"+reviewboardList.size());
         System.out.println("///유저시퀀스:"+userList.size());
         
         model.addAttribute("reviewboardList",reviewboardList);
         model.addAttribute("userList",userList);
         
         return "review_board";
      }
         
      @RequestMapping(value="/review_Insertform.do")
      public String insertform(Model model,ReviewboardDto dto,HttpSession session) {
         UserDto userdto = (UserDto)session.getAttribute("dto");
         String a = userdto.getUsername();
            System.out.println(a + "글쓰기 진입");
            return "review_Insert";
      }

   // 다중파일업로드
   @RequestMapping(value = "/multiplePhotoUpload.do")
   public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
      try {

         // 파일정보
         String sFileInfo = "";
         String sFileInfo1 = "";
         // 파일명을 받는다 - 일반 원본파일명
         String filename = request.getHeader("file-name");
         // 파일 확장자
         String filename_ext = filename.substring(filename.lastIndexOf(".") + 1);
         // 확장자를소문자로 변경
         filename_ext = filename_ext.toLowerCase();
         // 파일 기본경로
         String dftFilePath = request.getSession().getServletContext().getRealPath("/");
         // 파일 기본경로 _ 상세경로

         String filePath1 = "C:/Users/dlckd/git/yaboja/FinalProject/src/main/webapp/resource/photo_upload/";

         // String filePath1 =
         // "C:/Workspace_Spring/FinalProject/src/main/webapp/resource/photo_upload/";
         String filePath = dftFilePath + "resource" + File.separator + "photo_upload" + File.separator;

         File file = new File(filePath);
         if (!file.exists()) {
            file.mkdirs();
         }

         File file1 = new File(filePath1);
         if (!file1.exists()) {
            file1.mkdirs();
         }

         String realFileNm = "";
         SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
         String today = formatter.format(new java.util.Date());
         realFileNm = today + UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
         String rlFileNm = filePath + realFileNm;
         String rlFileNm1 = filePath1 + realFileNm;
         ///////////////// 서버에 파일쓰기 /////////////////
         InputStream is = request.getInputStream();
         OutputStream os = new FileOutputStream(rlFileNm);
         OutputStream os1 = new FileOutputStream(rlFileNm1);
         int numRead;
         byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];

         while ((numRead = is.read(b, 0, b.length)) != -1) {
            os.write(b, 0, numRead);
            os1.write(b, 0, numRead);
         }

         if (is != null) {
            is.close();
         }
         os.flush();
         os.close();
         os1.flush();
         os1.close();
         ///////////////// 서버에 파일쓰기 /////////////////
         // 정보 출력
         sFileInfo += "&bNewLine=true";
         
         // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
         sFileInfo += "&sFileName=" + filename;
         sFileInfo += "&sFileURL=" + "/controller/resource/photo_upload/" + realFileNm;
         PrintWriter print = response.getWriter();
         print.print(sFileInfo);
         print.flush();
         print.close();

      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   @RequestMapping(value = "/review_Insert.do")
    public void insert(Model model, ReviewboardDto dto, HttpSession session, HttpServletResponse response) throws IOException {
       UserDto userdto = (UserDto) session.getAttribute("dto");
       model.addAttribute("reviewboarddto", reviewBiz.insert(dto));
       model.addAttribute("list", reviewBiz.selectList());
       
       response.sendRedirect("reviewboard.do");

    }
 
 @RequestMapping(value="/review_detail.do")
 public String detail(int reviewboardseq,Model model,ReviewboardDto dto) {
    ReviewboardDto reviewboarddto = reviewBiz.selectOne(reviewboardseq);
    
    
    model.addAttribute("reviewboarddto",reviewboarddto);
    model.addAttribute("userdto",userBiz.selectOne1(String.valueOf(reviewboarddto.getUserseq())));
    
    System.out.println("detail : " + reviewboardseq);
    return "review_detail";
 }
 
 @RequestMapping(value="/review_updateform.do", method = RequestMethod.POST)
 public String updateform(Model model, int reviewboardseq) {
 ReviewboardDto reviewboarddto = reviewBiz.selectOne(reviewboardseq);
    
    
    model.addAttribute("reviewboarddto",reviewboarddto);
    model.addAttribute("userdto",userBiz.selectOne1(String.valueOf(reviewboarddto.getUserseq())));
    System.out.println("updateform : " + reviewboardseq);
    return "review_update";
    
 }
 
 @RequestMapping(value="/review_update.do")
 public String update(Model model, ReviewboardDto dto, int reviewboardseq) {
    int res = reviewBiz.update(dto);
    System.out.println(reviewboardseq);
    
    if(res>0) {
       System.out.println("수정성공");
       model.addAttribute("reviewboarddto",reviewBiz.selectOne(reviewboardseq));
       return "review_detail";
    }
    System.out.println("수정실패");
    return "review_update";
 }
 
 @RequestMapping(value="/reviewDelete.do")
 public String delete(Model model, int reviewboardseq) {
    int res = reviewBiz.delete(reviewboardseq);
    
    if(res>0) {
       System.out.println("삭제성공");
       model.addAttribute("list",reviewBiz.selectList());
       return "review_board";
    }else {
       System.out.println("삭제실패");
       model.addAttribute("reviewboarddto",reviewBiz.selectOne(reviewboardseq));
       return "review_detail";
    }
 }

   
   
   
   
   
   
   /////////////////////////////////////////////////////////////////////////////////   댓 글 ///////////////////////////////////////
   
   
   
   
   
   

   @RequestMapping("/coment_list.do") // 댓글 리스트
   @ResponseBody
   private List<ReviewboardcomentDto> mCommentServiceList(Model model, int reviewboardseq) throws Exception {

      return reviewboardcomentBiz.commentList(reviewboardseq);
   }

   @RequestMapping("/coment_insert.do") // 댓글 작성
   @ResponseBody
   private int mCommentServiceInsert(@RequestParam int reviewboardseq, @RequestParam String reviewboardcomentcontent,
         HttpSession session) throws Exception {
      UserDto userdto = (UserDto) session.getAttribute("dto");
      ReviewboardcomentDto comment = new ReviewboardcomentDto();
   
   
      comment.setReviewboardseq(reviewboardseq);
      comment.setReviewboardcomentcontent(reviewboardcomentcontent);
      // 로그인 기능을 구현했거나 따로 댓글 작성자를 입력받는 폼이 있다면 입력 받아온 값으로 사용하면 됩니다. 저는 따로 폼을 구현하지
      // 않았기때문에 임시로 "test"라는 값을 입력해놨습니다.
      comment.setUsername(userdto.getUsername());
      comment.setUserseq(userdto.getUserseq());
      
      //userdto.getUsername();

      return reviewboardcomentBiz.commentInsert(comment);
   }

   @RequestMapping("/coment_update.do") // 댓글 수정
   @ResponseBody
   private int mCommentServiceUpdateProc(@RequestParam int reviewboardcomentseq,
         @RequestParam String reviewboardcomentcontent) throws Exception {

      ReviewboardcomentDto comment = new ReviewboardcomentDto();
      comment.setReviewboardcomentseq(reviewboardcomentseq);
      comment.setReviewboardcomentcontent(reviewboardcomentcontent);

      return reviewboardcomentBiz.commentUpdate(comment);
   }

   @RequestMapping("/coment_delete.do") // 댓글 삭제
   @ResponseBody
   private int mCommentServiceDelete(@RequestParam int reviewboardcomentseq) throws Exception {

      return reviewboardcomentBiz.commentDelete(reviewboardcomentseq);
   }
}