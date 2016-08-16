//
//  PlasticViewsContainer.swift
//  Katana
//
//  Created by Mauro Bolis on 16/08/16.
//  Copyright © 2016 Bending Spoons. All rights reserved.
//

import Foundation

private let ROOT_KEY = "//ROOT_KEY\\"

public class PlasticViewsContainer {
  private var views: [String: PlasticView] = [:]
  
  public var rootView: PlasticView {
    return self.views[ROOT_KEY]!
  }

  init(rootFrame: CGRect, children: [AnyNodeDescription]) {
    let multiplier: CGFloat = 1.0 // TODO implement me
    
    self.views[ROOT_KEY] = PlasticView(
      hierarchyManager: self,
      key: ROOT_KEY,
      multiplier: multiplier,
      frame: rootFrame
    )
    
    // create children placeholders
    let childrenKeys = nodeChildrenKeys(children)
    childrenKeys.forEach {
      self.views[$0] = PlasticView(hierarchyManager: self, key: $0, multiplier: multiplier)
    }
  }
  
  public subscript(key: String) -> PlasticView? {
    return self.views[key]
  }
}

private extension PlasticViewsContainer {
  private func nodeChildrenKeys(_ children: [AnyNodeDescription]) -> [String] {
    return children.reduce([], { (partialResult, node) -> [String] in
      
      let childrenKeys = self.nodeChildrenKeys(node.children)
      
      guard let key = node.key else {
        return partialResult + childrenKeys
      }
      
      return partialResult + [key] + childrenKeys
    })
  }
}

extension PlasticViewsContainer: HierarchyManager {
  func relativeXCoordinate(_ absoluteValue: CGFloat, forViewWithKey: String) -> CGFloat {
    // TODO implement me
    return absoluteValue
  }

  func relativeYCoordinate(_ absoluteValue: CGFloat, forViewWithKey: String) -> CGFloat {
    // TODO implement me
    return absoluteValue
  }
}
