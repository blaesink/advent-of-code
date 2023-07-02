package inputs

import scala.util.Using
import scala.io.Source

def loadFile(path: String): String =
  Using.resource(Source.fromFile(path))(_.mkString)
