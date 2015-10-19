package sxp.android.framework.exception;

/**
 * 基础异常类
 * 
 * @author xiaoping.shan
 *
 */
public class SXPException extends RuntimeException {
	/**
	 * 异常类型
	 */
	private String exceptionType;
	/**
	 * 异常描述
	 */
	private String exceptionMsg;

	private static final long serialVersionUID = 1L;

	public SXPException(String exceptionType, String exceptionMsg) {
		this.exceptionType = exceptionType;
		this.exceptionMsg = exceptionMsg;

	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "异常类型:" + exceptionType + " 异常信息:" + exceptionMsg;

	}

}
