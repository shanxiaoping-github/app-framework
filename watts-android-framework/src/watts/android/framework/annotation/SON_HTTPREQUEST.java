package watts.android.framework.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import watts.android.framework.http.HttpRequest;

/**
 * @ClassName: SON_HTTPREQUEST
 * @Description: 子请求
 * @author shanxiaoping
 * @date 2015年12月31日 下午3:01:23
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface SON_HTTPREQUEST {
  Class<? extends HttpRequest<?, ?, ?>> fatherClass();
}
