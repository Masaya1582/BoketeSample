


import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
    private func setupView() {
        shareButton.layer.cornerRadius = 20.0
        backButton.layer.cornerRadius = 20.0
        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func takeScreenShot() {
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height / 1.3)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        takeScreenShot()
        let items = [screenShotImage] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    


}
