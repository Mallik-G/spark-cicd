package ch.scigility


import frameless.TypedDataset
import frameless.functions.aggregate.sum
import org.apache.spark.rdd.RDD
import org.apache.spark.sql._

/**
  * Created by snuesch on 15.06.17.
  */
object CharCounter {
  def countLetters(lines: TypedDataset[String])(implicit spark: SparkSession):TypedDataset[(String,Long)] = {
    import spark.implicits._
    val kv: TypedDataset[(String, Int)] = for{
      str <- lines
      chr <- str
    } yield(chr.toString, 1)

    kv.groupBy(kv('_1)).agg(sum(kv('_2)))

  }




  
}
