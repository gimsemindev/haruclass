package com.haruclass.service;

import java.util.List;
import java.util.Map;

import com.haruclass.model.BoardDTO;
import com.haruclass.model.ReplyDTO;

public interface BoardService {
	public void insertBoard(BoardDTO dto) throws Exception;
	public void updateBoard(BoardDTO dto) throws Exception;
	public void deleteBoard(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<BoardDTO> listBoard(Map<String, Object> map);
	public BoardDTO findById(long num);
	public void updateHitCount(long num) throws Exception;
	public BoardDTO findByPrev(Map<String, Object> map);
	public BoardDTO findByNext(Map<String, Object> map);
	
	public boolean isUserBoardLike(Map<String, Object> map);
	public void insertBoardLike(Map<String, Object> map) throws Exception;
	public void deleteBoardLike(Map<String, Object> map) throws Exception;
	public int countBoardLike(long num);
	
	public void insertReply(ReplyDTO dto) throws Exception;
	public void deleteReply(Map<String, Object> map) throws Exception;
	public int dataCountReply(Map<String, Object> map);
	public List<ReplyDTO> listReply(Map<String, Object> map);
	public ReplyDTO findByReplyId(long replyNum);
	public List<ReplyDTO> listReplyAnswer(Map<String, Object> map);
	public int dataCountReplyAnswer(Map<String, Object> map);
	
	public void insertReplyLike(ReplyDTO dto) throws Exception;
	public Map<String, Integer> countReplyLike(long replyNum);
	public void updateReplyShowHide(Map<String, Object> map);
	public int hasUserLikedReply(Map<String, Object> map);
}
