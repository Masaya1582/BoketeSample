


import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        commentTextView.layer.cornerRadius = 20.0
        nextButton.layer.cornerRadius = 20.0
        okButton.layer.cornerRadius = 20.0
        PHPhotoLibrary.requestAuthorization { (states) in
            switch(states) {
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .limited:
                break
            case .authorized:
                break
            @unknown default:
                print("エラー")
            }
        }
        getImages(keyword: "funny")
    }
    
    private func getImages(keyword: String) {
        let url = "https://pixabay.com/api/?key=2963093-768f9ffc11d874c5a568a82ee&q=\(keyword)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            (response) in
            
            switch response.result {
            case .success:
                let json: JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil {
                    imageString = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                }else {
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
    }
    
    @IBAction func nextOdai(_ sender: Any) {
        count = count + 1
        if searchTextField.text == "" {
            getImages(keyword: "funny")
        }else {
            getImages(keyword: searchTextField.text!)
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        self.count = 0
        if searchTextField.text == "" {
            getImages(keyword: "funny")
        }else {
            getImages(keyword: searchTextField.text!)
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
}

