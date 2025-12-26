package com.haruclass.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.haruclass.model.BoardDTO;
import com.haruclass.model.ReplyDTO;

public interface BoardMapper {
	public void insertBoard(BoardDTO dto) throws SQLException;
	public void updateBoard(BoardDTO dto) throws SQLException;
	public void deleteBoard(Map<String, Object> map) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<BoardDTO> listBoard(Map<String, Object> map);
	public BoardDTO findById(long num);
	public void updateHitCount(long num) throws SQLException;
	public BoardDTO findByPrev(Map<String, Object> map);
	public BoardDTO findByNext(Map<String, Object> map);
	
	public boolean isUserBoardLike(Map<String, Object> map);
	public void insertBoardLike(Map<String, Object> map) throws SQLException;
	public void deleteBoardLike(Map<String, Object> map) throws SQLException;
	public int countBoardLike(long num);
	
	public void insertReply(ReplyDTO dto) throws SQLException;
	public void deleteReply(Map<String, Object> map) throws SQLException;
	public int dataCountReply(Map<String, Object> map);
	public List<ReplyDTO> listReply(Map<String, Object> map);
	public ReplyDTO findByReplyId(long replyNum);
	public List<ReplyDTO> listReplyAnswer(Map<String, Object> map);
	public int dataCountReplyAnswer(Map<String, Object> map);
	
	public void insertReplyLike(ReplyDTO dto) throws SQLException;
	public Map<String, Integer> countReplyLike(long replyNum);
	public void updateReplyShowHide(Map<String, Object> map);
	public int hasUserLikedReply(Map<String, Object> map);
}
