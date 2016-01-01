package sxp.android.framework.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
/**
 * @ClassName: URL
 * @Description: url注解
 * @author shanxiaoping
 * @date 2015年12月31日 下午12:04:17
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface URL {
	String value() default "";
}

