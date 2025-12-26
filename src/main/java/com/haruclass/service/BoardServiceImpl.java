package com.haruclass.service;

import java.util.List;
import java.util.Map;

import com.haruclass.mapper.BoardMapper;
import com.haruclass.model.BoardDTO;
import com.haruclass.model.ReplyDTO;
import com.haruclass.mybatis.support.MapperContainer;

public class BoardServiceImpl implements BoardService {
	private BoardMapper mapper = MapperContainer.get(BoardMapper.class); 
	
	@Override
	public void insertBoard(BoardDTO dto) throws Exception {
		try {
			mapper.insertBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void updateBoard(BoardDTO dto) throws Exception {
		try {
			mapper.updateBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}	
	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		
			throw e;
		}	
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<BoardDTO> listBoard(Map<String, Object> map) {
		List<BoardDTO> list = null;
		try {
			list = mapper.listBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public BoardDTO findById(long num) {
		BoardDTO dto = null;
		
		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return dto;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public BoardDTO findByPrev(Map<String, Object> map) {
		BoardDTO dto = null;
		
		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return dto;
	}

	@Override
	public BoardDTO findByNext(Map<String, Object> map) {
		BoardDTO dto = null;
		
		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
				
		return dto;
	}

	@Override
	public boolean isUserBoardLike(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int countBoardLike(long num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertReply(ReplyDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCountReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ReplyDTO> listReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ReplyDTO findByReplyId(long replyNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReplyDTO> listReplyAnswer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCountReplyAnswer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertReplyLike(ReplyDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Map<String, Integer> countReplyLike(long replyNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateReplyShowHide(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int hasUserLikedReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
