package sxp.android.framework.ui;

import java.lang.reflect.Field;
import java.util.HashMap;
import sxp.android.framework.annotation.ID;
import sxp.android.framework.annotation.LAYOUT;
import sxp.android.framework.annotation.RESOURE;
import sxp.android.framework.interfaces.LastActivityListener;
import sxp.android.framework.manager.ActivityManager;
import sxp.android.framework.util.StringUtil;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Toast;

/**
 * ui基类
 * 
 * @author xiaoping.shan
 * 
 */

public class BaseActivity extends FragmentActivity implements OnClickListener,LastActivityListener {
	//tag 
	private static final String TAG = "BaseActivity";
	//上下文 存储上下文数据
	private HashMap<String,Object> context;
	//将要传递的上下文
	private HashMap<String,Object> nextContext;
	
	protected void onCreate(Bundle savedInstanceState){
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
		//上下文数据传递
		LastActivityListener lastListener = ActivityManager.getInstance().peekDoesntMatterFinish();
		ActivityManager.getInstance().push(this);
		if(null!=lastListener){
			lastListener.intoNextActivity();
		}
		// 注入布局
		layoutContentView();
		// 初始化空间，注解方式
		initComponent();
		// 对ui进行模板布局,以及一些ui的界面初始化化，不包含数据
		layout();

		// 没有保存数据和重建的情况下
		if (savedInstanceState == null) {
			dataInit();
		} else {
			// 数据恢复
			dataRestore(savedInstanceState);
		}
		eventDispose();
		
	}

	/**
	 * 数据恢复
	 */
	protected void dataRestore(Bundle savedInstanceState){}

	/**
	 * 数据初始化
	 */
	protected void dataInit(){};

	/**
	 * 注入布局
	 */
	private void layoutContentView() {
		LAYOUT layoutAnnatation = this.getClass().getAnnotation(LAYOUT.class);
		if (layoutAnnatation != null) {
			int layoutValue = layoutAnnatation.value();
			if (layoutValue != -1) {
				setContentView(layoutValue);
			}
		}
	}

	/**
	 * 对ui进行模板布局,以及一些ui的界面初始化化，不包含数据
	 */
	protected void layout() {}

	/**
	 * 事件执行
	 */
	protected void eventDispose() {}

	/**
	 * 界面刷新
	 * 
	 * @param param
	 */
	protected void refesh(Object... param) {}

	/******************************** 【跳转到其他界面】 *******************************************/
	public void openActivity(Class<?> pClass) {
		openActivity(pClass,null,null,false);
	}
	public void openActivity(Class<?> pClass,boolean isFinish) {
		openActivity(pClass,null,null,isFinish);
	}
	public void openActivity(Class<?> pClass, Bundle pBundle) {
		openActivity(pClass,pBundle,null,false);
	}
	public void openActivity(Class<?> pClass, Bundle pBundle,boolean isFinish) {
		openActivity(pClass,pBundle,null,isFinish);
	}
	
	public void openActivity(Class<?> pClass,HashMap<String,Object> context){
		openActivity(pClass,null,context,false);
	}
	public void openActivity(Class<?> pClass,HashMap<String,Object> context,boolean isFinish){
		openActivity(pClass,null,context,isFinish);
	}
	
	public void openActivity(Class<?> pClass,Bundle pBundle,HashMap<String,Object> context){
		openActivity(pClass,pBundle,context,false);
	}
	public void openActivity(Class<?> pClass, Bundle pBundle,HashMap<String,Object> context,boolean isFinish) {
		Intent intent = new Intent(this, pClass);
		if (pBundle != null) {
			intent.putExtras(pBundle);
		}
		if(context != null){
			setNextContext(context);
		}
		startActivity(intent);
		if(isFinish){
			finishBase();
		}
	}
	
	
	
	
	

	public void openActivity(String pAction) {
		openActivity(pAction, null);
	}

	public void openActivity(String pAction, Bundle pBundle) {
		Intent intent = new Intent(pAction);
		if (pBundle != null) {
			intent.putExtras(pBundle);
		}
		startActivity(intent);
	}

	/******************************** 【跳转到子界面】 *******************************************/
	public void openActivityResult(Class<?> pClass, int requestCode) {
		openActivityResult(pClass, null, requestCode);
	}

	public void openActivityResult(Class<?> pClass) {
		openActivityResult(pClass, null);
	}

	public void openActivityResult(Class<?> pClass, Bundle pBundle) {
		openActivityResult(pClass, pBundle, 0);
	}

	public void openActivityResult(Class<?> pClass, Bundle pBundle,
			int requestCode) {
		Intent intent = new Intent(this, pClass);
		if (pBundle != null) {
			intent.putExtras(pBundle);
		}
		startActivityForResult(intent, requestCode);
	}

	/******************************** 【依赖注入view】 **************************************/
	protected void initComponent() {
		Class<? extends BaseActivity> clazz = this.getClass();
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields) {
			field.setAccessible(true);
			Class<?> type = field.getType();
			if (View.class.isAssignableFrom(type)) {
				// String idName = field.getName();
				// 如果字段上有注解则采用注解的id
				ID idAnnotation = field.getAnnotation(ID.class);
				if (idAnnotation != null) {
					int idValue = idAnnotation.value();
					if (idValue != -1) {
						View view = findViewById(idValue);
						if (view != null) {
							try {
								field.set(this, view);
								if (idAnnotation.isBindListener()) {
									view.setOnClickListener(this);
								}
							} catch (Exception e) {
								e.printStackTrace();
							}

						}
					}
				}
			}

			RESOURE resouceAnnotation = field.getAnnotation(RESOURE.class);
			if (resouceAnnotation != null) {
				String resouceValue = resouceAnnotation.value();
				if (!StringUtil.isEmpty(resouceValue)) {
					Object valueOb = getIntent().getExtras().get(resouceValue);
					if (valueOb != null) {
						try {
							field.set(this,valueOb);
						} catch (IllegalArgumentException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}

				}
			}
		}
	}

	/******************************** 【界面提示】 *******************************************/

	public void showShortToast(int pResId) {
		showShortToast(getString(pResId));
	}

	public void showLongToast(String pMsg) {
		Toast.makeText(this, pMsg, Toast.LENGTH_LONG).show();
	}

	public void showShortToast(String pMsg) {
		Toast.makeText(this, pMsg, Toast.LENGTH_SHORT).show();

	}
	
	/* 自定义清除 */
	public void finishBase() {
		clearContext();
		ActivityManager.getInstance().pop(this.getClass().getName());
	}
	/*************************************************【界面监听】************************************************/
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// TODO Auto-generated method stub
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			finishBase();
			return true;
		}
		return super.onKeyDown(keyCode, event);
	}

	@Override
	public void onClick(View v) {}
	/****************************************************【参数】****************************************************/

	public HashMap<String, Object> getContext() {
		return context;
	}
   
	public void setContext(HashMap<String, Object> context) {
		this.context = context;
	}
	
	
   
	public HashMap<String, Object> getNextContext() {
		return nextContext;
	}

	public void setNextContext(HashMap<String, Object> nextContext) {
		this.nextContext = nextContext;
	}

	public void putContext(String key,Object object){
		if(null == context){
			context = new HashMap<String, Object>();
		}
		context.put(key,object);
	}
	public Object getContext(String key){
		if(null==context){
			return null;
		}
		return context.get(key);
	}
	public void putContext(Object object){
		if(null!=object){
			String key = object.getClass().getName();
			putContext(key, object);
		}
	}
	@SuppressWarnings("unchecked")
	public <T> T getContext(Class<T> classObj){
		String key = classObj.getName();
		return (T)getContext(key);
	}
	
	public void putNextContext(String key,Object object){
		if(null == nextContext){
			nextContext = new HashMap<String, Object>();
		}
		nextContext.put(key,object);
	}
	public void putNextContext(Object object){
		putNextContext(object.getClass().getName(),object);
	}
	
	/**
	 * 清理上下文
	 */
	private void clearContext(){
		if(null!=context){
			context.clear();
			context = null;
		}
	}
	private void clearNextContext(){
		if(null!=nextContext){
			nextContext.clear();
			nextContext = null;
		}
	}
	
	public static String getTag() {
		return TAG;
	}

	@SuppressWarnings("unchecked")
	@Override
	public void intoNextActivity() {
		// TODO Auto-generated method stub
		if(null!=getNextContext()){
			BaseActivity nextActivity = ActivityManager.getInstance().peek();
			if(null!=nextActivity){
				nextActivity.setContext((HashMap<String,Object>)getNextContext().clone());
				clearNextContext();
			}
		}
		
	}
	
	
}
