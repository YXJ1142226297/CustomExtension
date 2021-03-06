#
#  Be sure to run `pod spec lint CustomExtension.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "CustomExtension"
  spec.version      = "0.0.1"
  spec.summary      = "自定义扩展"


  spec.description  = <<-DESC
  1.Array读写历史数据 2.Date当前日期(年,月,日,周),当前日期字符串,是否是今天,日期转日期字符串,日期字符串转日期,计算天数差,比较日期前后,获取当前时间戳,判断什么时候前,获取当前时间内前后数据 3.DictionryBase64下词典解密 4.NSAttributedString富文本创建 5.String 是否包含中文,是否是纯数字,是否是金额,是否是手机号,是否是校验码,是否是身份证,插入字符串,截取字符串,手机号加*,去除Emoji表情,生成随机字符串,显示HTML文本,是否包含字符串,清除字符串空格,反转字符串,将字符串拆分数组,对字符串中数字加颜色,Cache,Document,Tmp目录,字符串首尾字母,MD5值,Base64转解码,GB2312转解码 6.UIButton按钮文字尺寸,文字按钮,图片按钮,背景图片按钮,倒计时按钮创建 7.UIColor色值字符生成颜色,随机色 8.UIImage颜色生成图片,图片设置圆角,图片按比例调整,图片压缩,字符串生成二维码,图片文件压缩,图片添加水印 9.UIImageView图片创建 10.UILable文本,富文本创建,文本高度,文本宽度  11.UIPageControl创建 12.UIScrollView创建 13.UITextField创建 14.UITextView创建 15.UIView创建,设置圆角,设置边框,添加子视图,CenterY,CenterX,上,下,左,右,宽,高定义
                   DESC

  spec.homepage     = "https://github.com/YXJ1142226297/CustomExtension"
  spec.license      = "MIT"

  spec.author             = { "于晓杰" => "1142226297@qq.com" }

  spec.platform     = :ios, "9.0"
  spec.swift_version = '5.0'

  spec.source       = { :git => "https://github.com/YXJ1142226297/CustomExtension.git", :tag => "0.0.1" }

  spec.source_files  = "CustomExtension/*.swift"

end
