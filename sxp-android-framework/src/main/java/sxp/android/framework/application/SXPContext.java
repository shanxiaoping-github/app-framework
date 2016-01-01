package sxp.android.framework.application;
/*
 * 上下文保存接口
 */
public interface SXPContext {
	/**
	 * 保存数据
	 * @param key
	 * @param value
	 */
	public void savaData(String key,Object value);
	/**
	 * 获取数据
	 * @param key
	 * @return
	 */
	public Object getData(String key);
	
}
