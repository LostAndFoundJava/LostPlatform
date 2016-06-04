package osf;

import com.qiniu.util.Auth;
import java.io.IOException;

import org.junit.Test;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;

public class UploadQiliuTest {
	// 设置好账号的ACCESS_KEY和SECRET_KEY
	String ACCESS_KEY = "9nHdP_-RehGtHG1nkzgCk7nqZHobTiruxxN7J5Em";
	String SECRET_KEY = "IiXbcXqGHAv0axkcm2xYJmvrga14ww0-8poeVsEZ";
	// 要上传的空间
	String bucketname = "teamwork";
	// 上传到七牛后保存的文件名
	String key = "my-java.png";
	// 上传文件的路径
	String FilePath = "C:/Users/cj/Desktop/404.jpg";

	// 密钥配置
	Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
	// 创建上传对象
	UploadManager uploadManager = new UploadManager();

	// 简单上传，使用默认策略，只需要设置上传的空间名就可以了
	public String getUpToken() {
		return auth.uploadToken(bucketname);
	}

	public void upload() throws IOException {
		try {
			// 调用put方法上传
			Response res = uploadManager.put(FilePath, key, getUpToken());
			// 打印返回的信息
			System.out.println(res.bodyString());
		} catch (QiniuException e) {
			Response r = e.response;
			// 请求失败时打印的异常的信息
			System.out.println(r.toString());
			try {
				// 响应的文本信息
				System.out.println(r.bodyString());
			} catch (QiniuException e1) {
				// ignore
			}
		}
	}

	
	String URL = "http://bucketdomain/key";
	public void download() {
		// 调用privateDownloadUrl方法生成下载链接,第二个参数可以设置Token的过期时间
		String downloadRUL = auth.privateDownloadUrl(URL, 3600);
		System.out.println(downloadRUL);
	}

	@Test
	public void DemoUpload() throws IOException {
		new UploadQiliuTest().upload();
	}

	@Test
	public void DemoDownload() {
		new UploadQiliuTest().download();
	}
}
