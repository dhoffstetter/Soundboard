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
  
  var audioRecorder : AVAudioRecorder? = nil
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupRecorder()
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
      
      let audioURL = NSURL.fileURL(withPathComponents: pathComponents)
      
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
  }

  @IBAction func playTapped(_ sender: AnyObject) {
  }

  @IBAction func addTapped(_ sender: AnyObject) {
  }
  
}
