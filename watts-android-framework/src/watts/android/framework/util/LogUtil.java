package watts.android.framework.util;

import watts.android.framework.configuration.Configuration;
import watts.android.framework.http.HttpRequest;
import android.app.Activity;
import android.util.Log;

/**
 * @ClassName: LogUtil
 * @Description: log工具类
 * @author shanxiaoping
 * @date 2016年1月1日 下午6:51:05
 */
public class LogUtil {
	public static void logVerbose(String tag, String msg) {
		if (Configuration.shareInstance().isDebug()) {
			Log.v(tag, msg);
		}
	}

	public static void logDebug(String tag, String msg) {
		if (Configuration.shareInstance().isDebug()) {
			Log.d(tag, msg);
		}
	}

	public static void logInfo(String tag, String msg) {
		if (Configuration.shareInstance().isDebug()) {
			Log.i(tag, msg);
		}
	}

	public static void logWarning(String tag, String msg) {
		if (Configuration.shareInstance().isDebug()) {
			Log.w(tag, msg);
		}
	}

	public static void logError(String tag, String msg) {
		if (Configuration.shareInstance().isDebug()) {
			Log.e(tag, msg);
		}
	}

	public static final String ActivityTag = "activity-log";

	public static void logActivityStart(Activity activity) {
		if (Configuration.shareInstance().isDebug()) {
			Log.i(ActivityTag, activity.getClass().getName() + "-创建\n");
		}
	}

	public static void logActivityEnd(Activity activity) {
		if (Configuration.shareInstance().isDebug()) {
			Log.i(ActivityTag, activity.getClass().getName() + "-销毁\n");
		}
	}

	public static void logActivityMsg(String msg) {
		if (Configuration.shareInstance().isDebug()) {
			Log.i(ActivityTag, msg + "\n");
		}
	}
	
	public static final String HttpTag = "http-log";
	public static void logHttpRequest(HttpRequest<?, ?, ?> httpRequest){
		if (Configuration.shareInstance().isDebug()) {
			Log.i(HttpTag,httpRequest.getClass().getName()+":url="+httpRequest.getUrl()+"?parame="+(null == httpRequest.getParams()?"无参":httpRequest.getParams().toString())+"-创建\n");
		}
	}
	public static void logHttpResponse(HttpRequest<?, ?, ?> httpRequest){
		if (Configuration.shareInstance().isDebug()) {
			Log.i(HttpTag,httpRequest.getClass().getName()+":url="+httpRequest.getUrl()+"?response="+(null == httpRequest.getHttpResponseModel()?"无响应":httpRequest.getHttpResponseModel().toString())+"-响应\n");
		}
	}
	public static void logHttpMsg(String msg){
		if (Configuration.shareInstance().isDebug()) {
			Log.i(HttpTag, msg+"\n");
		}
	}

}
