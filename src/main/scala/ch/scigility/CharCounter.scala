package ch.scigility


import org.apache.spark.rdd.RDD
import org.apache.spark.sql._

/**
  * Created by snuesch on 15.06.17.
  */
object CharCounter {
  def countLetters(rdd: Dataset[String])(implicit spark: SparkSession):Dataset[(String,Long)] = {
    import spark.implicits._
    val kv = for {
      str <- rdd
      ch <- str
    } yield (ch.toString, 1)

    kv
      .groupBy(kv("_1"))
      .sum("_2")
      .map(
        row => {
          (row.getString(0), row.getLong(1))
        }
      )

  }




  
}
