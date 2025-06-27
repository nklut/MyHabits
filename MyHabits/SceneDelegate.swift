import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        // Feed Nav Controller Setup
        let habitsNavigationController = UINavigationController()
        habitsNavigationController.tabBarItem.title = "Habits"
        habitsNavigationController.tabBarItem.image = UIImage(systemName: "list.bullet")
        habitsNavigationController.viewControllers = [HabitsViewController()]        
        
        // Profile Nav Controller Setup
        let infoNavigationController = UINavigationController()
        infoNavigationController.tabBarItem.title = "Info"
        infoNavigationController.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        infoNavigationController.viewControllers = [InfoViewController()]
        
        // Tab bar Controller Setup
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .mhPurple
        tabBarController.viewControllers = [habitsNavigationController, infoNavigationController]
           
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}
