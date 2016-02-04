//
//  PlaySoundsViewController.swift
//  PItch Perfect
//
//  Created by MacbookPRV on 12/11/2015.
//  Copyright © 2015 Pastouret Roger. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    var audio:AVAudioPlayer!
    var recordedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        do {
            try audio = AVAudioPlayer(contentsOfURL: self.recordedAudio.filePathUrl, fileTypeHint: nil)
            audio.enableRate=true
            
        }
        catch {
            print("No audio player")
        }

        
        audioEngine = AVAudioEngine()
        do {
          try audioFile=AVAudioFile(forReading: self.recordedAudio.filePathUrl)
        }
        catch {
            print("No audio file")
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

        
    }
    
    
    func StopAll() {
        audio.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    func PlayAudio(rate:Float) {
        StopAll()
        audio.currentTime=0.0
        audio.rate=rate
        audio.play()
    }
    
    
    func playAudioWithVariablePitch(pitch:Float){
        
        StopAll()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = pitch
        audioEngine.attachNode(pitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        do {
            try audioEngine.start()
        }
        catch {
            print("No audio engine")
        }
        
        audioPlayerNode.play()
        
    }
    
    
    @IBAction func PlaySlow(sender: UIButton) {
        PlayAudio(0.5)
    }
    
    
    @IBAction func PlayFast(sender: UIButton) {
        PlayAudio(2.0)
    }
    
    @IBAction func PlayStop(sender: UIButton) {
        StopAll()
    }
    

    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    

    


}
