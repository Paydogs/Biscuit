// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
// 
import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Localizable {
  /// NIL
  public static let packetNil = Localizable.tr("Localizable", "packet_nil", fallback: "NIL")
  /// Localizable.strings
  ///   Biscuit
  /// 
  ///   Created by Andras Olah on 2022. 10. 23..
  public static let packetNothingToShow = Localizable.tr("Localizable", "packet_nothing_to_show", fallback: "Nothing to show")
  /// REQUEST BODY:
  public static let packetRequestBody = Localizable.tr("Localizable", "packet_request_body", fallback: "REQUEST BODY:")
  /// REQUEST HEADERS:
  public static let packetRequestHeaders = Localizable.tr("Localizable", "packet_request_headers", fallback: "REQUEST HEADERS:")
  /// RESPONSE BODY
  public static let packetResponseBody = Localizable.tr("Localizable", "packet_response_body", fallback: "RESPONSE BODY")
  public enum MenuItem {
    /// Export packets
    public static let exportPackets = Localizable.tr("Localizable", "MenuItem.export_packets", fallback: "Export packets")
  }
  public enum SavePanel {
    /// Choose a folder and a name to store the packet.
    public static let exportpacketMessage = Localizable.tr("Localizable", "SavePanel.exportpacket_message", fallback: "Choose a folder and a name to store the packet.")
    /// Packet file name:
    public static let exportpacketNamefield = Localizable.tr("Localizable", "SavePanel.exportpacket_namefield", fallback: "Packet file name:")
    /// Save packet
    public static let exportpacketTitle = Localizable.tr("Localizable", "SavePanel.exportpacket_title", fallback: "Save packet")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
