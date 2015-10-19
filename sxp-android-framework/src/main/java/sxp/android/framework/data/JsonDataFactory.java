package sxp.android.framework.data;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * @author shanxiaoping
 * json 工具类
 */
public class JsonDataFactory {
	public static <T extends BaseData> T getJsonData(String jsonStr, Class<T> classObj) {
		T t = null;
		try {
		    JSONObject jo = new JSONObject(jsonStr);
			t = classObj.newInstance();
			t.parser(jo);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return t;
	}
	
	public static <T extends BaseData> ArrayList<T> getJsonDataArray(String jsonStr,Class<T> classObj){
		ArrayList<T> list = new ArrayList<T>();
		try {
			JSONArray ja = new JSONArray(jsonStr);
			for(int i = 0;i < ja.length();i++){
				JSONObject jo = ja.getJSONObject(i);
				T t = classObj.newInstance();
				t.parser(jo);
				list.add(t);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
