//
//  ContentView.swift
//  Visuals
//
//  Created by Edwin Nwosu on 24/03/2024.
//

import SwiftUI
import AudioKitUI


struct ContentView: View
{
    @StateObject var sound = SoundManager();
  let range = -2 * CGFloat.pi ... 0
  let centre_x = UIScreen.main.bounds.width / 2
  let centre_y = 0

    let r: CGFloat = 100
    var body: some View {
      VStack
      {
        
        Text("val: " + String(sound.volume.amplitude))

        //SpectrogramView(node: sound.osc, linearGradient: LinearGradient(
          //gradient: .init(colors: [.white, .red, .black, .blue]),startPoint: .bottom,endPoint: .top), backgroundColor: Color.white)
        
        ForEach(0..<40)
        {i in
          var angle =  5 * CGFloat.pi/40 * CGFloat(sound.getAmplitude(target: 22))
          let offset = CGPoint(x: centre_x + (r * cos(angle * CGFloat(i))), y: CGFloat(centre_y) + (r * sin(angle * CGFloat(i))))
          
          HStack
          {
            Circle().fill(Color(red: Double(sound.getAmplitude(target: 22)), green: 0.8 - Double(sound.getAmplitude(target: 22)), blue: 1 - Double(sound.getAmplitude(target: 22)), opacity: 1)).frame(width: 30 * CGFloat(sound.getAmplitude(target: 22) * 3), height: 30 * CGFloat(sound.getAmplitude(target: 22) * 4)).onTapGesture
            {
            
            }.position(offset)
            
          }
        }
      }
        .padding().onAppear(){
          sound.start();
          sound.volume.start()
        }
    }
}

#Preview {
    ContentView()
}
