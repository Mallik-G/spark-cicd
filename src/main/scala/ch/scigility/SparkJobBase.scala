package ch.scigility

import org.apache.spark.sql.{Dataset, SparkSession}
import org.apache.spark.{SparkConf, SparkContext}

/**
  * Created by snuesch on 15.06.17.
  */
object SparkJobBase {

  def main(args: Array[String]): Unit = {
    implicit val spark = SparkSession.builder().appName("Char_Count").master("local").getOrCreate()
    val fileName = "./src/main/resources/google-10000-english.txt"

    val lines: Dataset[String] = spark.read.textFile(fileName)

    val count = CharCounter.countLetters(lines)
    count.collect().foreach(println)

    spark.stop()

  }
}
