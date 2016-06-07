package osf;

import java.util.List;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;

import redis.clients.jedis.Jedis;

public class RedisTest {
	private Jedis jedis; 
	HashOperations<String, String, Integer> hashOps;
	ListOperations<String, Integer> listOps;
	@Before
	public void connection(){
		ApplicationContext ac=new ClassPathXmlApplicationContext("spring/app-config.xml");
		RedisTemplate<String, String> rt=(RedisTemplate)ac.getBean("redisTemplate");
		RedisTemplate<String, Integer> rt1=(RedisTemplate)ac.getBean("redisTemplate");
		hashOps=rt.opsForHash();
		listOps=rt1.opsForList();
		jedis=new Jedis("localhost");
	}
	
	@Test
	public void connectionRedis(){
		System.out.println("server is running "+jedis.ping());
	}
	
	@Test
	public void RedisString(){
		jedis.set("first", "first_1");
		System.out.println(jedis.get("first"));
	}
	
	@Test
	public void RedisList(){
		jedis.lpush("firstList", "abc","edf","bbb");
		jedis.lpush("secondList", "hif");
		
		//start and end  类似于栈，后进先出
		List<String> list=jedis.lrange("firstList", 0, 1);
		for(String a :list){
			System.out.println(a);
		}
	}
	
	@Test
	public void RedisGetAllKeys(){
		Set<String> set=jedis.keys("*");
		for(String a : set){
			System.out.println(a);
			//not right code?
			System.out.println(jedis.hget(a, "system"));
		}
	}
	
	@Test
	public void RedisHashOps(){
		Set<String> set=jedis.keys("*");
		for(String a : set){
			System.out.println(hashOps.get(a, "system"));
		}
	}
	
	@Test
	public void RedisListOps(){
		for(Integer a : listOps.range("feed:user:26", 0, 10)){
			System.out.println(a);
		}
	}
}
