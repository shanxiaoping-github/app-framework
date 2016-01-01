package watts.android.framework.util;

import java.util.UUID;

/**
 * 字符串工具类
 * 
 * @author Administrator
 * 
 */
public class StringUtil {
	/**
	 * 判断字符串是否为空
	 * @param content
	 * @return
	 */
	public static boolean isEmpty(String content) {
		if (null == content || "".equals(content) || " ".equals(content)) {
			return true;
		}

		return false;
	}
	
	public static boolean isNotEmpty(String content){
		return !isEmpty(content);
	}

	/**
	 * 判断json字符串是否为空
	 * 
	 * @param content
	 * @return
	 */
	public static boolean isJsonEmpty(String content) {
		if (null == content || "".equals(content) || " ".equals(content)
				|| "[]".equals(content) || "[ ]".equals(content)) {
			return true;
		}
		return false;
	}
	public static boolean isNotJsonEmpty(String content){
		return !isJsonEmpty(content);
	}

	/**
	 * 获取uiid
	 * 
	 * @return
	 */
	public static String getUIID() {
		UUID uuid = UUID.randomUUID();
		return uuid.toString();

	}

	/**
	 * 获取随机的uiid文件名
	 * 
	 * @return
	 */
	public static String getFileNameByUIID() {
		String uiidStr = getUIID();
		return uiidStr.replaceAll("-", "_");

	}

}
