/*:
 ### Overview
 This playground was inspired by two of my hobbies - amateur radio 📡 and programming 👨‍💻. We'll specifically be looking at how you can learn Morse code and how to use the ***Swift*** programming language to control your learning environment. 🤓 I hope that you'll have fun!
 */
/*:
 - Note:
 This playground is targeted at people with a very basic knowledge of the ***Swift*** programming language.
 */
/*:
 ### What is Morse code?
 
  Morse code is a special form of character encoding used in telecommunications. It consists of *dahes* and *dots*, also known as "dahs" and "dits". Every letter of the alphabet (including numbers) can be modulated into a sequence of characters representing a specific letter or number. This sequence of characters can then be combined with others to form words or complete messages.
 
 Here is an overview of what it looks like:
 */
//: ![The Morse alphabet](morse_alphabet.png)
//: Pretty clever, isn't it? 😎
/*:
 ### Let's start coding! 👨‍💻👩‍💻
 
 At first, we need to make our playground visible to the live view so that we can see what is happening. This is done via the following code:
 */
import PlaygroundSupport
let scene = MorseCodeScene()
scene.animatedDishSignal(bool: true)
PlaygroundPage.current.liveView = scene
/*:
 The next step is to listen to some Morse code 😁. In the following ***Swift*** function you can specify a word which you would like to convert into an audible signal. 🔊 Just press the green play button to listen to your signal.
 */
/*:
 - Experiment:
 Play around with the two functions down below.
 1. You can set the ***word*** which you would like to convert into Morse code in the first function (by default it's my amateur radio callsign).
 2. You can adjust the speed at which the Morse code is played in the second function.
 */
scene.generateMorseWord(word: "Arved")
scene.setWPMSpeed(speed: 20)
/*:
 - Note:
 Make sure to only use characters that are part of the Morse alphabet. 😉
 An operating speed of 30 words per minute is usually considered as quite slow, a speed of 80 words per minute on the other hand is very quick!  💨
 */
/*:
 Another important thing to consider whilst listening to Morse code is the actual volume of the audio signal. Too much volume may damage your hearing permanently... 🤕 To overcome this issue, a volume control button with four levels in total is added on the bottom. 😃
 */
scene.addVolumeControls()
/*:
 ### Let's create some Morse code! 📶
 */
/*:
 Now comes the most interesting part - making some Morse code messages yourself! 😄 In order to do that, you can use one of my pre-made templates down below by uncommenting them or you can make your own message/word by using the controls provided on the lower part of the screen. Once you are happy with your entered Morse code, you can then press the green play button to listen what Siri could read from it.
 */
/*:
 - Note:
 A separator ***|*** is needed to separate single words from each other. Single letters can be separated by using the ***gap*** button. 😉
 */
/*:
 - Experiment:
 Try uncommenting my pre-made template down below and listen to Siri's translation 🎧.
 */
//scene.setDefaultMorseCode(morseCode: "••--- • ----- --- -•- ••-• | -•-• •- •-•• •-•• •• -• --• | -•-• --•- | -•-• •- •-•• •• ••-• --- •-• -• •• •-")
/*:
 ### Summary of what you've learned in this playground:
 - You learned about Morse code.
 - You know how Morse code messages are encoded.
 - You know what Morse code sounds like.
 - You have learned about functions and parameters in ***Swift***.
 
 I hope that you had a lot of fun with this playground. Maybe it inspired you to continue learning Morse code. If you are really interested, you could think about getting licensed and operate on air with many other operators around the globe. 🌎  I'm looking forward to seeing you at WWDC 2019 this year! 😄
 
 */
/*:
 And as a little bonus, here is what a ***real*** Morse key looks like:
![A real Morse key](morse_key.jpeg)
 */
