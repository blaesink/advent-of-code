package day1
import inputs.loadFile
import scala.util.control.Breaks._


object Input {
  final val raw: String = loadFile("../data/2015/01.txt")
}

@main def part1()  =
  var floor = 0

  Input.raw.foreach(char => {
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
  var i = 0
  var floor = 0

  breakable{
    for char <- Input.raw do
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
