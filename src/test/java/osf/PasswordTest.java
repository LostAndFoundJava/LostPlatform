package osf;

import org.junit.Test;

import com.lvwang.osf.util.CipherUtil;

public class PasswordTest {
	@Test
	public void passwordCheck(){
		System.out.println(CipherUtil.generatePassword("123456"));
	}
}
