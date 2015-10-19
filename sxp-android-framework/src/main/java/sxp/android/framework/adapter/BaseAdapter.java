package sxp.android.framework.adapter;

import java.io.Serializable;
import java.util.ArrayList;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

/**
 * 自定义基类适配器
 * 
 * @author Administrator
 * 
 */
public abstract class BaseAdapter<T> extends android.widget.BaseAdapter {

	public interface AdapterItemListener extends Serializable {
		public boolean onAdapterItemListener(Object... objects);

	}

	private AdapterItemListener listener;

	public AdapterItemListener getListener() {
		return listener;
	}

	public void setListener(AdapterItemListener listener) {
		this.listener = listener;
	}

	private Context context;

	public Context getContext() {
		return context;
	}

	public void setContext(Context context) {
		this.context = context;
	}

	private ArrayList<T> list = new ArrayList<T>();

	public ArrayList<T> getList() {
		return list;
	}

	public void setList(ArrayList<T> list) {
		this.list = list;
	}

	public void add(T t, int index) {
		if (list == null) {
			list = new ArrayList<T>();
		}
		list.add(index, t);

	}

	public void add(T t) {
		add(t, 0);
	}

	public void addEnd(T t) {
		if (list == null) {
			list = new ArrayList<T>();
		}
		list.add(t);
	}

	public void addForArray(ArrayList<T> list) {
		if (null != list && list.size() > 0) {
			for (T t : list) {
				addEnd(t);
			}
		}
	}
	
	public void addForArrayToBefore(ArrayList<T> list){
		if(null != list && list.size() > 0){
			for(int i=list.size()-1;i >= 0;i--){
				T t = list.get(i);
				add(t);
			}
		}
	}
	

	public int getCount() {
		// TODO Auto-generated method stub
		return list.size();
	}

	public Object getItem(int arg0) {
		// TODO Auto-generated method stub
		return list.get(arg0);
	}

	public long getItemId(int arg0) {
		// TODO Auto-generated method stub
		return arg0;
	}

	public View getView(final int arg0, View arg1, ViewGroup arg2) {
		// TODO Auto-generated method stub

		arg1 = view(arg0, arg1, arg2);

		return arg1;
	}

	/* 视图view */
	public abstract View view(int arg0, View arg1, ViewGroup arg2);

	/**
	 * 点击处理
	 * 
	 * @param objects
	 */
	public void onItem(Object... objects) {
		if (listener != null) {
			listener.onAdapterItemListener(objects);
		}
	}

	/* 获得当前选中T */
	public T getData(int index) {
		if (list != null && list.size() > 0) {
			return list.get(index);
		} else {
			return null;
		}
	}

	public void delectData(int index) {
		if (list != null && list.size() > 0) {
			list.remove(index);
		}
	}

	public void delectData(T object) {
		if (list != null && list.size() > 0) {
			list.remove(object);
		}
	}

	/**
	 * 返回数据大小
	 * 
	 * @return
	 */
	public int dataSize() {
		return list.size();
	}

}
