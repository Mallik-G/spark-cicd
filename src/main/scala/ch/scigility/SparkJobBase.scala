package ch.scigility

import frameless.functions.aggregate._
import frameless.TypedDataset
import org.apache.spark.sql.{Dataset, SparkSession}
import org.apache.spark.{SparkConf, SparkContext}
import frameless.syntax._

/**
  * Created by snuesch on 15.06.17.
  */
object SparkJobBase {

  def main(args: Array[String]): Unit = {
    implicit val spark = SparkSession.builder().appName("Char_Count").master("local").getOrCreate()
    val fileName = "./src/main/resources/google-10000-english.txt"

    val lines = spark.read.textFile(fileName).typed

    CharCounter.countLetters(lines).show().run()

    spark.stop()

  }
}
