// import frameworks
import UIKit
import Foundation
import AVFoundation

// initialize class and open it to the playground live view

open class MorseCodeScene : UIViewController, AVAudioPlayerDelegate, UITextFieldDelegate {

    // initialize variables
    
    //  name morse field vars //
    
    var nameMorseField : UITextField!
    var morseTextHeading : UILabel!
    var playButtonNameMorse : UIButton!
    var nameMorseInfoText : UILabel!
    var nameMorseLabel : UILabel!
    let greenTitleColor = UIColor(red:0.14, green:0.73, blue:0.53, alpha:1.0)
    let greenLightShade = UIColor(red:0.53, green:0.91, blue:0.77, alpha:1.0)
    let lightGreyShade = UIColor.white
    let lightGreyLight = UIColor.lightGray
    let redGlowColor = UIColor(red:0.71, green:0.20, blue:0.34, alpha:1.0)
    let redGlowColorLight = UIColor(red:0.88, green:0.57, blue:0.66, alpha:1.0)
    
    // morse to speech field vars //
    
    var morseToSpeechDescription : UILabel!
    var morseToSpeechTextField : PaddedLabel!
    var dashButton : UIButton!
    var dotButton : UIButton!
    var gapButton : UIButton!
    var seperatorButton : UIButton!
    var morseToSpeechPlay : UIButton!
    var undoSpeechBtn : UIButton!
    var speakerButton : UIButton!
    var dishIcon : UIImageView!
    var morseKey : UIImageView!
    let morseKeyOnImage = UIImage(named: "morse_key_on.png")
    let morseKeyOffImage = UIImage(named: "morse_key_off.png")
    
    // AVAudio Player variables //
    
    var audioPlayer = AVAudioPlayer()
    var speechSynthesizer = AVSpeechSynthesizer()
    
    // place holder variables for strings and numbers //
    
    var nameInMorse : String!
    var liveUpdateNameMorse = " "
    var volumeLevel = 2.0
    
    
    open override func viewDidLoad() {
        
        // set background image //
        self.view.layer.contents = UIImage(named: "background1.png")?.cgImage
        
        
        ////    Text to Morse section      ////
        
        
        // Init Heading //
        morseTextHeading = UILabel(frame: CGRect(x: 10, y: 20, width: 350, height: 25))
        morseTextHeading.textAlignment = .center
        morseTextHeading.text = "2EØOKF Morse Trainer"
        morseTextHeading.textColor = UIColor.white
        morseTextHeading.font = UIFont.systemFont(ofSize: 24)
        self.view.addSubview(morseTextHeading)
        
        // Init name morse generator description //
        nameMorseInfoText = UILabel(frame: CGRect(x: 10, y: 60, width: 350, height: 60))
        nameMorseInfoText.textColor = UIColor.white
        nameMorseInfoText.text = "Here is your chosen word that is going to be converted into morse code:"
        nameMorseInfoText.textAlignment = .center
        nameMorseInfoText.textColor = UIColor.lightGray
        nameMorseInfoText.numberOfLines = 0
        self.view.addSubview(nameMorseInfoText)
        
        //  name morse label before conversion init  //
        nameMorseLabel = UILabel(frame: CGRect(x: 10, y: 120, width: 350, height: 40))
        nameMorseLabel.textColor = UIColor.white
        nameMorseLabel.text = ""
        nameMorseLabel.textAlignment = .center
        self.view.addSubview(nameMorseLabel)
        
        //  Init morse code display //
        nameMorseField = UITextField(frame: CGRect(x: 10, y: 160, width: 350, height: 30))
        nameMorseField.textColor = UIColor.white
        nameMorseField.layer.cornerRadius = 4.0
        nameMorseField.layer.borderWidth = 1.0
        nameMorseField.text = " "
        nameMorseField.layer.borderColor = UIColor.lightGray.cgColor
        nameMorseField.isUserInteractionEnabled = false
        nameMorseField.delegate = self
        self.view.addSubview(nameMorseField)
        
        // init play button for morse code  //
        playButtonNameMorse = UIButton(frame: CGRect(x: 155, y: 200, width: 60, height: 30))
        playButtonNameMorse.setTitle("Play", for: .normal)
        playButtonNameMorse.titleLabel?.textAlignment = .center
        playButtonNameMorse.setTitleColor(greenTitleColor, for: .normal)
        playButtonNameMorse.setTitleColor(greenLightShade, for: .selected)
        playButtonNameMorse.setTitleColor(greenLightShade, for: .highlighted)
        playButtonNameMorse.layer.borderWidth = 1.0
        playButtonNameMorse.layer.cornerRadius = 4.0
        playButtonNameMorse.layer.borderColor = greenTitleColor.cgColor
        playButtonNameMorse.layer.masksToBounds = false
        // call function to play audio  //
        playButtonNameMorse.addTarget(self, action: #selector(playNameMorseCode), for: .touchUpInside)
        self.view.addSubview(playButtonNameMorse)
        
        
        /////      Morse to Speech Section         //////
        
        //  init description label  //
        morseToSpeechDescription = UILabel(frame: CGRect(x: 10, y: 320, width: 350, height: 20))
        morseToSpeechDescription.textColor = UIColor.white
        morseToSpeechDescription.textAlignment = .center
        morseToSpeechDescription.text = "Your entered morse code:"
        self.view.addSubview(morseToSpeechDescription)
        
        //  init text entering field    //
        morseToSpeechTextField = PaddedLabel(frame: CGRect(x: 10, y: 350, width: 350, height: 100))
        morseToSpeechTextField.numberOfLines = 0
        morseToSpeechTextField.leftInset = 5.0
        morseToSpeechTextField.rightInset = 5.0
        morseToSpeechTextField.textColor = UIColor.white
        morseToSpeechTextField.layer.cornerRadius = 4.0
        morseToSpeechTextField.layer.borderWidth = 1.0
        morseToSpeechTextField.layer.borderColor = UIColor.lightGray.cgColor
        morseToSpeechTextField.layer.masksToBounds = false
        morseToSpeechTextField.text = ""
        self.view.addSubview(morseToSpeechTextField)
        
        //  init dash button   //
        dashButton = UIButton(frame: CGRect(x: 10, y: 465, width: 50, height: 30))
        dashButton.setTitleColor(lightGreyShade, for: .normal)
        dashButton.setTitleColor(lightGreyLight, for: .selected)
        dashButton.setTitleColor(lightGreyLight, for: .highlighted)
        dashButton.setTitle("-", for: .normal)
        dashButton.layer.cornerRadius = 4.0
        dashButton.layer.borderWidth = 1.0
        dashButton.layer.borderColor = lightGreyShade.cgColor
        dashButton.layer.masksToBounds = false
        // call addDash function //
        dashButton.addTarget(self, action: #selector(addDash), for: .touchUpInside)
        self.view.addSubview(dashButton)
        
        //  init dot button //
        dotButton = UIButton(frame: CGRect(x: 65, y: 465, width: 50, height: 30))
        dotButton.setTitle("•", for: .normal)
        dotButton.setTitleColor(lightGreyShade, for: .normal)
        dotButton.setTitleColor(lightGreyLight, for: .selected)
        dotButton.setTitleColor(lightGreyLight, for: .highlighted)
        dotButton.layer.cornerRadius = 4.0
        dotButton.layer.borderWidth = 1.0
        dotButton.layer.borderColor = lightGreyShade.cgColor
        dotButton.layer.masksToBounds = false
        // call addDpot function //
        dotButton.addTarget(self, action: #selector(addDot), for: .touchUpInside)
        self.view.addSubview(dotButton)
        
        //  init gap button //
        gapButton = UIButton(frame: CGRect(x: 120, y: 465, width: 50, height: 30))
        gapButton.setTitle("Gap", for: .normal)
        gapButton.setTitleColor(lightGreyShade, for: .normal)
        gapButton.setTitleColor(lightGreyLight, for: .selected)
        gapButton.setTitleColor(lightGreyLight, for: .highlighted)
        gapButton.layer.cornerRadius = 4.0
        gapButton.layer.borderWidth = 1.0
        gapButton.layer.borderColor = lightGreyShade.cgColor
        gapButton.layer.masksToBounds = false
        //  call gap function   //
        gapButton.addTarget(self, action: #selector(addGap), for: .touchUpInside)
        self.view.addSubview(gapButton)
        
        //  init separator button   //
        seperatorButton = UIButton(frame: CGRect(x: 175, y: 465, width: 50, height: 30))
        seperatorButton.setTitle("|", for: .normal)
        seperatorButton.setTitleColor(lightGreyShade, for: .normal)
        seperatorButton.setTitleColor(lightGreyLight, for: .selected)
        seperatorButton.setTitleColor(lightGreyLight, for: .highlighted)
        seperatorButton.layer.cornerRadius = 4.0
        seperatorButton.layer.borderWidth = 1.0
        seperatorButton.layer.borderColor = lightGreyShade.cgColor
        seperatorButton.layer.masksToBounds = false
        // call separator function //
        seperatorButton.addTarget(self, action: #selector(addSeperator), for: .touchUpInside)
        self.view.addSubview(seperatorButton)
        
        //  init undo button    //
        undoSpeechBtn = UIButton(frame: CGRect(x: 230, y: 465, width: 50, height: 30))
        undoSpeechBtn.setTitle("⟵", for: .normal)
        undoSpeechBtn.setTitleColor(redGlowColor, for: .normal)
        undoSpeechBtn.setTitleColor(redGlowColorLight, for: .selected)
        undoSpeechBtn.setTitleColor(redGlowColorLight, for: .highlighted)
        undoSpeechBtn.layer.cornerRadius = 4.0
        undoSpeechBtn.layer.borderWidth = 1.0
        undoSpeechBtn.layer.borderColor = redGlowColor.cgColor
        undoSpeechBtn.layer.masksToBounds = false
        // call removeLastChar function //
        undoSpeechBtn.addTarget(self, action: #selector(removeLastChar), for: .touchUpInside)
        self.view.addSubview(undoSpeechBtn)
        
        //  init morse to speech button //
        morseToSpeechPlay = UIButton(frame: CGRect(x: 310, y: 465, width: 50, height: 30))
        morseToSpeechPlay.setTitle("Play", for: .normal)
        morseToSpeechPlay.setTitleColor(greenTitleColor, for: .normal)
        morseToSpeechPlay.setTitleColor(greenLightShade, for: .selected)
        morseToSpeechPlay.setTitleColor(greenLightShade, for: .highlighted)
        morseToSpeechPlay.layer.cornerRadius = 4.0
        morseToSpeechPlay.layer.borderWidth = 1.0
        morseToSpeechPlay.layer.borderColor = greenTitleColor.cgColor
        morseToSpeechPlay.layer.masksToBounds = false
        // call play function //
        morseToSpeechPlay.addTarget(self, action: #selector(playMorseInSpeechBtn), for: .touchUpInside)
        self.view.addSubview(morseToSpeechPlay)
        
        //  add speaker button  //
        speakerButton = UIButton(frame: CGRect(x: 10, y: 595, width: 60, height: 60))
        speakerButton.setBackgroundImage(UIImage(named: "speaker2.png"), for: .normal)
        speakerButton.layer.masksToBounds = false
        
        //  add animated dish icon  //
        dishIcon = UIImageView(frame: CGRect(x: 250, y: 550, width: 120, height: 120))
        let dishIconImage = UIImage(named: "dish3.png")
        dishIcon.image = dishIconImage
        dishIcon.layer.masksToBounds = false
        self.view.addSubview(dishIcon)
        
        // add animated morse key
        morseKey = UIImageView(frame: CGRect(x: 290, y: 245, width: 50, height: 30))
        morseKey.image = UIImage(named: "morse_key_off.png")
        self.view.addSubview(morseKey)
        
    }
    
    ////      Character to Morse Section      ////
    
    
    // function to convert characters into Morse code //
    func generateNameInMorse(name : String) -> String {
        
        // get string
        nameMorseLabel.text = name
        
        // placeholder variable
        var finalMorseString = ""
        
        // convert string into character array
        let nameArray = Array(name)
        
        for character in nameArray {
            
            // init morse struct
            let morseArrays = morseCharacters()
            
            // convert character into string and uppercase it
            let charString = String(character).uppercased()
            
            // get index of charcter in morse alphabet
            let charIndex = morseArrays.alphabetArray.firstIndex(of: charString)
            
            // append character of the normal alphabet onto the placeholder variable
            finalMorseString +=  " " + morseArrays.morseArray[charIndex!]
            
        }
        
        // return fnal converted string
        return finalMorseString
    }
    
    // struct to store morse and alphabet charcters
    public struct morseCharacters {
        
        // -•
        
        // morse code array
        public let morseArray = ["•-", "-•••", "-•-•", "-••", "•", "••-•", "--•", "••••", "••", "•---", "-•-", "•-••", "--", "-•", "---", "•--•", "--•-", "•-•", "•••", "-", "••-", "•••-", "•--", "-••-", "-•--", "--••", "-----", "•----", "••---", "•••--", "••••-", "•••••", "-••••", "--•••", "---••", "----•", " ", "|", ""]
        
        // alphabet array
        public let alphabetArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "|", ""]
        
    }
    
    // open function to convert letters & numbers into morse code
    open func generateMorseWord(word: String) {
        let nameString = generateNameInMorse(name: word)
        nameInMorse = nameString
    }
    
    // init placeholder varaibles for AVAudioPlayer
    var maxCharsInName : Int!
    var currentArrayIndex = 0
    var speedfactor = 4.0
    
    @objc func playNameMorseCode() {
        
        nameMorseField.text = " "
        
        // start at 0 in array
        currentArrayIndex = 0
        
        // split string back into array
        let nameCharacterArray = Array(nameInMorse)
        
        // get the last index and assign it to be the last value to loop through
        maxCharsInName = nameCharacterArray.endIndex
        
        // play file at current loop index
        playSoundAtIndex(index: currentArrayIndex)
        
    }
    
    // function to play sound at specific array index
    func playSoundAtIndex(index: Int) {
        
        // make sure we are still within bounds of the array
        if !(currentArrayIndex >= maxCharsInName) {
            
            let nameCharacterArray = Array(nameInMorse)
            
            // append current character to the morse field
            nameMorseField.text?.append(nameCharacterArray[currentArrayIndex])
            
            
            
            // load long and short audio files
            let pathLong = Bundle.main.path(forResource: "long.mp3", ofType:nil)!
            let urlLong = URL(fileURLWithPath: pathLong)
            
            let pathShort = Bundle.main.path(forResource: "short.mp3", ofType:nil)!
            let urlShort = URL(fileURLWithPath: pathShort)
            
            // check if it's a dash
            if (nameCharacterArray[index] == "-") {
                updateKeyImage(string: "on")
                do {
                    // try to load the file into the audio player
                    audioPlayer = try AVAudioPlayer(contentsOf: urlLong)
                    // make sure it runs once
                    audioPlayer.numberOfLoops = 0
                    // set volume and speed
                    audioPlayer.enableRate = true
                    audioPlayer.volume = Float(volumeLevel)
                    audioPlayer.rate = Float(speedfactor)
                    // assign delegate
                    audioPlayer.delegate = self
                    // play the audio
                    audioPlayer.play()
                } catch {
                    // if something goes wrong print error
                    print("error playing file")
                }
            } else if (nameCharacterArray[index] == "•") {
                // update image
                updateKeyImage(string: "on")
                do {
                    // try to load the file into the audio player
                    audioPlayer = try AVAudioPlayer(contentsOf: urlShort)
                    // make sure it runs once
                    audioPlayer.numberOfLoops = 0
                    // assign delegate
                    audioPlayer.delegate = self
                    // set volume and speed
                    audioPlayer.enableRate = true
                    audioPlayer.volume = Float(volumeLevel)
                    audioPlayer.rate = Float(speedfactor)
                    // play the audio
                    audioPlayer.play()
                } catch {
                    // if something goes wrong print error
                    print("error playing file")
                }
            } else {
                // play next character
                playNext()
            }
        }
    }
    
    // use of delegate to allow the UI to update
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateKeyImage(string: "off")
        // if we are out of bounds end
        if (currentArrayIndex >= maxCharsInName) {
            print("end")
        } else {
            playNext()
        }
    }
    
    // play next character in function
    public func playNext() {
        // adjust gap between characters according to the wpm value
        let sleepRate = speedfactor/500
        DispatchQueue.main.asyncAfter(deadline: .now() + sleepRate) {
            // count up the array index
            self.currentArrayIndex += 1
            self.playSoundAtIndex(index: self.currentArrayIndex)
        }
        
    }
    
    // function to update image according to parameter
    func updateKeyImage(string: String) {
        if (string == "on") {
            // run on main thread
            DispatchQueue.main.async {
                self.morseKey.image = self.morseKeyOnImage
                self.morseKey.setNeedsDisplay()
            }
        } else if (string == "off") {
            // run on main thread
            DispatchQueue.main.async {
                self.morseKey.image = self.morseKeyOffImage
                self.morseKey.setNeedsDisplay()
            }
        }
    }
    
    ////        Morse to Character Section      ////
    
    // append dash
    @objc func addDash() {
        morseToSpeechTextField.text?.append("-")
        doLongKeyInterface()
    }
    
    // append dot
    @objc func addDot() {
        morseToSpeechTextField.text?.append("•")
        doShortKeyInterface()
    }
    
    // append gap
    @objc func addGap() {
        morseToSpeechTextField.text?.append(" ")
    }
    
    // append seperator
    @objc func addSeperator() {
        morseToSpeechTextField.text?.append("|")
    }
    
    // remove the last entered character
    @objc func removeLastChar() {
        if !(morseToSpeechTextField.text?.count == 0) {
            morseToSpeechTextField.text?.removeLast()
        }
    }
    
    // function to play morse code in regular words
    @objc func playMorseInSpeechBtn() {
        
        // get text from text field
        let stringToConvert = morseToSpeechTextField.text
        
        // get converted string
        let convertedString = convertMorseToLetters(string: stringToConvert!)
        
        // assign the converted text to a speech utterance
        let textToSay = AVSpeechUtterance(string: convertedString)
        
        // assign speed and volume of the utterance speaker
        textToSay.rate = 0.4
        textToSay.volume = Float(volumeLevel)
        
        // speak text
        speechSynthesizer.speak(textToSay)
        
    }
    
    // alghorythm to convert morse code into a readable string
    func convertMorseToLetters(string: String) -> String {
        
        // init morse struct
        let morseDat  = morseCharacters()
        
        // get character array of string
        let stringArrayOrig = Array(string + " ")
        
        // make new temp string array
        var newStringArray: [String] = []
        
        // make temp string
        var tmpString = ""
        
        // loop through every character
        for stringChar in stringArrayOrig {
            
            // check if it's a dash, a dot or something else
            // append to the character array accordingly
            if (stringChar == "-" || stringChar == "•") {
                tmpString.append(stringChar)
            } else if (stringChar == "|") {
                newStringArray.append(tmpString)
                newStringArray.append("|")
                // empty tmp string
                tmpString = ""
            } else {
                newStringArray.append(tmpString)
                newStringArray.append(" ")
                // empty tmp string
                tmpString = ""
            }
            
        }
        
        // yet another string array
        var stringAlphabetArray : [String] = []
        
        // loop through every string character
        for stringValue in newStringArray {
            
            // make sure our charcter is part of the morse alphabet
            if (morseDat.morseArray.contains(stringValue)) {
                // get index of alphabet character
                let indexVal = morseDat.morseArray.firstIndex(of: stringValue)
                stringAlphabetArray.append(morseDat.alphabetArray[indexVal!])
            } else {
                // replace any unknown charcters with ""
                morseToSpeechTextField.text? = (morseToSpeechTextField.text?.replacingOccurrences(of: stringValue, with: ""))!
            }
        }
        
        // join string array into one string
        let stringResultOne = stringAlphabetArray.joined()
        // remove all spaces
        let stringResultTwo = stringResultOne.replacingOccurrences(of: " ", with: "")
        // replace seperators with spaces
        let stringResultFinal = stringResultTwo.replacingOccurrences(of: "|", with: " ")
        
        // return final converted string
        return stringResultFinal
    }
    
    // function to enable or disable the dish animation
    open func animatedDishSignal(bool: Bool) {
        
        if (bool) {
            // timer to repeat function forever
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(animateDish), userInfo: nil, repeats: true)
        }
    }
    
    // placeholder variables for the dish animation
    var imageCounter = 0
    let imageNameArray = ["dish0.png", "dish1.png", "dish2.png", "dish3.png"]
    
    // actually animate the dish signal
    @objc func animateDish() {
        
        // if the image counter has gone up to three reset it
        if (imageCounter == 3) {
            dishIcon.image = UIImage(named: imageNameArray[imageCounter])
            imageCounter = 0
        } else { // count up
            dishIcon.image = UIImage(named: imageNameArray[imageCounter])
            imageCounter += 1
        }
        
    }
    
    // function to add the volume control button to the UI
    open func addVolumeControls() {
        self.view.addSubview(speakerButton)
        // function to call if the button is pressed
        speakerButton.addTarget(self, action: #selector(updateVolume), for: .touchUpInside)
    }
    
    // function to actually update the volume
    @objc func updateVolume(){
    
        // adjust image and volume according to the currently set volume using a switch statement
        
        switch volumeLevel {
        case 1.0:
            volumeLevel += 1.0
            speakerButton.setBackgroundImage(UIImage(named: "speaker\(Int(volumeLevel)).png"), for: .normal)
            break
        case 2.0:
            volumeLevel += 1.0
            speakerButton.setBackgroundImage(UIImage(named: "speaker\(Int(volumeLevel)).png"), for: .normal)
            break
        case 3.0:
            volumeLevel += 1.0
            speakerButton.setBackgroundImage(UIImage(named: "speaker\(Int(volumeLevel)).png"), for: .normal)
            break
        case 4.0:
            // reset image and volume
            volumeLevel = 1.0
            speakerButton.setBackgroundImage(UIImage(named: "speaker\(Int(volumeLevel)).png"), for: .normal)
            break
        default:
            volumeLevel = 1.0
            speakerButton.setBackgroundImage(UIImage(named: "speaker\(Int(volumeLevel)).png"), for: .normal)
        }
        
    }
    
    // function set a default morse code message into the assigned text field
    open func setDefaultMorseCode(morseCode: String) {
        morseToSpeechTextField.text = morseCode
    }
    
    // function to adjust the wpm speed of the morse code
    open func setWPMSpeed(speed: Int) {
        speedfactor = Double(speed/5)
        
    }
    
    // function to send a short key from the interface to the keyer animation
    func doShortKeyInterface() {
        morseKey.image = morseKeyOnImage
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.morseKey.image = self.morseKeyOffImage
        }
    }
    
    // function to send a long key from the interface to the keyer animation
    func doLongKeyInterface() {
        morseKey.image = morseKeyOnImage
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.morseKey.image = self.morseKeyOffImage
        }
    }
    
}

// extended UILabel class
// The purpose of this class is to add some margin all around the inner rect of the label to prevent the text from being clipped by the border.
class PaddedLabel : UILabel {
    var leftInset : CGFloat = 0
    var rightInset : CGFloat = 0
    var topInset : CGFloat = 0
    var bottomInset : CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        let totalInsets : UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        self.setNeedsLayout()
        return super.drawText(in: rect.inset(by: totalInsets))
    }
    
}
