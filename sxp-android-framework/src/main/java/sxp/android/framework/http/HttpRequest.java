package sxp.android.framework.http;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Map;

import org.apache.http.HttpResponse;

import sxp.android.framework.annotation.ACTION;
import sxp.android.framework.annotation.FATHER_HTTPREQUEST;
import sxp.android.framework.annotation.SON_HTTPREQUEST;
import sxp.android.framework.annotation.URL;
import sxp.android.framework.exception.SXPException;
import sxp.android.framework.http.HttpUtil.PageParameImpl;
import sxp.android.framework.http.HttpUtil.RequestType;
import sxp.android.framework.http.HttpUtil.ResponseCode;
import sxp.android.framework.util.LogUtil;
import sxp.android.framework.util.StringUtil;
import android.os.AsyncTask;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * http请求
 * 
 * @author shanxiaoping
 *
 */
public class HttpRequest<T extends HttpRequest<T, R, B>, R extends HttpModel, B extends HttpModel> {

	public static interface HttpResponseListener<T> {
		// 返回成功
		public void responseSuccess(T t);

		// 返回失败
		public void responseFaile(Object... objects);

		// 返回异常错误
		public void responseError(Object... objects);
	}

	// 所属事务
	private HttpTransaction belongHttpTransaction;
	// 父请求
	private HttpRequest<?,?,?> fatherHttpRequest;
	// 子请求集合
	private ArrayList<HttpRequest<?,?,?>> sonHttpRequestList;
	// http 响应
	private HttpResponseListener<T> httpResponseListener;
	// 请求参数模型
	private R httpRequestModel;
	// 请求参数map
	private Map<String, Object> params;
	// 请求返回数据模型
	private B httpResponseModel;
	// 请求地址
	private String url;

	// 构造函数
	public HttpRequest() {
	}

	public HttpRequest(String url) {
		this();
		this.url = url;
	}

	public HttpRequest(R httpRequestModel) {
		this();
		this.httpRequestModel = httpRequestModel;
	}

	public HttpRequest(HttpResponseListener<T> httpResponseListener) {
		this();
		this.httpResponseListener = httpResponseListener;
	}

	public HttpRequest(String url, R httpRequestModel) {
		this();
		this.url = url;
		this.httpRequestModel = httpRequestModel;
	}

	public HttpRequest(String url, HttpResponseListener<T> httpResponseListener) {
		this();
		this.url = url;
		this.httpResponseListener = httpResponseListener;
	}

	public HttpRequest(String url, R httpRequestModel,
			HttpResponseListener<T> httpResponseListener) {
		this();
		this.url = url;
		this.httpRequestModel = httpRequestModel;
		this.httpResponseListener = httpResponseListener;
	}

	// 解析数据
	public void parserData(String data) {
		if (StringUtil.isNotJsonEmpty(data)) {
			Type type = new TypeToken<B>() {
			}.getType();
			httpResponseModel = new Gson().fromJson(data, type);
		}
	}

	/**
	 * 提交请求
	 */
	public void submitRequest(RequestType requestType) {
		if (getUrl() == null) {
			throw new SXPException("url异常", "url不存在");
		}
		// 如果是子请求
		if (isSonHttpRequest()) {
			setRequestContentFromFatherContext();
		}
		
		LogUtil.logHttpRequest(this);
		SendAsyncTask sendAsyncTask = new SendAsyncTask(requestType);
		sendAsyncTask.execute();
	}

	/**
	 * 提交请求
	 */
	public void submitRequest() {
		submitRequest(RequestType.RequestTypePost);
	}

	/**
	 * @Title performSonHttpRequests
	 * @Description 执行子httpRequest
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	public void performSonHttpRequests() {
		if (!isFatherHttpRequest()) {
			return;
		}
		if (null == sonHttpRequestList) {
			return;
		}
		for (HttpRequest<?, ?, ?> httpRequest : sonHttpRequestList) {
			httpRequest.submitRequest();
		}
	}

	/**
	 * @Title isFatherHttpRequest
	 * @Description 是否是father请求
	 * @return boolean
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	private boolean isFatherHttpRequest() {
		FATHER_HTTPREQUEST fatherAnnotation = getClass().getAnnotation(
				FATHER_HTTPREQUEST.class);
		return null != fatherAnnotation;
	}

	/**
	 * @Title isSonHttpRequest
	 * @Description 是否是子请求
	 * @return boolean
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	private boolean isSonHttpRequest() {
		SON_HTTPREQUEST sonAnnotation = getClass().getAnnotation(
				SON_HTTPREQUEST.class);
		return null != sonAnnotation;
	}

	/********************************* get set *************************************/
	public HttpResponseListener<T> getHttpResponseListener() {
		return httpResponseListener;
	}

	public void setHttpResponseListener(
			HttpResponseListener<T> httpResponseListener) {
		this.httpResponseListener = httpResponseListener;
	}

	public String getUrl() {
		if (StringUtil.isEmpty(url)) {
			URL urlAnnatation = this.getClass().getAnnotation(URL.class);
			ACTION actionAnnatation = this.getClass().getAnnotation(
					ACTION.class);
			if (null != urlAnnatation && null != actionAnnatation) {
				String url = urlAnnatation.value();
				String action = actionAnnatation.value();
				this.url = url + action;
			} else {
				throw new SXPException("url异常", "url不存在");
			}
		}
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public R getHttpRequestModel() {
		return httpRequestModel;
	}

	public void setHttpRequestModel(R httpRequestModel) {
		this.httpRequestModel = httpRequestModel;
		this.params = null;
	}

	public B getHttpResponseModel() {
		return httpResponseModel;
	}

	public void setHttpResponseModel(B httpResponseModel) {
		this.httpResponseModel = httpResponseModel;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}

	public Map<String, Object> getParams() {
		if (null == params) {
			if (null != httpRequestModel) {
				Gson gson = new Gson();
				String gsonStr = gson.toJson(httpRequestModel);
				Type type = new TypeToken<Map<String, Object>>() {
				}.getType();
				params = gson.fromJson(gsonStr, type);
			}
		}
		return params;
	}

	/**
	 * @Title setRequestContentFromFatherContext
	 * @Description 子请求获取组合请求参数，来自父请求上下文
	 * @return void
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	public void setRequestContentFromFatherContext(){
		
	}
	public void setSonHttpRequestList(
			ArrayList<HttpRequest<?, ?, ?>> sonHttpRequestList) {
		this.sonHttpRequestList = sonHttpRequestList;
	}
	/**
	 * @Title addSonHttpRequest
	 * @Description 添加子请求
	 * @param httpRequest
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	public void addSonHttpRequest(HttpRequest<?,?,?> httpRequest){
		if(null == httpRequest){
			return;
		}
		for (HttpRequest<?, ?, ?> httpRequestItem : sonHttpRequestList) {
			if(httpRequestItem.getUrl().equalsIgnoreCase(httpRequest.getUrl())){
				return;
			}
		}
		if(null == sonHttpRequestList){
			sonHttpRequestList = new ArrayList<HttpRequest<?,?,?>>();
		}
		httpRequest.fatherHttpRequest = this;
		sonHttpRequestList.add(httpRequest);
	}
	
	public void setBelongHttpTransaction(HttpTransaction belongHttpTransaction) {
		this.belongHttpTransaction = belongHttpTransaction;
	}



	/********************************* AsyncTask **************************************/
	class SendAsyncTask extends AsyncTask<Void, Void, Object[]> {
		private RequestType requestType;

		public SendAsyncTask(RequestType requestType) {
			this.requestType = requestType;
		}

		@Override
		protected Object[] doInBackground(Void... arg0) {
			// TODO Auto-generated method stub
			Object[] result = null;
			HttpUtil httpUtil = null;
			if (isPageParamesListener()) {
				httpUtil = HttpUtil.creatHttpUtil(selfPageParameImpl());
			} else {
				httpUtil = new HttpUtil();
			}
			httpUtil.setHttpRequest(HttpRequest.this);
			switch (requestType) {
			case RequestTypeGet:
				result = httpUtil.sendGetHttpRequest(getUrl(),
						fiterRequest(getParams()));
				break;
			case RequestTypePost:
				result = httpUtil.sendPostHttpRequest(getUrl(),
						fiterRequest(getParams()));
				break;
			}
			ResponseCode code = (ResponseCode) result[0];
			if(code == ResponseCode.ResponseCodeSuccess){
				String data = (String) result[1];
				parserData(data);
				performSonHttpRequests();
				LogUtil.logHttpResponse(HttpRequest.this);
			}else{
				LogUtil.logHttpMsg(getClass().getName()+":请求异常-"+result[1]+"\n");
			}
			return result;
		}

		@SuppressWarnings("unchecked")
		@Override
		protected void onPostExecute(Object[] result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);
			if (result != null) {
				ResponseCode code = (ResponseCode) result[0];
				switch (code) {
				case ResponseCodeSuccess:
					if (null != httpResponseListener){
						httpResponseListener
								.responseSuccess((T) HttpRequest.this);
					}
					if(null != belongHttpTransaction){
						belongHttpTransaction.checkHttpTransactionSuccessProgress();
					}
					break;
				case ResponseCodeFaile:
					if (null != httpResponseListener) {
						httpResponseListener.responseFaile(result);
					}
					if(null != belongHttpTransaction){
						belongHttpTransaction.checkHttpTransactionFailProgress();;
					}
					break;
				case ResponseCodeError:
					if (null != httpResponseListener) {
						httpResponseListener.responseError(result);
					}
					if(null != belongHttpTransaction){
						belongHttpTransaction.checkHttpTransactionFailProgress();;
					}
					break;
				}
			}

		}

	}

	/**
	 * @Title isPageParamesListener
	 * @Description 判断网络请求是否自定义打包方式
	 * @param @return
	 * @return boolean
	 * @throws
	 * @author shanxiaoping
	 * @data 2015年12月30日
	 */
	private boolean isPageParamesListener() {
		Class<?>[] interfaces = this.getClass().getInterfaces();
		for (Class<?> classItem : interfaces) {
			if (classItem == PageParameImpl.class) {
				return true;
			}
		}
		return false;
	}

	private PageParameImpl selfPageParameImpl() {
		return (PageParameImpl) this;
	}

	/**
	 * @Title fiterResponse
	 * @Description 过滤response
	 * @param httpResponse
	 *            返回数据
	 * @return void
	 * @throws
	 * @author shanxiaoping
	 * @data 2015年12月30日
	 */
	public void fiterResponse(HttpResponse httpResponse) {
	}

	/**
	 * @Title fiterRequest
	 * @Description 过滤请求
	 * @param parame
	 *            请求参数
	 * @return void
	 * @throws
	 * @author shanxiaoping
	 * @data 2015年12月30日
	 */
	public Map<String, Object> fiterRequest(Map<String, Object> parame) {
		return parame;
	}
}
