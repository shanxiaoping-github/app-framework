package sxp.android.framework.util;

import java.io.File;
import java.util.UUID;

import android.os.Environment;

/**
 * @ClassName: FileUtil
 * @Description: 文件操作
 * @author shanxiaoping
 * @date 2016年1月1日 下午6:33:29
 */
public class FileUtil {
	/**
	 * 获得sd卡路径
	 * 
	 * @return
	 */
	public static String getSDPath() {

		boolean sdCardExist = Environment.getExternalStorageState().equals(
				Environment.MEDIA_MOUNTED); // 判断sd卡是否存在
		if (sdCardExist) {
			File sdDir = Environment.getExternalStorageDirectory();// 获取跟目录
			return sdDir.toString() + "/";
		} else {

			return "";
		}

	}

	/**
	 * 创建路径
	 * 
	 * @param path
	 *            路径地址
	 * @return 是否创建成功
	 */
	public static Boolean creatPath(String path) {

		File file = new File(path);
		if (file.exists()) {

			return false;
		}
		if (path.endsWith(File.separator)) {
			file.mkdirs();
			return true;
		}
		// 判断目标文件所在的目录是否存在
		if (!file.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录

			if (!file.getParentFile().mkdirs()) {

				return false;
			}
		}
		// 创建目标文件
		try {
			if (file.createNewFile()) {

				return true;
			} else {

				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();

			return false;
		}

	}

	/**
	 * 获得唯一标示
	 * 
	 * @return
	 */
	public static String getMyUUID() {

		UUID uuid = UUID.randomUUID();
		String uniqueId = uuid.toString();
		String resultStr = uniqueId.replaceAll("-", "");
		return resultStr;
	}

	/**
	 * 判断是否是图片
	 * 
	 * @param imagePath
	 * @return
	 */
	private static final String[] imageSuffix = new String[] {

	".bmp", ".BMP", ".jpeg", ".JPEG", ".jpg", ".JPG", ".gif", ".GIF", ".png",
			".PNG" };

	public static boolean isImage(String imagePath) {
		for (String suffix : imageSuffix) {
			if (imagePath.endsWith(suffix)) {
				return true;
			}

		}
		return false;
	}

	/**
	 * 获得一个文件的大小
	 * 
	 * @param file
	 * @return
	 */
	public static long fileSize(File file) {
		if (file.exists() && file.isFile()) {
			return file.length();
		}

		return 0;

	}

	/**
	 * 返回文件大小
	 * 
	 * @param fileName
	 * @return
	 */
	public static long fileSize(String fileName) {
		File file = new File(fileName);
		return fileSize(file);
	}

	/**
	 * 根据路径删除指定的目录或文件，无论存在与否
	 *
	 * @param sPath
	 *            要删除的目录或文件
	 * @return 删除成功返回 true，否则返回 false。
	 */
	public static boolean DeleteFolder(String sPath) {
		boolean flag = false;
		File file = new File(sPath);
		// 判断目录或文件是否存在
		if (!file.exists()) { // 不存在返回 false
			return flag;
		} else {
			// 判断是否为文件
			if (file.isFile()) { // 为文件时调用删除文件方法
				return deleteFile(sPath);
			} else { // 为目录时调用删除目录方法
				return deleteDirectory(sPath);
			}
		}
	}

	/**
	 * 删除单个文件
	 * 
	 * @param sPath
	 *            被删除文件的文件名
	 * @return 单个文件删除成功返回true，否则返回false
	 */
	public static boolean deleteFile(String sPath) {
		boolean flag = false;
		File file = new File(sPath);
		// 路径为文件且不为空则进行删除
		if (file.isFile() && file.exists()) {
			file.delete();
			flag = true;
		}
		return flag;
	}

	/**
	 * 删除目录（文件夹）以及目录下的文件
	 * 
	 * @param sPath
	 *            被删除目录的文件路径
	 * @return 目录删除成功返回true，否则返回false
	 */
	public static boolean deleteDirectory(String sPath) {
		// 如果sPath不以文件分隔符结尾，自动添加文件分隔符
		if (!sPath.endsWith(File.separator)) {
			sPath = sPath + File.separator;
		}
		File dirFile = new File(sPath);
		// 如果dir对应的文件不存在，或者不是一个目录，则退出
		if (!dirFile.exists() || !dirFile.isDirectory()) {
			return false;
		}
		boolean flag = true;
		// 删除文件夹下的所有文件(包括子目录)
		File[] files = dirFile.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 删除子文件
			if (files[i].isFile()) {
				flag = deleteFile(files[i].getAbsolutePath());
				if (!flag)
					break;
			} // 删除子目录
			else {
				flag = deleteDirectory(files[i].getAbsolutePath());
				if (!flag)
					break;
			}
		}
		if (!flag)
			return false;
		// 删除当前目录
		if (dirFile.delete()) {
			return true;
		} else {
			return false;
		}
	}

}
