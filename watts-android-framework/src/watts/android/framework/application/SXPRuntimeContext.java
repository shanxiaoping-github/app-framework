package watts.android.framework.application;

import java.util.HashMap;
import java.util.Map;

/**
 * 运行时上下文
 * 
 * @author xiaoping.shan
 *
 */
public class SXPRuntimeContext implements SXPContext {
	private SXPRuntimeContext(){}
	private static SXPRuntimeContext sxpRuntimeContext;
	public static SXPRuntimeContext sharedInstance(){
		if(null == sxpRuntimeContext){
			sxpRuntimeContext = new SXPRuntimeContext(); 
		}
		return sxpRuntimeContext;
	}
	
	private Map<String, Object> map;

	public void savaData(String key, Object value) {
		// TODO Auto-generated method stub
		if (map == null) {
			map = new HashMap<String, Object>();
		}
		map.put(key, value);
	}

	public void savaData(Object value) {
		savaData(value.getClass().getName(), value);
	}

	public Object getData(String key) {
		// TODO Auto-generated method stub
		if (map == null) {
			return null;
		}
		if (map.containsKey(key)) {
			return map.get(key);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public <T> T getData(Class<T> className) {
		if (map == null) {
			return null;
		}
		if (map.containsKey(className.getName())) {
			return (T) map.get(className.getName());
		}
		return null;
	}

}
