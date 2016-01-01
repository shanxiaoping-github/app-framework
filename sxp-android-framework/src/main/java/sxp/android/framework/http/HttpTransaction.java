package sxp.android.framework.http;

import java.util.ArrayList;

/**
 * @ClassName: HttpTransaction
 * @Description: 网络请求事务类
 * @author shanxiaoping
 * @date 2015年12月31日 下午2:30:16
 */
public class HttpTransaction {
	// 事务监听器
	private HttpTransactionActionListener httpTransactionActionListener;
	// 事务执行成功计数
	private int progressSuccessCount;
	// 事务执行失败计数
	private int progressFailCount;
	// 事务list
	private ArrayList<HttpRequest<?, ?, ?>> httpRequestList;
	

	/**
	 * @Title performHttpTransaction
	 * @Description 执行事务
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	public void performHttpTransaction() {
		if (null == httpRequestList) {
			return;
		}
		progressSuccessCount = 0;
		progressFailCount = 0;
		for (HttpRequest<?, ?, ?> httpRequest : httpRequestList) {
			httpRequest.submitRequest();
		}
	}

	/**
	 * @Title checkHttpTransactionProgress
	 * @Description 检测事务成功进度
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	public void checkHttpTransactionSuccessProgress() {
		if (null == httpRequestList) {
			return;
		}
		if (progressFailCount > 0) {
			if(null != httpTransactionActionListener){
				httpTransactionActionListener.performTransactionFail(httpRequestList);
			}
			return;
		}
		progressSuccessCount++;
		if (progressSuccessCount >= httpRequestList.size()) {
			if(null != httpTransactionActionListener){
				httpTransactionActionListener.performTransactionSuccess(httpRequestList);
			}
		}
	}

	/**
	 * @Title checkHttpTransactionFailProgress
	 * @Description 检测事务失败进度
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	public void checkHttpTransactionFailProgress() {
		progressFailCount++;
		if(null != httpTransactionActionListener){
			httpTransactionActionListener.performTransactionFail(httpRequestList);
		}
	}

	/**
	 * @Title addHttpRequest
	 * @Description 添加请求事件
	 * @param httpRequest
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	public void addHttpRequest(HttpRequest<?, ?, ?> httpRequest) {
		if (null == httpRequest) {
			return;
		}
		if (haveHttpRequest(httpRequest)) {
			return;
		}
		if (null == httpRequestList) {
			httpRequestList = new ArrayList<HttpRequest<?, ?, ?>>();
		}
		httpRequest.setBelongHttpTransaction(this);
		httpRequestList.add(httpRequest);
	}

	/**
	 * @Title haveHttpRequest
	 * @Description 判断是否存在 httpRequest
	 * @param httpRequest
	 * @return boolean
	 * @author shanxiaoping
	 * @data 2015年12月31日
	 */
	private boolean haveHttpRequest(HttpRequest<?, ?, ?> httpRequest) {
		if (null == httpRequestList) {
			return false;
		}
		for (HttpRequest<?, ?, ?> httpRequestItem : httpRequestList) {
			if (httpRequestItem.getUrl().equalsIgnoreCase(httpRequest.getUrl())) {
				return true;
			}
		}
		return false;
	}

	/*********************************************************** get set ********************************************************/
	public ArrayList<HttpRequest<?, ?, ?>> getHttpRequestList() {
		return httpRequestList;
	}

	public void setHttpRequestList(
			ArrayList<HttpRequest<?, ?, ?>> httpRequestList) {
		this.httpRequestList = httpRequestList;
	}
	

	public HttpTransactionActionListener getHttpTransactionActionListener() {
		return httpTransactionActionListener;
	}

	public void setHttpTransactionActionListener(
			HttpTransactionActionListener httpTransactionActionListener) {
		this.httpTransactionActionListener = httpTransactionActionListener;
	}


	/*********************************************************** get set ********************************************************/
	/**
	 * @ClassName: HttpTransactionActionListener
	 * @Description: 事务监听器
	 * @author shanxiaoping
	 * @date 2015年12月31日 下午3:58:43
	 */
	public static interface HttpTransactionActionListener {
		/**
		 * @Title performTransactionSuccess
		 * @Description 执行事务成功
		 * @param httpRequestList 事务列表
		 * @author shanxiaoping
		 * @data 2015年12月31日
		 */
		public void performTransactionSuccess(ArrayList<HttpRequest<?,?,?>> httpRequestList);
		/**
		 * @Title performTransactionFail
		 * @Description 执行事务失败
		 * @param httpRequestList 事务列表
		 * @author shanxiaoping
		 * @data 2015年12月31日
		 */
		public void performTransactionFail(ArrayList<HttpRequest<?,?,?>> httpRequestList);
	}
}
