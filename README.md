# CI for Spark Applications

This repository intends to demonstrate the usage of a
Continuous Integration Pipeline for Scala Apps to run on Apache spark

![Continuous Integration](diagrams/cicd-pipeline.png)

## Installing Continuous Integration Software

Jenkins was the CI tool choose to run these exercise.


## Adding Jenkins Pipeline

```
pipeline {
  agent any
  stages{
    stage('build') {
      steps {
        sh 'sbt clean compile'
      }
      stage('unit') {
        steps {
          sh 'sbt test'
        }
      }
      stage('artifact') {
        steps {
          sh 'sbt package'
          archiveArtifacts artifacts: 'target/scala-2.11/*.jar', fingerprint: true
        }
      }
      stage('integration') {
        steps {
        sh 'aws emr create-cluster --name "Add Spark Step Cluster" --release-label emr-5.6.0 --applications Name=Spark --ec2-attributes KeyName=myKey --instance-type m3.xlarge --instance-count 3 --steps Type=CUSTOM_JAR,Name="Spark Program",Jar="target/scala-2.11/basicspark_2.11-1.0.jar",ActionOnFailure=CONTINUE,Args=[spark-example,SparkPi,10] --use-default-roles '
  }
}
    }
  }
}
```
