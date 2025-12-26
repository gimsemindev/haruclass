package com.haruclass.mybatis.support;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

/*
  - Spring의 SqlSessionTemplate 역할
  - 요청(Thread)마다 SqlSession 1개
  - 트랜잭션 제어
*/
public class SqlSessionManager {
	private static SqlSessionFactory factory;
	// ThreadLocal : 스레드 단위로 독립적인 변수를 가질 수 있게 해주는 클래스
	private static final ThreadLocal<SqlSession> local = new ThreadLocal<>();

	public static void init(SqlSessionFactory f) {
		factory = f;
	}

	public static SqlSession getSession() {
		SqlSession session = local.get();
		if (session == null) {
			session = factory.openSession(false);
			local.set(session);
		}
		return session;
	}

	public static void commit() {
		SqlSession session = local.get();
		if (session != null)
			session.commit();
	}

	public static void rollback() {
		SqlSession session = local.get();
		if (session != null)
			session.rollback();
	}

	public static void close() {
		SqlSession session = local.get();
		if (session != null) {
			session.close();
			local.remove();
		}
	}
}
