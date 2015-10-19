package sxp.android.framework.messageManager;

import sxp.android.framework.util.StringUtil;

/**
 * 消息响应
 * 
 * @author shanxiaoping
 *
 */
public class MessageAction {
	// 响应标题
	private String title;
	// 响应优先级
	private int priority;
	// 响应监听器
	private MessageActionListener listener;

	public MessageAction(MessageActionListener listener) {
		this(listener, MessageActionPriorty.high);
	}

	public MessageAction(MessageActionListener listener, int priority) {
		this.listener = listener;
		this.priority = priority;
		this.title = StringUtil.getUIID();
	}

	public MessageAction(MessageActionListener listener,
			MessageActionPriorty priority) {
		this(listener, priority.getValue());
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public MessageActionListener getListener() {
		return listener;
	}

	public void setListener(MessageActionListener listener) {
		this.listener = listener;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	// 消息响应接口
	public static interface MessageActionListener {
		public void actionMessage(Object... objects);
	}

	// 优先级枚举
	public static enum MessageActionPriorty {
		high(1000), normal(750), low(250);
		private final int value;

		public int getValue() {
			return value;
		}

		private MessageActionPriorty(int value) {
			this.value = value;
		}
	}
}
