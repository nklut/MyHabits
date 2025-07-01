import UIKit

class _sampleView: UIViewController {
  
  let myNotification = Notification.Name(rawValue:"MyNotification")

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nc = NotificationCenter.default
    nc.addObserver(forName:myNotification, object:nil, queue:nil, using:catchNotification)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let nc = NotificationCenter.default
    nc.post(name: myNotification, object: nil, userInfo:["message": "Hello there!", "date": Date()])
  }
  
  func catchNotification(notification:Notification) -> Void {
      
      self.navigationController?.pushViewController(HabitsViewController(), animated: true)
      print("Catch notification")
    
    guard let userInfo = notification.userInfo,
          let message  = userInfo["message"] as? String,
          let date     = userInfo["date"]    as? Date else {
        print("No userInfo found in notification")
        return
    }
    
    let alert = UIAlertController(title: "Notification!",
                                  message:"\(message) received at \(date)",
                                  preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
