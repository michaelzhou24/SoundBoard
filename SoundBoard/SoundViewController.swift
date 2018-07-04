//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Michael Zhou on 2018-07-03.
//  Copyright © 2018 Michael Zhou. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    
    var audioPlayer : AVAudioPlayer?
    var audioRecorder : AVAudioRecorder?
    var audioURL : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    // Creates a new AudioRecorder, settings and URL
    func setupRecorder() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker) // Allows audio to be played through main speaker
            try session.setActive(true)
            
            // Create URL
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print(audioURL!)
            
            // Create settings
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = kAudioFormatMPEG4AAC
            settings[AVSampleRateKey] = 44100
            settings[AVNumberOfChannelsKey] = 2
            
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
            print("Error thrown at AVAudioRecorder!")
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        print("Tapped record!")
        if audioRecorder!.isRecording {
            audioRecorder?.stop()
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
        } else {
            playButton.isEnabled = false
            audioRecorder?.record()
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        print("Tapped play!")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer?.play()
        } catch {
            print("Cannot find audio file!")
        }
    }

    @IBAction func addTapped(_ sender: Any) {
        print("Tapped add!")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sound = Sound(context: context)
        sound.name = nameTextField.text
        sound.audio = NSData(contentsOf: audioURL!)! as Data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
