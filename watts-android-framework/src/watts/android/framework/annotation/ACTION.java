package watts.android.framework.annotation;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
/**
 * @ClassName: ACTION
 * @Description:  请求action,url后面
 * @author shanxiaoping
 * @date 2015年12月31日 下午12:06:23
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface ACTION {
	String value() default "";
}
