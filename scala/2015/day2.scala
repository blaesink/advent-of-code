package day2

import inputs.loadFile

object Input {
  final val raw: String = loadFile("../data/2015/02.txt")
}

case class Present(
  l: Int,
  w: Int,
  h: Int
): 
  def wrapping_paper_area: Int =
        val side1 = this.l * this.w;
        val side2 = this.w * this.h;
        val side3 = this.h * this.l;

        2 * side1 + 2 * side2 + 2 * side3 + Math.min(side1, Math.min(side2, side3))

  def volume: Int = this.l * this.w * this.h

  def ribbon_length: Int =
        var sides = Array(this.l, this.w, this.h).sorted

        // val smallest_side = sides.take(2).sum
        // smallest_side * 2 + this.volume

        // Super short version
        sides.take(2).sum * 2 + this.volume



object Present {
  def apply(dimensions: Array[Int]): Present = 
    Present(dimensions(0), dimensions(1), dimensions(2))
}

@main def part1(): Unit =
  val presents = Input.raw
    .lines
    .map(line => Present(line.split("x").map(_.toInt)))
    .map(_.wrapping_paper_area)
  
    println(presents.reduce(_+_).get)

@main def part2(): Unit =
  println(
    Input.raw
      .lines
      .map(line => Present(line.split("x").map(_.toInt)))
      .map(_.ribbon_length)
      .reduce(_+_).get
    )
