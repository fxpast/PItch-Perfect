//
//  RecordSoundsViewController.swift
//  PItch Perfect
//
//  Created by MacbookPRV on 30/10/2015.
//  Copyright (c) 2015 Pastouret Roger. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController : UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var IBrecording: UILabel!
    @IBOutlet weak var IBrecBut: UIButton!
    @IBOutlet weak var IBstop: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        //hidden stop button
        IBstop.hidden=true
        //enable record button
        IBrecBut.enabled=true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func recordAudio(sender: UIButton)
    {
        //able to be seen recording label
        IBrecording.text="Recording..."
        //hidden stop and record button
        IBstop.hidden=false
        IBrecBut.enabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName="my_audio.caf"
        let pathArray = [dirPath,recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        //setup audio session
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch {
          print("No audio session")
        }
        

        //create AnyObject of settings
        let recordSettings: [String : AnyObject] = [
            AVFormatIDKey:Int(kAudioFormatAppleIMA4),
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,
            AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
        ]

        do {
            
            try audioRecorder = AVAudioRecorder(URL: filePath!, settings: recordSettings)
            
        }
        catch {
             print("No audio recorder")
        }
        
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled=true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            
            IBrecording.text="Tap to record."
            //save the recorded audio
            recordedAudio=RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            //move to the next scene aka perform segue
            self.performSegueWithIdentifier("StopRecording", sender: recordedAudio)
            
        }
        else {
            print("Recording was not successful")
            IBstop.hidden=true
            IBrecBut.enabled=true
            
        }
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier=="StopRecording" {
            let playSoundsVC:PlaySoundsViewController=segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.recordedAudio =  sender as! RecordedAudio
            
            
            
        }
        
        
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        
        audioRecorder.stop()
        
        
    }
    
   
}

