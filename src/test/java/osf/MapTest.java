package osf;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

public class MapTest {
	@Test
	public void MapDemo(){
		Map<String, String> map = new HashMap<>();
		map.put("a", "1");
		map.put("b", "2");
		map.put("c", "3");
		
		Collection<String> list=map.values();
		for(String temp : list){
			System.out.println(temp);
		}
	}
}
