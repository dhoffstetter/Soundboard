//
//  SoundViewController.swift
//  Soundboard
//
//  Created by Diane Hoffstetter on 9/11/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var addButton: UIButton!
  
  var audioRecorder : AVAudioRecorder? = nil
  var audioPlayer : AVAudioPlayer? = nil
  var audioURL : URL?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupRecorder()
      playButton.isEnabled = false
      addButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func setupRecorder() {
    do {
      
      // Create an Audio session
    
      let session = AVAudioSession.sharedInstance()
      try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
      try session.overrideOutputAudioPort(.speaker)
      try session.setActive(true)
      
      // Create URL for audio file
      
      let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
      let pathComponents = [basePath, "audio.m4a"]
      
      audioURL = NSURL.fileURL(withPathComponents: pathComponents)
      print("##################")
      print(audioURL)
      print("##################")
     
      // Create settings for the audio recorder
      
      var settings : [String:AnyObject] = [:]
      settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
      settings[AVSampleRateKey] = 44100.0
      settings[AVNumberOfChannelsKey] = 2
      
      
      // Create AudioRecorder object
      
      audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
      audioRecorder!.prepareToRecord()
      
    } catch let error as NSError {
      
      print(error)
    }
  }
    
  @IBAction func recordTapped(_ sender: AnyObject) {
    
    if audioRecorder!.isRecording {
      
      // Stop recording
      
      audioRecorder?.stop()
      
      // Change button to Record
      
      recordButton.setTitle("Record", for: .normal)
      
      playButton.isEnabled = true
      addButton.isEnabled = true
      
    } else {
      
      // Start recording
      
      audioRecorder?.record()
      
      // Change button to Stop
      
      recordButton.setTitle("Stop", for: .normal)
    }
  }

  @IBAction func playTapped(_ sender: AnyObject) {
    
    do {
      try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
      audioPlayer?.play()
    } catch {}
  }

  @IBAction func addTapped(_ sender: AnyObject) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let sound = Sound(context: context)
    
    sound.name = textField.text
    sound.audio = NSData(contentsOf: audioURL!)
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    navigationController!.popViewController(animated: true)

  }
  
  
  
  
  
}
