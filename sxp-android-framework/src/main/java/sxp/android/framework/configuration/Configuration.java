package sxp.android.framework.configuration;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import sxp.android.framework.application.SXPApplication;
import android.content.Context;

/**
 * 项目基础配置类
 * 
 * @author Administrator
 * 
 */
public class Configuration extends Properties {
    

	public static final String SERVICE_ADRESS="serviceAddress";//服务器地址
	public static final String PROPERTIES_FILE_NAME = "properties";//配置文件
	public static final String SQLITE_DB_NAME = "sqliteDbName";//数据库DB文件
	private static final long serialVersionUID = 1L;
	
	private Configuration() {}// 保证私有构造

	private static Configuration instance = null;// 单例

	public static Configuration getInstance() {
		if (instance == null) {
			instance = new Configuration();
			instance.loadProperties(SXPApplication.getAppContext(),PROPERTIES_FILE_NAME);
		}
		return instance;
	}

	/**
	 * 加载配置地址
	 * 
	 * @param context
	 * @param path
	 */
	public void loadProperties(Context context, String path) {
		try {
			InputStream in = context.getAssets().open(path);
			load(in);
			in.close();
		} catch (IOException e){
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
