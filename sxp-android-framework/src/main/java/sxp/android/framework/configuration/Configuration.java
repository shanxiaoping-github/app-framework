package sxp.android.framework.configuration;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import sxp.android.framework.application.SXPApplication;
import sxp.android.framework.util.StringUtil;
import android.content.Context;

/**
 * @ClassName: Configuration
 * @Description: 项目基础数据配置
 * @author shanxiaoping
 * @date 2015年12月31日 下午5:47:39
 */
public class Configuration extends Properties {
	/**
	 * @Fields serialVersionUID : TODO
	 */
	private static final long serialVersionUID = 1L;
	public static final String PROPERTIES_FILE_NAME = "properties";// 配置文件
	public static final String SERVICE_ADRESS = "serviceAddress";// 服务器地址
	public static final String SQLITE_DB_NAME = "sqliteDbName";// 数据库DB文件
	public static final String DEBUG = "debug";// 是否调试状态
	public static final String SIGN_KEY = "signKey";// 签名key

	// 保证私有构造
	private Configuration() {
	}

	// 单例
	private static Configuration instance = null;

	public static Configuration shareInstance() {
		if (null == instance) {
			instance = new Configuration();
			instance.loadProperties(SXPApplication.getAppContext(),
					PROPERTIES_FILE_NAME);
		}
		return instance;
	}

	/**
	 * @Title load
	 * @Description 加载
	 * @return void
	 * @author shanxiaoping
	 * @data 2016年1月1日
	 */
	public static void load() {
		shareInstance();
	}

	/**
	 * 加载配置地址
	 * 
	 * @param context
	 * @param path
	 */
	private void loadProperties(Context context, String path) {
		try {
			InputStream in = context.getAssets().open(path);
			load(in);
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @Title isDebug
	 * @Description 是否是debug配置
	 * @return boolean
	 * @author shanxiaoping
	 * @data 2016年1月1日
	 */
	public boolean isDebug() {
		if (StringUtil.isNotEmpty(getProperty(DEBUG))
				&& getProperty(DEBUG).equalsIgnoreCase("true")) {
			return true;
		}
		return false;
	}

	/**
	 * @Title baseServiceUrl
	 * @Description 获取基本服务器地址
	 * @return String
	 * @author shanxiaoping
	 * @data 2016年1月1日
	 */
	public String baseServiceUrl() {
		return getProperty(SERVICE_ADRESS, "");
	}

	/**
	 * @Title signKey
	 * @Description 签名key
	 * @return String
	 * @author shanxiaoping
	 * @data 2016年1月1日
	 */
	public String signKey() {
		return getProperty(SIGN_KEY, "");
	}
}
