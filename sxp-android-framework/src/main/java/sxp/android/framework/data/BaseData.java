package sxp.android.framework.data;

import java.io.Serializable;

import org.json.JSONObject;
/**
 * 基础数据类
 * @author xiaoping.shan
 *
 */
public interface BaseData extends Serializable{
	//解析数据
	public void parser(JSONObject jo);
	//打包数据
	public JSONObject page();
}
