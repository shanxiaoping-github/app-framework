package sxp.android.framework.manager;

import java.util.HashMap;
import java.util.Stack;

import sxp.android.framework.ui.BaseActivity;

/**
 * ui界面管理
 * 
 * @author xiaoping.shan
 * 
 */
public class ActivityManager {
	
	private ActivityManager(){}
	private static ActivityManager instance = null;
	public static ActivityManager getInstance() {
		if (instance == null) {
			instance = new ActivityManager();
		}
		return instance;
	}

	private final Stack<BaseActivity> stack = new Stack<BaseActivity>();// activity栈
	private final HashMap<String,BaseActivity> activityMap = new HashMap<String, BaseActivity>();// 键值activity

	/**
	 * 返回最顶端的activity,并弹出删除
	 * 
	 * @return
	 */
	public void pop() {
		if(stack.isEmpty()){
			return;
		}
		BaseActivity activity = stack.pop();
		if(null!=activity){
			activityMap.remove(activity.getClass().getName());
			if(!activity.isFinishing()){
				activity.finish();
			}
		}
	}

	/* 添加activity */
	public void push(BaseActivity activity) {
		if(null!=activity&&!activity.isFinishing()){
			stack.push(activity);
			activityMap.put(activity.getClass().getName(), activity);
		}
	}

	/* 查看当前activity */
	public BaseActivity peek(){
		if(stack.isEmpty()){
			return null;
		}
		BaseActivity activity = stack.peek();
		while(null == activity||activity.isFinishing()){
			pop();
			if(stack.isEmpty()){
				return null;
			}else{
				activity = stack.peek();
			}
		}
		return activity;
	}
	public BaseActivity peekDoesntMatterFinish(){
		if(stack.isEmpty()){
			return null;
		}
		BaseActivity activity = stack.peek();
		while(null == activity){
			pop();
			if(stack.isEmpty()){
				return null;
			}else{
				activity = stack.peek();
			}
		}
		return activity;
	}

	/* 查看指定的activity */
	public void pop(String activityName){
		BaseActivity activity = activityMap.remove(activityName);
		if(null!=activity){
			stack.remove(activity);
			if(!activity.isFinishing()){
				activity.finish();
			}
		}
	}

	/* 查看指定的activity,不删除 */
	public BaseActivity peek(String activityName) {
		return activityMap.get(activityName);
	}
	
	@SuppressWarnings("unchecked")
	public <T extends BaseActivity> T peekClass(Class<T> t){
		return (T)activityMap.get(t.getName());
	} 

	/* 清空 */
	public void clear() {
		stack.clear();
		activityMap.clear();

	}

	/**
	 * 结束activity
	 */
	public void finishActivity() {
		while (!stack.isEmpty()) {
			BaseActivity bactivity = stack.pop();
			if(null!=bactivity&&!bactivity.isFinishing()){
				bactivity.finish();
			}
		}
		clear();
	}
	
}
