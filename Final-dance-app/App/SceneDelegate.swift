import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    var di = Di()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = di.makeWindowWithController(scene: windowScene)
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
 
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
  
    }


}

extension UIViewController {
    var sceneDelegate: SceneDelegate? {
        for scene in UIApplication.shared.connectedScenes {
            var delegate = scene.delegate as! SceneDelegate
            return delegate
        }
        return nil
    }
}
