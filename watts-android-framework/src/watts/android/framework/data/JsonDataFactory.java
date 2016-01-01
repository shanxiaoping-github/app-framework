package watts.android.framework.data;

import java.lang.reflect.Type;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * @author shanxiaoping
 * json 工具类
 */
public class JsonDataFactory {
	public static <T> T getJsonData(String jsonStr, Class<T> classObj) {
		Gson gson = new Gson();
		return gson.fromJson(jsonStr,classObj);
	}
	
	public static <T> ArrayList<T> getJsonDataArray(String jsonStr,Class<T> classObj){
		Gson gson = new Gson();
		Type listType = new TypeToken<ArrayList<T>>() {
	    }.getType();
		return gson.fromJson(jsonStr,listType);
	}
	public static String getJsonStr(Object jsonObject){
		Gson gson = new Gson();
		return gson.toJson(jsonObject);
	} 
	
}
