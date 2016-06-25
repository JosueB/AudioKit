import XCPlayground
import AudioKit

//let osc = InstrumentDemo()
let osc = AKPWMOscillatorBank()

AudioKit.output = osc
AudioKit.start()

class PlaygroundView: AKPlaygroundView, KeyboardDelegate {
    
    var pulseWidthLabel: Label?
    var attackLabel: Label?
    var releaseLabel: Label?
    var detuningOffsetLabel: Label?
    var detuningMultiplierLabel: Label?
    
    override func setup() {
        addTitle("PWM Oscillator Bank")
        pulseWidthLabel = addLabel("Pulse Width: \(osc.pulseWidth)")
        addSlider(#selector(setPulseWidth), value: osc.pulseWidth, minimum: 0.0, maximum: 0.9999)
        
        attackLabel = addLabel("Attack: \(osc.attackDuration)")
        addSlider(#selector(setAttack), value: osc.attackDuration, minimum: 0.0, maximum: 2.0)
        
        releaseLabel = addLabel("Release: \(osc.releaseDuration)")
        addSlider(#selector(setRelease), value: osc.releaseDuration, minimum: 0.0, maximum: 2.0)
        
        detuningOffsetLabel = addLabel("Detuning Offset: \(osc.detuningOffset)")
        addSlider(#selector(setDetuningOffset), value: osc.detuningOffset, minimum: -1000, maximum: 1000)
        detuningMultiplierLabel = addLabel("Detuning Multiplier: \(osc.detuningMultiplier)")
        addSlider(#selector(setDetuningMultiplier), value: osc.detuningMultiplier, minimum: 0.9, maximum: 1.1)
        
        let keyboard = PolyphonicKeyboardView(width: 500, height: 100)
        keyboard.frame.origin.y = CGFloat(yPosition)
        keyboard.setNeedsDisplay()
        keyboard.delegate = self
        self.addSubview(keyboard)
    }
    
    func noteOn(note: Int) {
        osc.start(note: note, withVelocity: 80, onChannel: 0)
    }
    
    func noteOff(note: Int) {
        osc.stop(note: note, onChannel: 0)
    }
    
    func setPulseWidth(slider: Slider) {
        osc.pulseWidth = Double(slider.value)
        pulseWidthLabel!.text = "Pulse Width: \(String(format: "%0.3f", osc.pulseWidth))"
    }
    
    func setAttack(slider: Slider) {
        osc.attackDuration = Double(slider.value)
        attackLabel!.text = "Attack: \(String(format: "%0.3f", osc.attackDuration))"
    }
    
    func setRelease(slider: Slider) {
        osc.releaseDuration = Double(slider.value)
        releaseLabel!.text = "Release: \(String(format: "%0.3f", osc.releaseDuration))"
    }
    
    func setDetuningOffset(slider: Slider) {
        osc.detuningOffset = Double(slider.value)
        detuningOffsetLabel!.text = "Detuning Offset: \(String(format: "%0.3f", osc.detuningOffset))"
    }
    
    func setDetuningMultiplier(slider: Slider) {
        osc.detuningMultiplier = Double(slider.value)
        detuningMultiplierLabel!.text = "Detuning Multiplier: \(String(format: "%0.3f", osc.detuningMultiplier))"
    }
    
}


let view = PlaygroundView(frame: CGRect(x: 0, y: 0, width: 500, height: 550))
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = view

