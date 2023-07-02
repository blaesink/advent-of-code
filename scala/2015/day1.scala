package day1
import inputs.loadFile
import scala.util.control.Breaks._

@main def part1()  =
  val input = loadFile("../data/2015/01.txt")

  var floor = 0

  input.foreach(char => {
    char match
      case '(' => 
        floor += 1
      case ')' =>
        floor -= 1
      case _ =>
        ()
  })

  println(floor)

@main def part2(): Unit =
  val input = loadFile("../data/2015/01.txt")
  
  var i = 0
  var floor = 0

  breakable{
    for char <- input do
      char match
        case '(' => 
          floor += 1
        case ')' =>
          floor -= 1
        case _ =>
          ()
      i += 1

      if floor < 0 then
        break
  }
  println(i)
