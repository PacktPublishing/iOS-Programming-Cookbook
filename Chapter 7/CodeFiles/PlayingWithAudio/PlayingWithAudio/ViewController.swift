//
//  ViewController.swift
//  PlayingWithAudio
//
//  Created by Hossam Ghareeb on 9/22/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import AVFoundation
import Speech


class ViewController: UIViewController {
    
    var player: AVAudioPlayer?

    @IBOutlet weak var speechTextView: UITextView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    private var speechRecognizer: SFSpeechRecognizer!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    private var recognitionTask: SFSpeechRecognitionTask!
    private let audioEngine = AVAudioEngine()
    private let defaultLocale = Locale(identifier: "en-US")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.recordButton.isEnabled = false
        
        prepareRecognizer(locale: defaultLocale)
    }
    
    private func prepareRecognizer(locale: Locale) {
        speechRecognizer = SFSpeechRecognizer(locale: locale)!
        speechRecognizer.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordButton.isEnabled = true
                    
                case .denied:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }

    @IBAction func didClickOnPlayAudio(_ sender: AnyObject) {
        if player == nil{
            
            let filePath = Bundle.main.path(forResource: "Song", ofType: "mp3")
            let fileURL = URL(fileURLWithPath: filePath!)
            do{
                self.player = try AVAudioPlayer(contentsOf: fileURL)
                self.player?.play()
            }catch{
                print("Error in playing audio file: \(error)")
            }
        }
        else if let player = self.player {
            if player.isPlaying {
                player.pause()
                self.playButton.setTitle("Play Audio", for: .normal)
            }
            else{
                player.play()
                self.playButton.setTitle("Pause", for: .normal)
            }
        }
    }
    
    
    @IBAction func didClickOnRecordButton(_ sender: AnyObject) {
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            self.recordButton.isEnabled = false
            self.recordButton.setTitle("Stopping", for: .disabled)
        } else {
            try! startRecording()
            self.recordButton.setTitle("Stop recording", for: [])
        }
    }
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.speechTextView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                self.recordButton.setTitle("Start Recording", for: [])
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        self.speechTextView.text = "(listening...)"
    }
}

extension ViewController: SFSpeechRecognizerDelegate {
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.recordButton.isEnabled = true
            self.recordButton.setTitle("Start Recording", for: [])
        } else {
            self.recordButton.isEnabled = false
            self.recordButton.setTitle("Recognition is not available", for: .disabled)
        }
    }
}
