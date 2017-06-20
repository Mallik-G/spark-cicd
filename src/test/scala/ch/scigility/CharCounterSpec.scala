package ch.scigility

import com.holdenkarau.spark.testing.{DatasetSuiteBase, SharedSparkContext}
import org.apache.spark.sql.{Dataset, SparkSession}
import org.scalatest.{FunSuite, Matchers}

/**
  * Created by snuesch on 15.06.17.
  */
class CharCounterSpec extends FunSuite with DatasetSuiteBase with Matchers{

  test("CharCount test"){
    implicit val sparkImpl: SparkSession = spark
    import sparkImpl.implicits._
    val words = Seq("asdf", "jklö", "foo", "bar", "baz")
    val wordsDS = sparkImpl.createDataset(words)
    val res: Dataset[(String, Long)] = CharCounter.countLetters(wordsDS)
    res.count should be (12)
    res.select("_2").as[Long].collect.max should be (3)
  }
}