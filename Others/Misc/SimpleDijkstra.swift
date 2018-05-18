import Foundation

func dijkstra(graph: [[(edge: Int, dist: Int)]], source: Int) -> [Int] {
  var processed = [Bool](repeating: false, count: graph.count)
  var distances = [Int](repeating: Int.max, count: graph.count)
  processed[source] = true
  distances[source] = 0
  for _ in 0..<graph.count {
    let (cIndex, minDist) = getClosestNode(processed: processed, distances: distances)
    if minDist == Int.max {
      return distances
    }
    processed[cIndex] = true
    distances[cIndex] = minDist
    for (edge, edist) in graph[cIndex] {
      let newDist = edist + minDist
      if !processed[edge] && newDist < distances[edge] {
        distances[edge] = newDist
      }
    }
  }
  return distances
}

func getClosestNode(processed: [Bool], distances: [Int]) -> (index: Int, distance: Int) {
  var index = -1
  var distance = Int.max
  for i in 0..<processed.count {
    if !processed[i] && distance >= distances[i] {
      index = i
      distance = distances[i]
    }
  }
  return (index, distance)
}