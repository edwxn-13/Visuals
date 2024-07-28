//
//  VisualNode.swift
//  Visuals
//
//  Created by Edwin Nwosu on 24/03/2024.
//

import Foundation
import SwiftUI

struct VisualNode : View
{
  
  @State var amplitude : Float

  init(_ amp: Float)
  {
    amplitude = amp
  }
  
  var body: some View
  {
    HStack
    {
      Circle().fill(Color.red).opacity(1).onTapGesture
      {
        
      }.frame(width: CGFloat(amplitude) * 100 + 50, height: CGFloat(amplitude) * 100 + 50).animation(.easeIn(duration: 0.01), value: true)

      Text("x: " + String(UIScreen.main.bounds.width * CGFloat(amplitude)) + " y: " + String(UIScreen.main.bounds.height * CGFloat(amplitude)))
    }.position(x: UIScreen.main.bounds.width * CGFloat(amplitude) , y: UIScreen.main.bounds.height * CGFloat(amplitude))
  }
}
