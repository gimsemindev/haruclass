package com.haruclass.controller;

import java.io.IOException;

import com.haruclass.mvc.annotation.Controller;
import com.haruclass.mvc.annotation.RequestMapping;
import com.haruclass.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("home/main");
		
		return mav;
	}
}
