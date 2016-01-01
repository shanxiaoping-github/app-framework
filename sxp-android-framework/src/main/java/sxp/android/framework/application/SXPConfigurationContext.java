package sxp.android.framework.application;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.StreamCorruptedException;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;
import android.util.Base64;

/**
 * 配置上下文
 * 
 * @author xiaoping.shan
 *
 */
public class SXPConfigurationContext implements SXPContext {
	private Context context;
	private Application application;
	private static SXPConfigurationContext instance;
	public static SXPConfigurationContext shareInstance(){
		if(null == instance){
			instance = new SXPConfigurationContext(SXPApplication.getAppContext(),SXPApplication.getInstance());
		}
		return instance;
	}

	private SXPConfigurationContext(Context context, Application application) {
		this.context = context;
		this.application = application;
	}
	

	public void savaData(String key,Object value) {
		// TODO Auto-generated method stub
		SharedPreferences sp = context.getSharedPreferences(
				application.getPackageName(), Context.MODE_PRIVATE);
		SharedPreferences.Editor editor = sp.edit();
		editor.putString(key,value.toString());
		editor.commit();
	}

	public String getData(String key){
		// TODO Auto-generated method stub
		SharedPreferences sp = context.getSharedPreferences(
				application.getPackageName(),Context.MODE_PRIVATE);
		return sp.getString(key, "");
	}
	

	/**
	 * 存储序列化对象
	 * 
	 * @param key
	 * @param object
	 */
	public void saveObject(String key, Object object) {

		// 创建字节输出流
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
			// 创建对象输出流，并封装字节流
			ObjectOutputStream oos = new ObjectOutputStream(baos);
			// 将对象写入字节流
			oos.writeObject(object);
			// 将字节流编码成base64的字符窜
			String oAuth_Base64 = new String(Base64.encode(baos.toByteArray(),
					Base64.DEFAULT));
			SharedPreferences sp = context.getSharedPreferences(
					application.getPackageName(), Context.MODE_PRIVATE);
			SharedPreferences.Editor editor = sp.edit();

			editor.putString(key, oAuth_Base64);

			editor.commit();
		} catch (IOException e) {
			// TODO Auto-generated
			e.printStackTrace();
		}

	}

	public Object readObject(String key) {
		SharedPreferences sp = context.getSharedPreferences(
				application.getPackageName(), Context.MODE_PRIVATE);
		Object object = null;
		String productBase64 = sp.getString(key, "");

		// 读取字节
		byte[] base64 = Base64.decode(productBase64.getBytes(), Base64.DEFAULT);

		// 封装到字节流
		ByteArrayInputStream bais = new ByteArrayInputStream(base64);
		try {
			// 再次封装
			ObjectInputStream bis = new ObjectInputStream(bais);
			try {
				// 读取对象
				object = bis.readObject();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (StreamCorruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return object;
	}


}
