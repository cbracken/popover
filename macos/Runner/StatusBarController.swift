import Cocoa
import FlutterMacOS

class MyPopover : NSPopover {
  override func mouseDown(with event: NSEvent) {
    print("====> MyPopover mouseDown")
    super.mouseDown(with: event)
  }

  override func mouseUp(with event: NSEvent) {
    print("====> MyPopover mouseUp")
    super.mouseUp(with: event)
  }
}

class TestViewController : NSViewController {
  override func loadView() {
    let textfield = NSTextField()
    textfield.stringValue = "Hello world"
    textfield.backgroundColor = .white
    textfield.isEditable = false
    textfield.sizeToFit()
    self.view = textfield
  }

  override func mouseDown(with event: NSEvent) {
    print("====> TestViewController mouseDown")
    super.mouseDown(with: event)
  }

  override func mouseUp(with event: NSEvent) {
    print("====> TestViewController mouseUp")
    super.mouseUp(with: event)
  }
}

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover

    init(_ popover: NSPopover) {
      self.popover = popover
      statusBar = NSStatusBar.init()
      statusItem = statusBar.statusItem(withLength: 28.0)

      if let statusBarButton = statusItem.button {
        statusBarButton.image = #imageLiteral(resourceName: "FlutterLogo")
        statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
        statusBarButton.image?.isTemplate = true
        statusBarButton.action = #selector(togglePopover(sender:))
        statusBarButton.target = self
      }
    }

    func printResponderChain(from responder: NSResponder?) {
      var responder = responder
      print("###### Responder chain")
      while let r = responder {
        print(r)
        responder = r.nextResponder
      }
      print("######")
    }

    @objc func togglePopover(sender: AnyObject) {
      if(popover.isShown) {
        hidePopover(sender)
      }
      else {
        showPopover(sender)
      }
    }

    func showPopover(_ sender: AnyObject) {
      if let statusBarButton = statusItem.button {
        popover.show(relativeTo: statusBarButton.bounds,
                     of: statusBarButton,
                     preferredEdge: NSRectEdge.maxY)
        printResponderChain(from: popover.contentViewController?.view)
      }
    }

    func hidePopover(_ sender: AnyObject) {
      popover.performClose(sender)
    }
}
