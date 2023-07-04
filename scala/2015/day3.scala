package day3

import inputs.loadFile
import java.util.HashMap
import scala.collection.mutable

case class House(
  x: Int,
  y: Int,
)

@main def part1(): Unit = 
  val input = loadFile("../data/2015/03.txt")

  var x: Int = 0
  var y: Int = 0

  var visitedHouses = mutable.Map[(Int, Int), Int]((0,0) -> 1)

  for char <- input do
    char match
      case '>' => x += 1
      case '<' => x -= 1
      case '^' => y += 1
      case 'v' => y -= 1
      case _ => ()

    visitedHouses = visitedHouses.updated((x,y), 1)

  println(visitedHouses.count(_._2 >= 1))
