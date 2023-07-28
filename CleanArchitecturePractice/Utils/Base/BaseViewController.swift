

import UIKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        setNavigation()
        view.backgroundColor = .white
    }
    
    func configureUI() { }
    func setConstraints() { }
    func setNavigation() { }
    
}
