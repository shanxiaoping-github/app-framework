package sxp.android.framework.util;

import java.io.File;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Toast;

/**
 * 显示工具类
 * 
 * @author Administrator
 * 
 */
public class ShowUtil{
	/*************************************** 提示 *******************************************/
	public static void showShortToast(Context context, int pResId) {
		showShortToast(context, context.getString(pResId));
	}

	public static void showLongToast(Context context, String pMsg) {
		Toast.makeText(context, pMsg, Toast.LENGTH_LONG).show();
	}

	public static void showShortToast(Context context, String pMsg) {
		Toast.makeText(context, pMsg, Toast.LENGTH_SHORT).show();
	}

	/* 加载布局文件 */
	public static View LoadXmlView(Context context, int xmlId) {
		LayoutInflater flat = LayoutInflater.from(context);
		View view = flat.inflate(xmlId, null);
		return view;
	}

	/**
	 * 选相册
	 * 
	 * @param activity
	 *            类
	 * @param flat
	 *            标志
	 */
	public static void selectAlbum(Activity activity, int flat) {

		Intent intent = new Intent();
		/* 开启Pictures画面Type设定为image */
		intent.setType("image/*");
		/* 使用Intent.ACTION_GET_CONTENT这个Action */
		intent.setAction(Intent.ACTION_GET_CONTENT);
		/* 取得相片后返回本画面 */
		activity.startActivityForResult(intent, flat);

	}

	/**
	 * 获得选择照片的路径
	 * 
	 * @param activity
	 *            上下文
	 * @param data
	 *            返回的intent
	 * @return 路径
	 */
	public static String getAlbumPath(Activity activity, Intent data) {
		try {
			
			
			// 获得图片的uri
			Uri originalUri = data.getData();
			// 这里开始的第二部分，获取图片的路径：
			String[] proj = { MediaStore.Images.Media.DATA };
			Cursor cursor = activity.managedQuery(originalUri, proj, null,
					null, null);
			// 按我个人理解 这个是获得用户选择的图片的索引值
			int columnIndex = cursor
					.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
			cursor.moveToFirst();
			// 最后根据索引值获取图片路径
			String path = cursor.getString(columnIndex);
			return path;

		} catch (Exception e) {

			return "";
		}

	}

	/**
	 * 拍照
	 * 
	 * @param activity
	 * @param file
	 *            拍照后存储文件
	 * @param flat
	 *            标志值
	 */
	public static void selectTakingPictures(Activity activity, File file,
			int flat) {
		Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
		intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(file));
		activity.startActivityForResult(intent, flat);

	}

	/**
	 * 获得颜色处理后的文字
	 * @param contentStr 文字内容
	 * @param indexArray 下标数组
	 * @param colors 颜色数组
	 * @return
	 */
	public static SpannableStringBuilder getSpannableText(String contentStr,
			int[][] indexArray, int[] colors) {
		SpannableStringBuilder style = new SpannableStringBuilder(contentStr);
		for (int i = 0; i < colors.length; i++) {
			style.setSpan(new ForegroundColorSpan(colors[i]), indexArray[i][0],
					indexArray[i][1], Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
		}
		return style;
	}

}
