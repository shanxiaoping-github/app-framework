package sxp.android.framework.messageManager;
/**
 * 消息主题
 * @author shanxiaoping
 *
 */
public class MessageSubject {
	//标题
	private String title;
	//优先级
	private int priority;
	
	//构造函数
	public MessageSubject(String title,int priority){
		this.title = title;
		this.priority = priority;
	}
	public MessageSubject(String title,MessageSubjectPriorty priority){
		this(title,priority.getValue());
	}
	public MessageSubject(String title){
		this(title,MessageSubjectPriorty.high);
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}




	//优先级枚举
	public static enum MessageSubjectPriorty{
		high(1000),
		normal(750),
		low(250);
		private final int value;
		public int getValue(){
			return value;
		}
		private MessageSubjectPriorty(int value){
			this.value = value;
		}
	}

}
