package com.yaboja.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yaboja.bizImpl.MovieBizImpl;
import com.yaboja.dto.MovieDto;




@Controller

public class MovieController {

	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private MovieBizImpl biz;
	
	MovieDto dto;
		
	@RequestMapping(value = "/movieBoard.do", method = RequestMethod.GET)
	public String getPresentMovie(Model model) {
		
		List<MovieDto> movies = biz.selectPresentMovies();
		
		for(MovieDto movie : movies) {
			System.out.println(movie);
		}		
		
		model.addAttribute("list", movies);
		
		return "movieBoard/presentMovie";
	}
	
	@RequestMapping(value = "/endMovie.do", method = RequestMethod.GET)
	public String getEndMovie(Model model) {
		
		List<MovieDto> movies = biz.selectEndMovies();
		
		for(MovieDto movie : movies) {
			System.out.println(movie);
		}		
		
		model.addAttribute("list", movies);
		
		return "movieBoard/endMovie";
	}
	
	@RequestMapping(value = "/loadMovie.do", method = RequestMethod.GET)//영화 크롤링 및 저장
	@ResponseBody
	public String savePresentMovie() {
		
		
		System.out.println("loadMovie 잘왔당");
		
		int res = biz.insert();
		if (res > 0) {
			System.out.println(res +"개 삽입 성공!!");
		}else {
			System.out.println("삽입 영화 없음");
		}	
		
		return "ok";
	}
	
}