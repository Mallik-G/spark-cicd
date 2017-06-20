package ch.scigility

import com.holdenkarau.spark.testing.{DatasetSuiteBase, SharedSparkContext}
import org.apache.spark.sql.SparkSession
import org.scalatest.{BeforeAndAfterEach, FunSuite, Matchers}
import frameless.syntax._
import org.apache.spark.sql.{Dataset, SparkSession}

/**
  * Created by snuesch on 15.06.17.
  */
class CharCounterSpec extends FunSuite with DatasetSuiteBase with Matchers with BeforeAndAfterEach{


  test("CharCount test"){
    implicit val sparkImpl = spark
    import sparkImpl.implicits._
    require(sparkImpl != null, "spark session is null")
    val words = Seq("asdf", "jklö", "foo", "bar", "baz")
    val wordsDS = sparkImpl.createDataset(words)
    val res = CharCounter.countLetters(wordsDS.typed)
    res.count().run() should be (12)
    res.select(res('_2)).collect().run().max should be (3)
  }
}