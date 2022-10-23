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
  public enum LogView {
    public enum ContextMenu {
      /// Export
      public static let export = Localizable.tr("Localizable", "LogView.contextMenu.export", fallback: "Export")
    }
    public enum TableColumn {
      /// Date
      public static let date = Localizable.tr("Localizable", "LogView.tableColumn.date", fallback: "Date")
      /// Method
      public static let method = Localizable.tr("Localizable", "LogView.tableColumn.method", fallback: "Method")
      /// Status
      public static let status = Localizable.tr("Localizable", "LogView.tableColumn.status", fallback: "Status")
      /// Url
      public static let url = Localizable.tr("Localizable", "LogView.tableColumn.url", fallback: "Url")
    }
  }
  public enum MenuItem {
    /// Export packets
    public static let exportPackets = Localizable.tr("Localizable", "MenuItem.export_packets", fallback: "Export packets")
  }
  public enum PacketView {
    public enum Button {
      /// Copy body to Clipboard
      public static let copyToPasteboard = Localizable.tr("Localizable", "PacketView.Button.copyToPasteboard", fallback: "Copy body to Clipboard")
    }
    public enum Tab {
      /// Overview
      public static let overview = Localizable.tr("Localizable", "PacketView.Tab.overview", fallback: "Overview")
      /// Request
      public static let request = Localizable.tr("Localizable", "PacketView.Tab.request", fallback: "Request")
      /// Response
      public static let response = Localizable.tr("Localizable", "PacketView.Tab.response", fallback: "Response")
    }
  }
  public enum RequestView {
    public enum Tab {
      /// Body
      public static let body = Localizable.tr("Localizable", "RequestView.Tab.body", fallback: "Body")
      /// Headers
      public static let headers = Localizable.tr("Localizable", "RequestView.Tab.headers", fallback: "Headers")
      /// Parameters
      public static let parameters = Localizable.tr("Localizable", "RequestView.Tab.parameters", fallback: "Parameters")
    }
  }
  public enum ResponseView {
    public enum Tab {
      /// Body
      public static let body = Localizable.tr("Localizable", "ResponseView.Tab.body", fallback: "Body")
      /// Headers
      public static let headers = Localizable.tr("Localizable", "ResponseView.Tab.headers", fallback: "Headers")
    }
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
