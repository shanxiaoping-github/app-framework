package watts.android.framework.http;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import watts.android.framework.util.StringUtil;

/**
 * http工具
 * @author shanxiaoping
 *
 */
public class HttpUtil{
	
	// head键值
	public static final String HEAD_TAG = "headTag";
	// 数据类型
	public static final String CONTENT_TYPE = "contentType";
	// 默认内容格式
	private static final String DEFAULT_CONTEN_TTYPE = "application/json";
	// 打包接口
	private PageParameImpl pageParameImpl = null;
	//请求事件
	private HttpRequest<?,?,?> httpRequest = null;

	// 返回类型
	public static enum ResponseCode{
		// 成功
		ResponseCodeSuccess,
		// 失败
		ResponseCodeFaile,
		// 错误
		ResponseCodeError
	}

	// 请求方式
	public static enum RequestType {
		// get类型
		RequestTypeGet,
		// post类型
		RequestTypePost
	}
    /**
     * @Title creatHttpUtil
     * @Description 创建httUtil
     * @param pageParameImpl 打包接口
     * @return HttpUtil
     * @throws 
     * @author shanxiaoping
     * @data 2015年12月30日
     */
	public static HttpUtil creatHttpUtil(PageParameImpl pageParameImpl){
		HttpUtil httpUtil = new HttpUtil();
		httpUtil.setPageParameImpl(pageParameImpl);
		return httpUtil;
	}
	public Object[] sendGetHttpRequest(String url, Map<String, Object> params) {
		// 先将参数放入List，再对参数进行URL编码
		Map<String, Object> fiterParames = filterParame(params);
		String parameStr = pagePrames(fiterParames);
		// 将URL与参数拼接
		HttpGet getMethod = new HttpGet(url
				+ (StringUtil.isEmpty(parameStr) ? "" : ("?" + parameStr)));
		setHead(getMethod, params);
		HttpClient httpClient = new DefaultHttpClient();
		Object[] reponseResult = new Object[2];
		ResponseCode responseCode;
		try {
			HttpResponse response = httpClient.execute(getMethod); // 发起GET请求
			if(null != httpRequest){
				httpRequest.fiterResponse(response);
			}
			int code = response.getStatusLine().getStatusCode();
			if (code == 200) {
				responseCode = ResponseCode.ResponseCodeSuccess;
				reponseResult[1] = EntityUtils.toString(response.getEntity(),
						"utf-8");
			} else {
				responseCode = ResponseCode.ResponseCodeFaile;
				reponseResult[1] = EntityUtils.toString(response.getEntity(),
						"utf-8");
			}
			
		} catch (Exception ex) {
			responseCode = ResponseCode.ResponseCodeError;
			reponseResult[1] = ex.toString();
		}
		reponseResult[0] = responseCode;
		return reponseResult;
	}

	/**
	 * 发送post请求
	 * 
	 * @param url
	 * @param params
	 * @return
	 */
	public Object[] sendPostHttpRequest(String url,
			Map<String, Object> params) {
		Object[] reponseResult = new Object[2];
		ResponseCode responseCode;
		try {
			HttpPost postMethod = new HttpPost(url);
			setHead(postMethod, params);
			Map<String, Object> fiterParames = filterParame(params);
			String parameStr = pagePrames(fiterParames);
			StringEntity sendEntity = new StringEntity(parameStr, "utf-8");
			setContentType(sendEntity,params);
			postMethod.setEntity(sendEntity);
			HttpClient httpClient = new DefaultHttpClient();// Entity中
			HttpResponse response = httpClient.execute(postMethod); // 执行POST方法
			if(null != httpRequest){
				httpRequest.fiterResponse(response);
			}
			int code = response.getStatusLine().getStatusCode();
			if (code == 200) {
				responseCode = ResponseCode.ResponseCodeSuccess;
				reponseResult[1] = EntityUtils.toString(response.getEntity(),
						"utf-8");
			} else {
				responseCode = ResponseCode.ResponseCodeFaile;
				reponseResult[1] = EntityUtils.toString(response.getEntity(),
						"utf-8");
			}
		} catch (Exception ex) {
			responseCode = ResponseCode.ResponseCodeError;
			reponseResult[1] = ex.toString();
		}
		reponseResult[0] = responseCode;
		return reponseResult;
	}

	/**
	 * @Title fiterParame
	 * @Description 过滤参数
	 * @param parameMap
	 * @return Map<String,Object>
	 * @throws
	 * @author shanxiaoping
	 * @data 2015年12月30日
	 */
	private static Map<String, Object> filterParame(
			Map<String, Object> paramesMap) {
		if (null == paramesMap) {
			return paramesMap;
		}
		Map<String, Object> filterMap = null;
		Iterator<String> keyIterator = paramesMap.keySet().iterator();
		while (keyIterator.hasNext()) {
			String key = keyIterator.next();
			if (!key.equalsIgnoreCase(HEAD_TAG)
					&& !key.equalsIgnoreCase(CONTENT_TYPE)) {
				Object value = paramesMap.get(key);
				if (null == filterMap) {
					filterMap = new HashMap<String, Object>();
				}
				filterMap.put(key, value);
			}

		}
		return filterMap;
	}

	/**
	 * @Title pagePrames
	 * @Description 打包参数
	 * @param paramesMap
	 *            待打包的参数
	 * @return String 返回打包结果
	 * @throws
	 * @author shanxiaoping
	 * @data 2015年12月30日
	 */
	private String pagePrames(Map<String, Object> parames) {
		if (null == parames) {
			return "";
		} else if (null != pageParameImpl) {
			return pageParameImpl.pageParames(parames);
		} else {
			List<BasicNameValuePair> sendParams = new LinkedList<BasicNameValuePair>();
			Iterator<String> iterator = parames.keySet().iterator();
			while (iterator.hasNext()) {
				String paramKey = iterator.next();
				Object value = parames.get(paramKey);
				sendParams.add(new BasicNameValuePair(paramKey, value
						.toString()));
			}
			return URLEncodedUtils.format(sendParams, "UTF-8");
		}
	}

	/**
	 * @Title setHead
	 * @Description 设置头信息
	 * @param httpMethod
	 * @param headMap
	 *            参数map
	 * @return void
	 * @throws
	 * @author shanxiaoping
	 * @data 2015年12月30日
	 */
	private static void setHead(HttpGet httpMethod,
			Map<String, Object> paramesMap) {
		if (null == paramesMap || null == paramesMap.get(HEAD_TAG)) {
			return;
		}
		@SuppressWarnings("unchecked")
		Map<String, String> headMap = (Map<String, String>) paramesMap
				.get(HEAD_TAG);
		Iterator<String> keysIterator = headMap.keySet().iterator();
		while (keysIterator.hasNext()) {
			String key = keysIterator.next();
			String value = headMap.get(key);
			httpMethod.setHeader(key, value);
		}

	}

	private static void setHead(HttpPost httpMethod,
			Map<String, Object> paramesMap) {
		if (null == paramesMap || null == paramesMap.get(HEAD_TAG)) {
			return;
		}
		@SuppressWarnings("unchecked")
		Map<String, String> headMap = (Map<String, String>) paramesMap
				.get(HEAD_TAG);
		Iterator<String> keysIterator = headMap.keySet().iterator();
		while (keysIterator.hasNext()) {
			String key = keysIterator.next();
			String value = headMap.get(key);
			httpMethod.setHeader(key, value);
		}
	}

	/**
	 * @Title setContentType
	 * @Description 设置内容格式
	 * @param httpEntity
	 * @param cotentType
	 * @return void
	 * @throws
	 * @author shanxiaoping
	 * @data 2015年12月30日
	 */
	private static void setContentType(StringEntity httpEntity,
			Map<String, Object> paramesMap) {
		if (null == paramesMap || null == paramesMap.get(CONTENT_TYPE)) {
			httpEntity.setContentType(DEFAULT_CONTEN_TTYPE);
			return;
		}
		String contentType = (String) paramesMap.get(CONTENT_TYPE);
		httpEntity.setContentType(contentType);
	}

	/**
	 * @ClassName: PageParameImpl
	 * @Description: TODO
	 * @author shanxiaoping
	 * @date 2015年12月30日 上午11:49:12
	 */
	public static interface PageParameImpl {
		public String pageParames(Map<String, Object> parames);
	}

	public PageParameImpl getPageParameImpl() {
		return pageParameImpl;
	}

	public void setPageParameImpl(PageParameImpl pageParameImpl) {
		this.pageParameImpl = pageParameImpl;
	}
	public HttpRequest<?,?,?> getHttpRequest() {
		return httpRequest;
	}
	public void setHttpRequest(HttpRequest<?,?,?> httpRequest) {
		this.httpRequest = httpRequest;
	}
	
}
