import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {

  var statusBar: StatusBarController?
  var popover = NSPopover.init()

  override func applicationDidFinishLaunching(_ notification: Notification) {
    popover.contentSize = NSSize(width: 360, height: 360)
    popover.contentViewController = FlutterViewController()
    statusBar = StatusBarController.init(popover)
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
