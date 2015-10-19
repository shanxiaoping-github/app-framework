package sxp.android.framework.messageManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import sxp.android.framework.exception.SXPException;

/**
 * 
 * @author shanxiaoping 消息管理类
 */
public class MessageManager {
	// 消息单例
	private MessageManager() {
	}

	private static MessageManager messageManager = null;

	public static synchronized MessageManager manager() {
		if (null == messageManager) {
			messageManager = new MessageManager();
		}
		return messageManager;
	}

	/*********************************** 消息注册，响应 *********************************/
	private final Map<MessageSubject, ArrayList<MessageAction>> actionMap = new TreeMap<MessageSubject, ArrayList<MessageAction>>(
			new Comparator<MessageSubject>() {

				@Override
				public int compare(MessageSubject o1, MessageSubject o2) {
					// TODO Auto-generated method stub
					if (o1.getPriority() > o2.getPriority()) {
						return -1;
					} else if (o1.getPriority() == o2.getPriority()) {
						return 0;
					} else {
						return 1;
					}
				}
			});
	private final ArrayList<MessageSubject> messageSubjectList = new ArrayList<MessageSubject>();

	/**
	 * 缓存subject对象
	 * 
	 * @param messageSubject
	 */
	private void addMessageSubject(MessageSubject messageSubject) {
		messageSubjectList.add(messageSubject);
	}

	/**
	 * 查询是否拥有主题对象
	 * 
	 * @param subject
	 * @return
	 */
	private MessageSubject queryMessageSubject(String subject) {
		if (null == messageSubjectList) {
			return null;
		}
		for (MessageSubject messageSubject : messageSubjectList) {
			if (messageSubject.getTitle().equals(subject)) {
				return messageSubject;
			}
		}
		return null;

	}

	/**
	 * 
	 * @param subject
	 * @param action
	 */
	public synchronized void registMessage(String subject, MessageAction action) {

		MessageSubject messageSubject = queryMessageSubject(subject);
		if (null == messageSubject) {
			messageSubject = new MessageSubject(subject);
			addMessageSubject(messageSubject);
		}
		registMessage(messageSubject, action);
	}

	public synchronized void registMessage(MessageSubject messageSubject,
			MessageAction action) {
		if (messageSubject.getTitle().equals(NO_SUBJECT)) {
			throw new SXPException("参数类型异常", "主题类型不能与无类型关键字一致");
		}

		MessageSubject keyMessageSubject = queryMessageSubject(messageSubject
				.getTitle());
		if (null == keyMessageSubject) {
			keyMessageSubject = messageSubject;
			addMessageSubject(messageSubject);
		}

		ArrayList<MessageAction> actionList = actionMap.get(keyMessageSubject);
		if (null == actionList) {
			actionList = new ArrayList<MessageAction>();
			actionMap.put(keyMessageSubject, actionList);
		}
		if (canAddAction(action, actionList)) {
			actionList.add(action);
			Collections.sort(actionList, new Comparator<MessageAction>() {

				@Override
				public int compare(MessageAction o1, MessageAction o2) {
					// TODO Auto-generated method stub
					if (o1.getPriority() > o2.getPriority()) {
						return -1;
					} else if (o1.getPriority() == o2.getPriority()) {
						return 0;
					} else {
						return 1;
					}
				}
			});
		}
	}

	/**
	 * 是否能添加action
	 * 
	 * @param action
	 * @param actionList
	 * @return
	 */
	private boolean canAddAction(MessageAction action,
			ArrayList<MessageAction> actionList) {
		for (MessageAction messageAction : actionList) {
			if (messageAction.getTitle().equalsIgnoreCase(action.getTitle())) {
				return false;
			}
		}
		return true;
	}

	private final static String NO_SUBJECT = "noSubject";

	public synchronized void sendMessage(MessageSubject messageSubject,
			Object... objects) {
		if (null == actionMap) {
			return;
		}

		if (!messageSubject.getTitle().equals(NO_SUBJECT)) {

			MessageSubject keyMessageSubject = queryMessageSubject(messageSubject
					.getTitle());
			if (null != keyMessageSubject) {
				ArrayList<MessageAction> actions = actionMap
						.get(keyMessageSubject);
				if (null != actions && actions.size() > 0) {
					for (MessageAction action : actions) {
						if (action != null && action.getListener() != null) {
							action.getListener().actionMessage(objects);
						}
					}
				}
			}
		} else {
			Iterator<MessageSubject> iterator = actionMap.keySet().iterator();
			while (iterator.hasNext()) {
				MessageSubject keyMessageSubject = iterator.next();
				ArrayList<MessageAction> actions = actionMap
						.get(keyMessageSubject);
				if (null != actions && actions.size() > 0) {
					for (MessageAction action : actions) {
						if (action != null && action.getListener() != null) {
							action.getListener().actionMessage(objects);
						}
					}
				}
			}
		}
	}

	/**
	 * 发送消息
	 * 
	 * @param subject
	 *            消息主题
	 * @param objects
	 *            消息参数
	 */
	public synchronized void sendMessage(String subject, Object... objects) {
		MessageSubject messageSubject = null;
		if (subject.equals(NO_SUBJECT)) {
			messageSubject = new MessageSubject(NO_SUBJECT);
		} else {
			messageSubject = queryMessageSubject(subject);
		}
		if (null != messageSubject) {
			sendMessage(messageSubject, objects);
		}
	}

	/**
	 * 发送消息，不做主题区分
	 * 
	 * @param objects
	 */

	public synchronized void sendMessage(Object... objects) {
		sendMessage(NO_SUBJECT, objects);
	}

	/**
	 * 清理主题响应
	 * 
	 * @param subject
	 */
	public synchronized void clearActions(String subject) {
		MessageSubject messageSubject = null;
		if (subject.equals(NO_SUBJECT)) {
			messageSubject = new MessageSubject(NO_SUBJECT);
		} else {
			messageSubject = queryMessageSubject(subject);
		}
		if (null != messageSubject) {
			clearActions(messageSubject);
		}
	}

	public synchronized void clearActions(MessageSubject messageSubject) {
		if (null == actionMap) {
			return;
		}
		if (messageSubject.getTitle().equals(NO_SUBJECT)) {
			Iterator<MessageSubject> iterator = actionMap.keySet().iterator();
			while (iterator.hasNext()) {
				MessageSubject keyMessageSubject = iterator.next();
				ArrayList<MessageAction> actions = actionMap
						.get(keyMessageSubject);
				if (null != actions) {
					actions.clear();
				}
			}

		} else {
			MessageSubject keyMessageSubject = queryMessageSubject(messageSubject
					.getTitle());
			if (null != keyMessageSubject) {
				ArrayList<MessageAction> actions = actionMap
						.get(keyMessageSubject);
				if (null != actions) {
					actions.clear();
				}
			}
		}
	}

	/**
	 * 清理所有响应
	 */
	public synchronized void clearActions() {
		clearActions(NO_SUBJECT);
	}

}
