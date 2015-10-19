package sxp.android.framework.ui;

import java.lang.reflect.Field;

import sxp.android.framework.annotation.ID;
import sxp.android.framework.annotation.LAYOUT;
import android.app.Activity;


import android.content.Context;
import android.content.Intent;
import android.os.Bundle;


import android.support.v4.app.Fragment;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;

/**
 * 碎片基类
 * 
 * @author Administrator
 * 
 */
public  class BaseFragment extends Fragment implements OnClickListener{
    private View contentView;
	private OnHeadlineSelectedListener listener;// 监听器
	private Context context;// 上下文
	

	public OnHeadlineSelectedListener getListener() {
		return listener;
	}

	public void setListener(OnHeadlineSelectedListener listener) {
		this.listener = listener;
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreateView(inflater, container, savedInstanceState);
		contentView = layoutContentView(inflater);
		if(contentView == null){
			contentView = layout(inflater);
			//initComponent();
		}else{
			initComponent();
			layout(inflater);
		}
		
		return contentView;//布局;
	}

	@Override
	public void onAttach(Activity activity) {
		// TODO Auto-generated method stub
		super.onAttach(activity);
		context = activity;
		listener = (OnHeadlineSelectedListener) activity;

	}

	@Override
	public void onActivityCreated(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onActivityCreated(savedInstanceState);
		if (savedInstanceState == null) {// 数据初始化
			dataInit();
		} else {// 数据恢复
			dataRestore(savedInstanceState);
		}
		eventDispose();// 事件
	}
	
	/**
	 * 注入布局
	 */
	private View layoutContentView(LayoutInflater inflater){
		LAYOUT layoutAnnatation = this.getClass().getAnnotation(LAYOUT.class);
		if (layoutAnnatation!=null) {
			int layoutValue = layoutAnnatation.value();
			if(layoutValue!=-1){
				return inflater.inflate(layoutValue,null);
			}
		}
		return null;
	}
	
	protected void initComponent(){
		
		Class<? extends BaseFragment> clazz = this.getClass();
		Field[] fields = clazz.getDeclaredFields();
		for (Field field : fields){
			field.setAccessible(true);
			Class<?> type = field.getType();
			if (View.class.isAssignableFrom(type)){
				//String idName = field.getName();
				// 如果字段上有注解则采用注解的id
			    ID idAnnotation = field.getAnnotation(ID.class);
				if (idAnnotation != null) {
					int idValue = idAnnotation.value();
					if(idValue!=-1&&contentView!=null){
						View view = contentView.findViewById(idValue);
						if(view!=null){
							try {
								field.set(this,view);
								if(idAnnotation.isBindListener()){
									view.setOnClickListener(this);
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
							
						}
					}
					
				}
			}
		}
	}
	

	/* 布局 */
	public  View layout(LayoutInflater inflater){
		return contentView;
	};

	/* 选中 */
	public void onSelect() {
	};

	/* 未选中 */
	public void onUnSelect() {
	};

	/* 数据初始化 */
	public void dataInit() {
	}

	/* 数据恢复 */
	public void dataRestore(Bundle savedInstanceState) {
	}

	/* 处理 */
	public void eventDispose() {
	}

	/*activity返回 */
	public void onActivityResult(int arg0, int arg1, Intent arg2) {}

	/* 获得上下文环境 */
	public Context getContext() {
		return context;
	}

	public void setContext(Context context) {
		this.context = context;
	}

	/**
	 * 管理类事件触发
	 * 
	 * @author Administrator
	 * 
	 */
	public interface OnHeadlineSelectedListener {
		public void onArticleSelected(Object[] param);
		public void back();
	}

	/**
	 * 按键处理
	 */
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if (listener != null && keyCode == event.KEYCODE_BACK
				&& event.getAction() == KeyEvent.ACTION_DOWN) {
			listener.back();// 返回
		}
		return true;
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		
	}

}
