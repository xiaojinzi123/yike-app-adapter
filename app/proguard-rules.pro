# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

###################### Gson start ######################

# Gson uses generic type information stored in a class file when working with
# fields. Proguard removes such information by default, keep it.
-keepattributes Signature

# This is also needed for R8 in compat mode since multiple
# optimizations will remove the generic signature such as class
# merging and argument removal. See:
# https://r8.googlesource.com/r8/+/refs/heads/main/compatibility-faq.md#troubleshooting-gson-gson
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

# Optional. For using GSON @Expose annotation
-keepattributes AnnotationDefault,RuntimeVisibleAnnotations

###################### Gson end ######################

# 本地库的反射与 JNI 元数据。
-keepattributes InnerClasses,EnclosingMethod,*Annotation*,Exceptions
-keepclasseswithmembers class * {
    native <methods>;
}

# ------------------------ UCrop https://github.com/Yalantis/uCrop ----------------------
-dontwarn com.yalantis.ucrop**
-keep class com.yalantis.ucrop** { *; }
-keep interface com.yalantis.ucrop** { *; }
# ------------------------ UCrop ----------------------

# ------------------------ RxFFmpeg ----------------------
-dontwarn io.microshow.rxffmpeg.**
-keep class io.microshow.rxffmpeg.**{*;}
# ------------------------ RxFFmpeg ----------------------

# ------------------------ SVGAPlayer ----------------------
# https://github.com/svga/SVGAPlayer-Android
-keep class com.squareup.wire.** { *; }
-keep class com.opensource.svgaplayer.proto.** { *; }
# ------------------------ SVGAPlayer ----------------------

# Coil 的本地图片加载仍使用 OkHttp 类型，保留其兼容规则。
# ------------------------ okhttp ----------------------

# JSR 305 annotations are for embedding nullability information.
-dontwarn javax.annotation.**

# A resource is loaded with a relative path so the package of this class must be preserved.
-adaptresourcefilenames okhttp3/internal/publicsuffix/PublicSuffixDatabase.gz

# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*

# OkHttp platform used only on JVM and when Conscrypt and other security providers are available.
-dontwarn okhttp3.internal.platform.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# ------------------------ okhttp ----------------------

# XLS 仅调用文本/数值/日期读取；POI 的桌面绘图和 Log4j 的 OSGi 是可选路径。
# 已使用拒绝 AWT/OSGi 的类加载器验证 WorkbookFactory XLS 导入。
-dontwarn aQute.bnd.annotation.spi.ServiceConsumer
-dontwarn aQute.bnd.annotation.spi.ServiceProvider
-dontwarn java.awt.Color
-dontwarn java.awt.Dimension
-dontwarn java.awt.Rectangle
-dontwarn java.awt.color.ColorSpace
-dontwarn java.awt.geom.AffineTransform
-dontwarn java.awt.geom.Dimension2D
-dontwarn java.awt.geom.Path2D
-dontwarn java.awt.geom.PathIterator
-dontwarn java.awt.geom.Point2D
-dontwarn java.awt.geom.Rectangle2D
-dontwarn java.awt.image.BufferedImage
-dontwarn java.awt.image.ColorModel
-dontwarn java.awt.image.ComponentColorModel
-dontwarn java.awt.image.DirectColorModel
-dontwarn java.awt.image.IndexColorModel
-dontwarn java.awt.image.PackedColorModel
-dontwarn org.osgi.framework.Bundle
-dontwarn org.osgi.framework.BundleContext
-dontwarn org.osgi.framework.FrameworkUtil
-dontwarn org.osgi.framework.ServiceReference

# WorkbookFactory 通过 META-INF/services 创建 XLS provider。
-keep class org.apache.poi.hssf.usermodel.HSSFWorkbookFactory {
    public <init>();
}

# ------------------------ 小金子mvvm reactive 框架 start ----------------------
# 忽略 com.xiaojinzi.reactive.anno.IntentProcess 注解标记的所有方法
-keepclasseswithmembers class * {
    @com.xiaojinzi.reactive.anno.IntentProcess *;
}
# ------------------------ 小金子mvvm reactive 框架 end ----------------------

# ------------------------ 小金子组件化框架 不要警告 ----------------------
-dontwarn com.xiaojinzi.component.**
# 所有本包下面的类和接口都不混淆
-keep class com.xiaojinzi.component.** {*;}
-keep interface com.xiaojinzi.component.** {*;}
#这些是让被标记的类不被混淆
-keep @com.xiaojinzi.component.anno.InterceptorAnno class * {*;}
-keep @com.xiaojinzi.component.anno.GlobalInterceptorAnno class * {*;}
-keep @com.xiaojinzi.component.anno.ConditionalAnno class * {*;}
-keep @com.xiaojinzi.component.anno.FragmentAnno class * {*;}
-keep @com.xiaojinzi.component.anno.ServiceAnno class * {*;}
-keep @com.xiaojinzi.component.anno.support.ComponentGeneratedAnno class * {*;}
-keep @com.xiaojinzi.component.anno.router.RouterApiAnno interface * {*;}
#保留生成的 Router Api
-keep class **.**RouterApiGenerated {*;}
#几个用户自定义或者自动生成到其他包下的应该不混淆
-keep class * implements com.xiaojinzi.component.impl.RouterInterceptor{*;}
-keep class * implements com.xiaojinzi.component.support.IBaseLifecycle{*;}
-keep class * implements com.xiaojinzi.component.application.IApplicationLifecycle{*;}
-keep class * implements com.xiaojinzi.component.application.IComponentApplication{*;}
-keep class * implements com.xiaojinzi.component.support.Inject{*;}
# ------------------------ 小金子组件化框架 不要警告 ----------------------
