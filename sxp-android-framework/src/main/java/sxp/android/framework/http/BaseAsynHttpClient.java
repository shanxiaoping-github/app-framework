package sxp.android.framework.http;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;

import sxp.android.framework.configuration.Configuration;
import sxp.android.framework.exception.SXPException;
import sxp.android.framework.util.StringUtil;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.RequestParams;

/**
 * 基础http数据处理类
 * 
 * @author xiaoping.shan
 * 
 */
public abstract class BaseAsynHttpClient {

	private boolean isEmpty = false;

	public void setEmpty(boolean isEmpty) {
		this.isEmpty = isEmpty;
	}

	private boolean isFail = false;

	public void setFail(boolean isFail) {
		this.isFail = isFail;
	}
	//响应路径
	private String actionPath="";
	
	
	
	
	protected abstract void parerAsynHcResponse(String content);// 数据解析

	public interface AsynHcResponseListener {// 回调相应接口
		public boolean onSuccess(BaseAsynHttpClient asynHttpClient);// 连接成功

		public boolean onTimeout();// 连接超时

		public boolean onEmpty();// 数据为空
	}

	/**
	 * 相应接口聚集
	 */
	private ArrayList<AsynHcResponseListener> list;

	public void addAsynHcResponseListenrt(AsynHcResponseListener listener) {
		if (list == null) {
			list = new ArrayList<AsynHcResponseListener>();
		}
		list.add(listener);
	}

	public void cleanResponse() {
		if (list != null && list.size() > 0) {
			list.clear();
		}
	}

	/* 设置参数 */

	public RequestParams requestParams = null;
	public void setPramas(String[] key, Object... params) {
		requestParams = new RequestParams();
		if (null == key || null == params) {
			return;
		}
		for (int i = 0; i < key.length; i++) {
  		      requestParams.put(key[i],String.valueOf(params[i]));
		}
		try {
			requestParams.put(getFileName(),getFileArray());
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
	
	}

	/**
	 * 设置参数，并使用默认兼职
	 * 
	 * @param params
	 */
	public void setPramas(Object... params){
		String[] keys = getPramasKeys();
		if (null != keys && null != params) {
			if (keys.length != params.length) {
				throw new SXPException("匹配异常", "参数个数不匹配");
			} else {
				setPramas(keys, params);
			}
		} else {
			throw new SXPException("参数异常", "参数无键值或值");
		}
	}
	
	public String getFileName(){
		return "";
	}
	public File getFileArray(){
		return null;
	}

	/**
	 * 获得默认键值
	 * 
	 * @return
	 */
	public String[] getPramasKeys() {
		return null;
	}

	private int outime = 15000;// 超时时间

	public int getOutime() {
		return outime;
	}

	public void setOutime(int outime) {
		this.outime = outime;
	}

	/* 获得请求 */
	public void subRequestGet(String path) {
		isEmpty = false;
		isFail = false;
		setActionPath(path);
		AsyncHttpClient client = new AsyncHttpClient();
		//预处理
		subRequestAdvanceDeal(client,this);
		client.setTimeout(getOutime());
		client.get(getUrl(path), requestParams, new AsyncHttpResponseHandler() {
			@Override
			public void onSuccess(final String content) {
				// TODO Auto-generated method stub
				if (StringUtil.isEmpty(content)) {// 数据为空
					reSponse(2);
				} else {
					new Thread(new Runnable() {

						public void run() {
							// TODO Auto-generated method stub
							parerAsynHcResponse(content);
							new Handler(Looper.getMainLooper())
									.post(new Runnable() {

										public void run() {
											// TODO Auto-generated method stub
											reSponse(0);
										}
									});

						}
					}).start();

				}
			}

			@Override
			public void onFailure(Throwable error) {
				// TODO Auto-generated method stub
				reSponse(1);
			}

		});

	}

	/**
	 * post请求
	 * 
	 * @param path
	 */
	public void subRequestPost(final String path) {
		isEmpty = false;
		isFail = false;
		setActionPath(path);
		AsyncHttpClient client = new AsyncHttpClient();
		//预处理
		subRequestAdvanceDeal(client,this);
		client.setTimeout(getOutime());
		//log输出
		Log.e("开始发送数据",
				"send_data----------------------------------------------------------\n");
		Log.e("链接的地址: ", getUrl(path) + "\n");
		Log.e("传递的参数: ", requestParams.toString() + "\n");
		Log.e("整体的地址: ", getUrl(path) + "?" + requestParams.toString() + "\n");
		Log.e("发送数据结束",
				"end_data----------------------------------------------------------\n");

		client.post(getUrl(path), requestParams,
				new AsyncHttpResponseHandler() {
					@Override
					public void onSuccess(final String content) {
						// TODO Auto-generated method stub
						Log.e("开始接收数据",
								"accept_data----------------------------------------------------------\n");
						Log.e(path, content + "\n");
						Log.e("接收数据结束",
								"end_accept-----------------------------------------------------------\n");
						if (StringUtil.isEmpty(content)) {// 数据为空
							reSponse(2);
						} else {
							new Thread(new Runnable() {

								public void run() {
									// TODO Auto-generated method stub
									parerAsynHcResponse(content);
									new Handler(Looper.getMainLooper())
											.post(new Runnable() {

												public void run() {
													// TODO Auto-generated
													// method stub
													reSponse(0);
												}
											});

								}
							}).start();
						}
					}

					@Override
					public void onFailure(Throwable error) {
						// TODO Auto-generated method stub
						Log.e("异常","exception----------------------------------------------------------\n");
						Log.e(path + "异常", error.getMessage() + "\n");
						Log.e("异常","exception----------------------------------------------------------\n");
						reSponse(1);
					}
				});
	}
	
	/**
	 * 提交前的预处理
	 * @param requestClient
	 * @param httpClient
	 */
	public void subRequestAdvanceDeal(AsyncHttpClient requestClient,BaseAsynHttpClient httpClient){}
	
	/**
	 * 默认提交post
	 */
	public void subRequestPost(){
		subRequestPost(getActionPath());
	}
	/**
	 * 默认提交get
	 */
	public void subRequestGet(){
		subRequestGet(getActionPath());
		
	}
	/**
	 * 获取action path
	 * @return
	 */
	public String getActionPath(){
		return actionPath;
	}
    public void setActionPath(String actionPath){
    	this.actionPath = actionPath;
    }
	
	
	

	/**
	 * 成功响应
	 */
	public void reSponse(int state) { // 0成功，1连接超时，2连接被拒
		if (list == null){
			return;
		}

		for (int i = 0; i < list.size(); i++) {
			AsynHcResponseListener listener = list.get(i);
			switch (state) {
			case 0:// 0成功
				if (isEmpty) {
					listener.onEmpty();
					return;
				}
				if (isFail) {
					listener.onTimeout();
					return;
				}

				listener.onSuccess(this);

				break;

			case 1:// 连接超时

				listener.onTimeout();
				break;

			case 2:// 数据为空

				listener.onEmpty();
				break;
			}

		}
	}

	/* 获得请求地址 */
	public String getUrl(String path) {
		return getUrl(
				Configuration.getInstance().getProperty(
						Configuration.SERVICE_ADRESS),path);
	}

	private String getUrl(String url, String path) {
		StringBuffer buffer = new StringBuffer();
		buffer.append(url);
		buffer.append(path);
		return buffer.toString();
	}

	
	
}
