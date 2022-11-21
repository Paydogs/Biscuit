// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum GeneratedColors {
  public enum Defaults {
    public static let green = ColorAsset(name: "Green")
    public static let indigo = ColorAsset(name: "Indigo")
    public static let lightBlue = ColorAsset(name: "LightBlue")
    public static let mediumBlue = ColorAsset(name: "MediumBlue")
    public static let orange = ColorAsset(name: "Orange")
    public static let purple = ColorAsset(name: "Purple")
    public static let red = ColorAsset(name: "Red")
    public static let white = ColorAsset(name: "White")
    public static let yellow = ColorAsset(name: "Yellow")
  }
  public enum DeviceStatus {
    public static let statusActive = ColorAsset(name: "StatusActive")
    public static let statusOffline = ColorAsset(name: "StatusOffline")
  }
  public enum ErrorView {
    public static let errorBackground = ColorAsset(name: "ErrorBackground")
    public static let errorForeground = ColorAsset(name: "ErrorForeground")
  }
  public enum HeaderView {
    public static let headerBackground = ColorAsset(name: "HeaderBackground")
  }
  public enum HttpStatusCode {
    public static let http1xx = ColorAsset(name: "Http1xx")
    public static let http2xx = ColorAsset(name: "Http2xx")
    public static let http3xx = ColorAsset(name: "Http3xx")
    public static let http4xx = ColorAsset(name: "Http4xx")
    public static let http5xx = ColorAsset(name: "Http5xx")
    public static let httpDefault = ColorAsset(name: "HttpDefault")
  }
  public enum Json {
    public static let literalValue = ColorAsset(name: "LiteralValue")
    public static let memberKey = ColorAsset(name: "MemberKey")
    public static let numericValue = ColorAsset(name: "NumericValue")
    public static let `operator` = ColorAsset(name: "Operator")
    public static let stringValue = ColorAsset(name: "StringValue")
    public static let unknown = ColorAsset(name: "Unknown")
    public static let whitespace = ColorAsset(name: "Whitespace")
  }
  public enum Overview {
    public static let category = ColorAsset(name: "Category")
    public static let headerKey = ColorAsset(name: "HeaderKey")
    public static let headerValue = ColorAsset(name: "HeaderValue")
    public static let requestMethod = ColorAsset(name: "RequestMethod")
  }
  public enum RequestMethod {
    public static let requestMethodDefault = ColorAsset(name: "RequestMethodDefault")
    public static let requestMethodDelete = ColorAsset(name: "RequestMethodDelete")
    public static let requestMethodGet = ColorAsset(name: "RequestMethodGet")
    public static let requestMethodPost = ColorAsset(name: "RequestMethodPost")
    public static let requestMethodPut = ColorAsset(name: "RequestMethodPut")
  }
  public enum Text {
    public static let primary = ColorAsset(name: "Primary")
    public static let secondary = ColorAsset(name: "Secondary")
    public static let textBackground = ColorAsset(name: "TextBackground")
  }
  public enum View {
    public static let mainBackground = ColorAsset(name: "MainBackground")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
