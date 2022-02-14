//
//  MenuViewController.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 08/12/2021.
//

import UIKit
import AVFoundation
class MenuViewController: UIViewController {
    var player : AVPlayer? // chơi nhạc online
    var Link : String = ""
    @IBOutlet weak var ViewOptionSpeesMp3: UIButton!
    var IntLink : String = ""
    @IBOutlet weak var ViewSpeedMp3: UIView!
    @IBOutlet weak var TimeBook: UILabel!
    fileprivate let seekDuration: Float64 = 10
    var SpeedMp3 : Float = 1.0
    @IBOutlet weak var playbackSlider: UISlider!
    var playerItem:AVPlayerItem?
    var text1 : String = ""
    var isRepeat : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        TimeBook.textColor = .white
        ViewSpeedMp3.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func Back0(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        player?.pause()
    }
    
    @IBAction func Speed075X(_ sender: Any) {
        SpeedMp3 = 0.75
        ViewOptionSpeesMp3.setTitle("0.75X", for: .normal)
        ViewSpeedMp3.isHidden = true
        initAudioPlayer()
    }
    @IBAction func Speed1X(_ sender: Any) {
        SpeedMp3 = 1.0
        ViewOptionSpeesMp3.setTitle("1X", for: .normal)
        ViewSpeedMp3.isHidden = true
        initAudioPlayer()
    }
    @IBAction func Speed125X(_ sender: Any) {
        SpeedMp3 = 1.25
        ViewOptionSpeesMp3.setTitle("1.25X", for: .normal)
        ViewSpeedMp3.isHidden = true
        initAudioPlayer()
    }
    @IBAction func Speed15X(_ sender: Any) {
        ViewOptionSpeesMp3.setTitle("1.5X", for: .normal)
        SpeedMp3 = 1.5
        ViewSpeedMp3.isHidden = true
        initAudioPlayer()
    }
    @IBAction func Speed20X(_ sender: Any) {
        ViewOptionSpeesMp3.setTitle("2.0X", for: .normal)
        SpeedMp3 = 2.0
        ViewSpeedMp3.isHidden = true
        initAudioPlayer()
    }
    @IBAction func Back1(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        player?.pause()
    }
    @IBAction func OptionSpeesMp3(_ sender: Any) {
        ViewSpeedMp3.isHidden = false
    }
    @IBAction func PlayMp3(_ sender: Any) {
        initAudioPlayer()
    }
    @IBAction func Pause(_ sender: Any) {
        player?.pause()
    }
    @IBAction func Downloadmp3(_ sender: Any) {
        Downloadmp3()
        showAlert()
    }
    @IBAction func BtnRepeat(_ sender: Any) {
        if isRepeat == true{
            StatusRepeat()
            text1 = "Repeat On"
            showAlert()
            isRepeat = false
        }else{
            StatusRepeat()
            text1 = "Repeat Off"
            showAlert()
            isRepeat = true
        }
    }
    func StatusRepeat(){
        if isRepeat == true {
        }else{
            player?.play()
        }
    }
    func showAlert() {
        let alert = UIAlertController(title: "", message: text1, preferredStyle: .actionSheet)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.height, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func initAudioPlayer(){
        let url = URL(string: "http://android.jaqer.com/bible/nkjvtts/"+Link+"_"+IntLink+".mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        playbackSlider.minimumValue = 0
        player?.play()
        player?.rate = SpeedMp3
        //To get overAll duration of the audio
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        
        //To get the current duration of the audio
        let currentDuration : CMTime = playerItem.currentTime()
        let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.playbackSlider.value = Float ( time );
                self.TimeBook.text = self.stringFromTimeInterval(interval: time) + "/" + self.stringFromTimeInterval(interval: seconds)
            }
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                //                self.play.isHidden = true
                //                        self.loadingView.isHidden = false
            } else {
                //stop the activity indicator
                print("Buffering completed")
                //                self.ButtonPlay.isHidden = false
                //        self.loadingView.isHidden = true
            }
        }
        
        
        //change the progress value
        playbackSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        
        //check player has completed playing audio
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player?.play()
        }
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        //        play.setImage(UIImage(named: "play_circle_outline.png"), for: .normal)
        //reset player when finish
        playbackSlider.value = 0
        let targetTime:CMTime = CMTimeMake(value: 0, timescale: 1)
        player!.seek(to: targetTime)
        StatusRepeat()
        
    }
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        
        return String(format: "%02d:%02d",minutes, seconds)
    }
    func Downloadmp3() {
        if let audioUrl = URL(string: "http://android.jaqer.com/bible/nkjvtts/"+Link+"_"+IntLink+".mp3") {
            
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                
                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl) { location, response, error in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                    } catch {
                        print(error)
                    }
                }.resume()
            }
        }
    }
}
