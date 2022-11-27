// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
// 
import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Localized {
  /// NIL
  public static let packetNil = Localized.tr("Localizable", "packet_nil", fallback: "NIL")
  /// Localizable.strings
  ///   Biscuit
  /// 
  ///   Created by Andras Olah on 2022. 10. 23..
  public static let packetNothingToShow = Localized.tr("Localizable", "packet_nothing_to_show", fallback: "Nothing to show")
  /// REQUEST BODY:
  public static let packetRequestBody = Localized.tr("Localizable", "packet_request_body", fallback: "REQUEST BODY:")
  /// REQUEST HEADERS:
  public static let packetRequestHeaders = Localized.tr("Localizable", "packet_request_headers", fallback: "REQUEST HEADERS:")
  /// RESPONSE BODY
  public static let packetResponseBody = Localized.tr("Localizable", "packet_response_body", fallback: "RESPONSE BODY")
  public enum AppError {
    /// Error during connection. Is the port open? Maybe Bagel is running
    public static let cannotConnect = Localized.tr("Localizable", "AppError.cannotConnect", fallback: "Error during connection. Is the port open? Maybe Bagel is running")
  }
  public enum HeaderView {
    /// Device
    public static let deviceTitle = Localized.tr("Localizable", "HeaderView.deviceTitle", fallback: "Device")
    /// Project
    public static let projectTitle = Localized.tr("Localizable", "HeaderView.projectTitle", fallback: "Project")
    /// Toggle
    public static let toggleHelp = Localized.tr("Localizable", "HeaderView.toggleHelp", fallback: "Toggle")
  }
  public enum LogView {
    /// Url
    public static let filterPlaceholder = Localized.tr("Localizable", "LogView.filterPlaceholder", fallback: "Url")
    /// Filter:
    public static let filterTitle = Localized.tr("Localizable", "LogView.filterTitle", fallback: "Filter:")
    /// Reset message hiding
    public static let hideMessagesButtonContextReset = Localized.tr("Localizable", "LogView.hideMessagesButtonContextReset", fallback: "Reset message hiding")
    /// Hide current messages
    public static let hideMessagesButtonHelp = Localized.tr("Localizable", "LogView.hideMessagesButtonHelp", fallback: "Hide current messages")
    public enum ContextMenu {
      /// Clear from here
      public static let clearFromHere = Localized.tr("Localizable", "LogView.contextMenu.clearFromHere", fallback: "Clear from here")
      /// Export and zip selected message Body
      public static let exportAndZipSelectedBody = Localized.tr("Localizable", "LogView.contextMenu.exportAndZipSelectedBody", fallback: "Export and zip selected message Body")
      /// Export selected message Body
      public static let exportSelectedBody = Localized.tr("Localizable", "LogView.contextMenu.exportSelectedBody", fallback: "Export selected message Body")
      /// Pin selected
      public static let pinSelected = Localized.tr("Localizable", "LogView.contextMenu.pinSelected", fallback: "Pin selected")
      /// Unpin selected
      public static let unpinSelected = Localized.tr("Localizable", "LogView.contextMenu.unpinSelected", fallback: "Unpin selected")
    }
    public enum TableColumn {
      /// Date
      public static let date = Localized.tr("Localizable", "LogView.tableColumn.date", fallback: "Date")
      /// Method
      public static let method = Localized.tr("Localizable", "LogView.tableColumn.method", fallback: "Method")
      /// Status
      public static let status = Localized.tr("Localizable", "LogView.tableColumn.status", fallback: "Status")
      /// Url
      public static let url = Localized.tr("Localizable", "LogView.tableColumn.url", fallback: "Url")
    }
  }
  public enum MenuItem {
    /// Delete offline device
    public static let deleteOfflineDevice = Localized.tr("Localizable", "MenuItem.deleteOfflineDevice", fallback: "Delete offline device")
    /// Export packets
    public static let exportPackets = Localized.tr("Localizable", "MenuItem.exportPackets", fallback: "Export packets")
  }
  public enum Messages {
    public enum CopyToPasteboard {
      /// No response body
      public static let emptybody = Localized.tr("Localizable", "Messages.CopyToPasteboard.emptybody", fallback: "No response body")
      /// Nothing selected
      public static let nopacket = Localized.tr("Localizable", "Messages.CopyToPasteboard.nopacket", fallback: "Nothing selected")
      /// Response body copied to Pasteboard
      public static let success = Localized.tr("Localizable", "Messages.CopyToPasteboard.success", fallback: "Response body copied to Pasteboard")
    }
    public enum Export {
      /// There were %d bodyless packets
      public static func emptyBodyForPackets(_ p1: Int) -> String {
        return Localized.tr("Localizable", "Messages.Export.emptyBodyForPackets", p1, fallback: "There were %d bodyless packets")
      }
    }
  }
  public enum PacketView {
    public enum Button {
      /// Copy body to Clipboard
      public static let copyToPasteboard = Localized.tr("Localizable", "PacketView.Button.copyToPasteboard", fallback: "Copy body to Clipboard")
    }
    public enum Tab {
      /// Overview
      public static let overview = Localized.tr("Localizable", "PacketView.Tab.overview", fallback: "Overview")
      /// Request
      public static let request = Localized.tr("Localizable", "PacketView.Tab.request", fallback: "Request")
      /// Response
      public static let response = Localized.tr("Localizable", "PacketView.Tab.response", fallback: "Response")
    }
  }
  public enum RequestView {
    public enum Tab {
      /// Body
      public static let body = Localized.tr("Localizable", "RequestView.Tab.body", fallback: "Body")
      /// Headers
      public static let headers = Localized.tr("Localizable", "RequestView.Tab.headers", fallback: "Headers")
      /// Parameters
      public static let parameters = Localized.tr("Localizable", "RequestView.Tab.parameters", fallback: "Parameters")
    }
  }
  public enum ResponseView {
    public enum Tab {
      /// Body
      public static let body = Localized.tr("Localizable", "ResponseView.Tab.body", fallback: "Body")
      /// Headers
      public static let headers = Localized.tr("Localizable", "ResponseView.Tab.headers", fallback: "Headers")
    }
  }
  public enum SavePanel {
    public enum Exportpacket {
      /// Choose a folder and a name to store the packet.
      public static let message = Localized.tr("Localizable", "SavePanel.exportpacket.message", fallback: "Choose a folder and a name to store the packet.")
      /// Packet file name:
      public static let namefield = Localized.tr("Localizable", "SavePanel.exportpacket.namefield", fallback: "Packet file name:")
      /// Save packet
      public static let title = Localized.tr("Localizable", "SavePanel.exportpacket.title", fallback: "Save packet")
    }
  }
  public enum StandardPicker {
    /// None
    public static let noneSelected = Localized.tr("Localizable", "StandardPicker.noneSelected", fallback: "None")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
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
