//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Benjamin Johnston on 3/13/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayerNode = AVAudioPlayerNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize AVAudioPlayer object with data from segue
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playAudioWithVariableSpeed(speed: Float) {
        // method to play audio at variable speed
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = speed
        audioPlayer.play()
        
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAudioWithVariableSpeed(2)
    }

    @IBAction func playSlow(sender: UIButton) {
        playAudioWithVariableSpeed(0.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playEchoEffect(sender: UIButton) {
        playAudioWithEcho(50)
    }
    
    @IBAction func stopAll(sender: UIButton) {
        resetAudioSessions()
    }
    
    func resetAudioSessions(){
        //stop all playback and reset audioEngine
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func attachAudioPlayerNode(){
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
    }
    
    
    func playAudioWithEcho(feedback: Float){
        resetAudioSessions()
        attachAudioPlayerNode()
        
        var changeEchoEffect = AVAudioUnitDelay()
        changeEchoEffect.feedback = feedback
        audioEngine.attachNode(changeEchoEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeEchoEffect, format: nil)
        audioEngine.connect(changeEchoEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        resetAudioSessions()
        attachAudioPlayerNode()
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
}
