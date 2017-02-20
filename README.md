polyv-ios-client-demo
=====================
参考polyv ios sdk集成指南 https://github.com/easefun/polyv-ios-sdk/wiki

## ATS 支持

保利威视点播 iOS SDK 现已全面支持 ATS（App Transport Security），所有 API 都已使用 HTTPS 请求。用户需使用最新版本 SDK 即可完成升级。

## 新版本 SDK 使用

在项目 info.plist 中添加以下内容：

```xml
	<!-- 添加配置 -->
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>localhost</key>
			<dict>
				<key>NSTemporaryExceptionAllowsInsecureHTTPSLoads</key>
				<false/>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSTemporaryExceptionMinimumTLSVersion</key>
				<string>1.0</string>
				<key>NSTemporaryExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
		</dict>
		<!-- 项目还有 HTTP 请求，或开启 HttpDNS 功能，保留以下配置 -->
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
```

若您的项目还有 HTTP 请求，或开启 HttpDNS 功能，应保留以下配置：

```xml
		<key>NSAllowsArbitraryLoads</key>
		<true/>
```

## 特别说明

__当使用 Xcode 8 或以上版本编译器时，需要把目录下的 `AdditionalLibrary` 文件夹拖入工程参与编译，否则会出现 `linker command failed` 错误。__