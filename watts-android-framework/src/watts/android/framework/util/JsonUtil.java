package watts.android.framework.util;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * json工厂
 * 
 * @author xiaoping.shan
 *
 */
public class JsonUtil {
	/**
	 * 获取json String数据
	 * 
	 * @param jo
	 * @param key
	 *            键值
	 * @return
	 */
	public static String getJsonString(JSONObject jo, String key) {
		String value = "";
		try {
			value = jo.getString(key);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			return "";
		}

		return value;

	}

	/**
	 * 获取json boolean
	 * 
	 * @param jo
	 * @param key
	 * @return
	 */
	public static Boolean getJsonBoolean(JSONObject jo, String key) {
		boolean value = false;
		try {
			value = jo.getBoolean(key);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			return false;
		}
		
		return value;
	}
	
	/**
	 * 获得int
	 * @param jo
	 * @param key
	 * @return
	 */
	public static int getJsonInteger(JSONObject jo,String key){
		int value = 0;
		try {
			value = jo.getInt(key);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			return 0;
		}
		return value;
	}
	
	/**
	 * 获得double
	 * @param jo
	 * @param key
	 * @return
	 */
	public static double getJsonDouble(JSONObject jo,String key){
		double value = 0;
		try {
			value = jo.getDouble(key);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			return (double)0;
		}
		return value;
	}
	/**
	 * 获得long
	 * @param jo
	 * @param key
	 * @return
	 */
	public static long getJsonLong(JSONObject jo,String key){
		long value = 0;
		try {
			value = jo.getLong(key);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			return (long)0;
		}
		return value;
	}
}
