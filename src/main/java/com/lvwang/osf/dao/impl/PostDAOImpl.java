package com.lvwang.osf.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.lvwang.osf.dao.PostDAO;
import com.lvwang.osf.model.Post;
import com.lvwang.osf.service.TagService;

@Repository("postDao")
public class PostDAOImpl implements PostDAO{

	protected static final String TABLE = "osf_posts"; 
	
	@Autowired
	protected JdbcTemplate jdbcTemplate;
	
	public Post getPostByID(int id) {
		String sql = "select * from " + TABLE + " where id=?";
		Post post = jdbcTemplate.query(sql, new Object[]{id}, new ResultSetExtractor<Post>(){

			public Post extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				Post post = null;
				if(rs.next()) {
					post = new Post();
					post.setId(rs.getInt("id"));
					post.setPost_author(rs.getInt("post_author"));
					post.setPost_ts(rs.getTimestamp("post_ts"));
					post.setPost_title(rs.getString("post_title"));
					post.setPost_content(rs.getString("post_content"));
					post.setPost_excerpt(rs.getString("post_excerpt"));
					post.setPost_lastts(rs.getTimestamp("post_lastts"));
					post.setPost_tags(TagService.toList(rs.getString("post_tags")));
					post.setComment_count(rs.getInt("comment_count"));
				}
				return post;
			}						
		});
		return post;
	}

	public List<Post> getPostsByIDs(int[] ids) {
		return null;
	}

	public List<Post> getPostsByUserID(int id) {
		String sql = "select * from " + TABLE + " where post_author=? and post_title is not null";
		List<Post> posts = jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Post>(){

			@SuppressWarnings("deprecation")
			public Post mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Post post = new Post();
				post.setId(rs.getInt("id"));
				post.setComment_count(rs.getInt("comment_count"));
				post.setComment_status(rs.getInt("comment_status"));
				post.setLike_count(rs.getInt("like_count"));
				post.setPost_author(rs.getInt("post_author"));
				post.setPost_excerpt(rs.getString("post_excerpt"));
				//post.setPost_lastts(new Date(rs.getTimestamp("post_lastts").getTime()));
				System.out.println(rs.getTimestamp("post_lastts").getTime());
				post.setPost_status(rs.getInt("post_status"));
				post.setPost_title(rs.getString("post_title"));
				post.setPost_ts(rs.getTimestamp("post_ts"));
				post.setShare_count(rs.getInt("share_count"));
				post.setPost_cover(rs.getString("post_cover"));
				post.setPost_tags(TagService.toList(rs.getString("post_tags")));
				return post;
			}
			
		});
		return posts;
	}
	

	public int save(final Post post) {
		final String sql = "insert into " + TABLE + 
					 "(post_author, post_title, post_content,"
					 + "post_excerpt, post_status,"
					 + "post_pwd, comment_status, post_tags, post_cover,post_lastts)"
					 + " values(?,?,?,?,?,?,?,?,?,?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql, new String[]{"id"});
				ps.setInt(1, post.getPost_author());
				ps.setString(2, post.getPost_title());
				ps.setString(3, post.getPost_content());
				ps.setString(4, post.getPost_excerpt());
				ps.setInt(5, post.getPost_status());
				ps.setString(6, post.getPost_pwd());
				ps.setInt(7, post.getComment_status());
				ps.setString(8, TagService.toString(post.getPost_tags()));
				ps.setString(9, post.getPost_cover());
				ps.setTimestamp(10, new Timestamp(new Date().getTime()));
				return ps;
			}
		}, keyHolder);
		return keyHolder.getKey().intValue();
	}

	public void delete(int id) {
		String sql = "delete from " + TABLE + " where id=?";
		jdbcTemplate.update(sql, new Object[]{id});
		
	}

	public int getAuthorOfPost(int id) {
		final String sql = "select * from " + TABLE + " where id=?";
		return jdbcTemplate.query(sql, new Object[]{id}, new ResultSetExtractor<Integer>(){

			public Integer extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				int user_id = 0;
				if(rs.next()) {
					user_id = rs.getInt("post_author");
				}
				return user_id;
			}
			
		});

	}
	
	public long count(int user_id){
		final String sql = "select count(1) counter from " + TABLE + " where post_author=? and post_title is not null";
		return (long) jdbcTemplate.query(sql, new Object[]{user_id}, new ResultSetExtractor<Integer>(){

			public Integer extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				int user_id = 0;
				if(rs.next()) {
					user_id = rs.getInt("counter");
				}
				return user_id;
			}
			
		});
	}
	
}
