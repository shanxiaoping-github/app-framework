package sxp.android.framework.application;

import java.util.List;

import sxp.android.framework.configuration.Configuration;
import sxp.android.framework.exception.CrashHandler;
import sxp.android.framework.manager.ActivityManager;
import android.app.ActivityManager.RunningAppProcessInfo;
import android.app.ActivityManager.RunningTaskInfo;
import android.app.Application;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.view.WindowManager;

/**
 * 程序类
 * 
 * @author xiaoping.shan
 * 
 */
public class SXPApplication extends Application {

	private static SXPApplication instance;//实例
	private static Context context;//上下文
	private static WindowManager wm = null;// 窗口管理类

	private SXPRuntimeContext sxpRuntimeContext;// 运行时上下文
	private SXPConfigurationContext sxpConfigurationContext;// 持久化上下文
	

	@Override
	public void onCreate() {
		// TODO Auto-generated method stub
		super.onCreate();
		// 获得实例
		instance = this;
		// 获得上下文
		context = getApplicationContext();
		sxpRuntimeContext = new SXPRuntimeContext();
		sxpConfigurationContext = new SXPConfigurationContext(context, this);
		// 程序异常处理
		if(isExceptionDeal()){
			CrashHandler crashHandler = CrashHandler.getInstance();
			crashHandler.init(context);
		}
		// 加载配置文件
		Configuration.getInstance();
	}

	/**
	 * 是否异常处理
	 * @return
	 */
	public boolean isExceptionDeal(){
		return true;
	}
	
	/**
	 * 获取运行时上下文
	 * 
	 * @return
	 */
	public SXPRuntimeContext getSXPRuntimeContext() {
		if (sxpRuntimeContext == null) {
			sxpRuntimeContext = new SXPRuntimeContext();
		}
		return sxpRuntimeContext;

	}

	/**
	 * 获取持久化上下文
	 * 
	 * @return
	 */
	public SXPConfigurationContext getSXPConfigurationContext() {
		if (sxpConfigurationContext == null) {
			sxpConfigurationContext = new SXPConfigurationContext(context, this);
		}
		return sxpConfigurationContext;

	}

	/**
	 * 返回程序单列
	 * 
	 * @return
	 */
	public static SXPApplication getInstance() {
		return instance;
	}

	/**
	 * 获得程序上下文
	 * 
	 * @return
	 */
	public static Context getAppContext() {
		return SXPApplication.context;
	}

	/**
	 * 获得窗口管理
	 * 
	 * @param context
	 * @return
	 */
	public static WindowManager getWindowManager(Context context) {
		if (wm == null) {
			wm = (WindowManager) context
					.getSystemService(Context.WINDOW_SERVICE);
		}
		return wm;
	}

	/**
	 * 获得屏幕宽
	 * 
	 * @param context
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static int getWindowWidth(Context context) {
		WindowManager wm = getWindowManager(context);
		return wm.getDefaultDisplay().getWidth();
	}

	/**
	 * 获得屏幕高
	 * 
	 * @param context
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static int getWindowHeight(Context context) {
		WindowManager wm = getWindowManager(context);
		return wm.getDefaultDisplay().getHeight();
	}

	/**
	 * 退出程序
	 */

	public static void outApp(boolean isSafe) {
		ActivityManager.getInstance().finishActivity();
		android.os.Process.killProcess(android.os.Process.myPid());
		System.exit(0);
	}

	/**
	 * 获取程序版本号
	 * 
	 * @param context
	 * @return
	 */
	public static String getApplicationVersion(Context context) {

		try {
			PackageManager manager = context.getPackageManager();
			PackageInfo info = manager.getPackageInfo(context.getPackageName(),
					0);
			String version = String.valueOf(info.versionCode);
			return version;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	/**
	 * 获得版本描述
	 * 
	 * @param context
	 * @return
	 */
	public static String getApplicationVersionName(Context context) {
		try {
			PackageManager manager = context.getPackageManager();
			PackageInfo info = manager.getPackageInfo(context.getPackageName(),
					0);

			return info.versionName;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * 判断当前应用程序处于前台还是后台
	 */
	public static boolean isBackground(Context context) {

		android.app.ActivityManager activityManager = (android.app.ActivityManager) context
				.getSystemService(Context.ACTIVITY_SERVICE);
		List<RunningAppProcessInfo> appProcesses = activityManager
				.getRunningAppProcesses();
		for (RunningAppProcessInfo appProcess : appProcesses) {
			if (appProcess.processName.equals(context.getPackageName())) {
				if (appProcess.importance == RunningAppProcessInfo.IMPORTANCE_BACKGROUND) {
					// Log.i("后台", appProcess.processName);
					return true;
				} else {
					// Log.i("前台", appProcess.processName);
					return false;
				}
			}
		}
		return false;
	}

	public static void intoForeground() {
		try {
			android.app.ActivityManager manager = (android.app.ActivityManager) context
					.getSystemService(Context.ACTIVITY_SERVICE);
			List<RunningTaskInfo> task_info = manager.getRunningTasks(20);
			String className = "";

			for (int i = 0; i < task_info.size(); i++) {

				if (SXPApplication.getAppContext().getPackageName()
						.equals(task_info.get(i).topActivity.getPackageName())) {

					className = task_info.get(i).topActivity.getClassName();

					// 这里是指从后台返回到前台 前两个的是关键
					Intent intent = new Intent();
					intent.setAction(Intent.ACTION_MAIN);
					intent.addCategory(Intent.CATEGORY_LAUNCHER);
					intent.setComponent(new ComponentName(context, Class
							.forName(className)));

					intent.addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
							| Intent.FLAG_ACTIVITY_NEW_TASK
							| Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED);
					context.startActivity(intent);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
