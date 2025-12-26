package com.haruclass.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.haruclass.model.BoardDTO;
import com.haruclass.model.SessionInfo;
import com.haruclass.mvc.annotation.Controller;
import com.haruclass.mvc.annotation.GetMapping;
import com.haruclass.mvc.annotation.PostMapping;
import com.haruclass.mvc.annotation.RequestMapping;
import com.haruclass.mvc.view.ModelAndView;
import com.haruclass.service.BoardService;
import com.haruclass.service.BoardServiceImpl;
import com.haruclass.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/bbs/*")
public class BoardController {
	private BoardService service = new BoardServiceImpl();
	private MyUtil util = new MyUtil();
	
	// @RequestMapping(value = "list", method = RequestMethod.GET)
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("bbs/list");
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			kwd = util.decodeUrl(kwd);
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			// 전체 데이터 개수
			dataCount = service.dataCount(map);
			
			total_page = util.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			// 게시글 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<BoardDTO> list = service.listBoard(map);
			
			// 페이징
			String query = "";
			String cp = req.getContextPath();
			String listUrl = cp + "/bbs/list";
			String articleUrl = cp + "/bbs/article?page=" + current_page;
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
				
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			// 포워딩할 JSP에 전달할 속성
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		// 글쓰기 폼
		ModelAndView mav = new ModelAndView("bbs/write");
		mav.addObject("mode", "write");
		return mav;
	}
	
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		// 글 저장
		HttpSession session = req.getSession();
		
		// 로그인 유저 정보
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			BoardDTO dto = new BoardDTO();
			
			// userId는 세션에 저장된 정보
			dto.setUserId(info.getUserId());
			
			// 파라미터
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			service.insertBoard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/bbs/list");
	}
	
	@GetMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 넘어오는 파라미터 : 글번호, 페이지번호[, 검색컬럼, 검색값]
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			service.updateHitCount(num);
			
			BoardDTO dto = service.findById(num);
			if(dto == null) {
				return new ModelAndView("redirect:/bbs/list?" + query);
			}
			dto.setContent(util.htmlSymbols(dto.getContent()));
			
			// 이전/다음 글
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("num", num);
			
			BoardDTO prevDto = service.findByPrev(map);
			BoardDTO nextDto = service.findByNext(map);
			
			ModelAndView mav = new ModelAndView("bbs/article");
			
			// jsp에 전달할 속성
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/bbs/list?" + query);
	}
	
	@GetMapping("update")	
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
				
		String page = req.getParameter("page");
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			BoardDTO dto = service.findById(num);
			if(dto == null || ! info.getUserId().equals(dto.getUserId())) {
				return new ModelAndView("redirect:/bbs/list?page=" + page);
			}
			
			ModelAndView mav = new ModelAndView("bbs/write");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return new ModelAndView("redirect:/bbs/list?page=" + page);
		
	}
	
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		try {
			BoardDTO dto = new BoardDTO();
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			dto.setUserId(info.getUserId());
			
			service.updateBoard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/bbs/list?page=" + page);
	}	
	
	@GetMapping("delete")	
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
				
		String page = req.getParameter("page");
		String query = "page" + page;
				
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("num", num);
			map.put("userId", info.getUserId());
			map.put("userLevel", info.getUserLevel());
			
			service.deleteBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/bbs/list?" + query);
	}
	
}
