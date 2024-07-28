//
//  SoundManager.swift
//  Visuals
//
//  Created by Edwin Nwosu on 24/03/2024.
//

import AudioKit
import AudioKitEX
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI


class EqBand : ObservableObject
{
  let filterBand: EqualizerFilter
  @State var volume: AmplitudeTap
  @Published var amplitude : Float
  
  init(_ input: Node, centerFrequency: AUValue, bandwidth: AUValue, gain: AUValue) {
    filterBand = EqualizerFilter(input,centerFrequency: centerFrequency, bandwidth: bandwidth, gain: gain)
    volume = AmplitudeTap(filterBand)
    amplitude = 5
  }
  
  public func getAmplitude() -> Float
  {
    DispatchQueue.main.async { [self] in
      amplitude = volume.amplitude.magnitude
    }
    return amplitude;
  }

}
class SoundManager : ObservableObject, HasAudioEngine
{
  let engine = AudioEngine()
  var osc = AudioPlayer()
  @State var volume: AmplitudeTap
  @State var volume1: AmplitudeTap
  @State var volume2: AmplitudeTap
  @State var volume3: AmplitudeTap
  @State var volume4: AmplitudeTap
  @State var volume5: AmplitudeTap
  @State var volume6: AmplitudeTap


  @Published var amplitude : Float
  
  var filterBand1: EqualizerFilter
  var filterBand2: EqualizerFilter
  var filterBand3: EqualizerFilter
  var filterBand4: EqualizerFilter
  var filterBand5: EqualizerFilter
  var filterBand6: EqualizerFilter
  
  init()
  {
    engine.output = osc

    osc.volume = 1
    filterBand1 = EqualizerFilter(osc, centerFrequency: 32, bandwidth: 44.7, gain: 1.0)
    filterBand2 = EqualizerFilter(filterBand1, centerFrequency: 64, bandwidth: 70.8, gain: 1.2)
    filterBand3 = EqualizerFilter(filterBand2, centerFrequency: 125, bandwidth: 141, gain: 0.2)
    filterBand4 = EqualizerFilter(filterBand3, centerFrequency: 250, bandwidth: 282, gain: 0.4)
    filterBand5 = EqualizerFilter(filterBand4, centerFrequency: 500, bandwidth: 562, gain: 0.2)
    filterBand6 = EqualizerFilter(filterBand5, centerFrequency: 1_000, bandwidth: 1_112, gain: 0.5)

    amplitude = 5;

    volume = AmplitudeTap(osc)
    volume1 = AmplitudeTap(filterBand1)
    volume2 = AmplitudeTap(filterBand2)
    volume3 = AmplitudeTap(filterBand3)
    volume4 = AmplitudeTap(filterBand4)
    volume5 = AmplitudeTap(filterBand5)
    volume6 = AmplitudeTap(filterBand6)
    


    
    guard let url = Bundle.main.resourceURL?.appendingPathComponent(
        "glitch.wav")
    else {
        Log("failed to load sample")
        return
    }
    try? osc.load(url: url)

  }
  
  public func getAmplitude(target: Int) -> Float
  {
    DispatchQueue.main.async { [self] in
      
      switch target
      {
      case 1:
        amplitude = volume1.amplitude.magnitude
        
      case 2:
        amplitude = volume2.amplitude.magnitude
        
      case 3:
        amplitude = volume3.amplitude.magnitude
        
      case 4:
        amplitude = volume4.amplitude.magnitude
        
      case 5:
        amplitude = volume5.amplitude.magnitude
        
      case 6:
        amplitude = volume6.amplitude.magnitude
      default:
        amplitude = volume.amplitude.magnitude
      }
    }
    return amplitude
  }
  
  public func start()
  {
    do
    {
      try engine.start()
    }catch{}
    osc.play()
    filterBand1.start()
    filterBand2.start()
    filterBand3.start()
    filterBand4.start()
    filterBand5.start()
    filterBand6.start()

  }
  
}
