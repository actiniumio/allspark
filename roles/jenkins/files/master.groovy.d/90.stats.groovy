#!groovy

/*
 *  Disable anonymous statistics collection
 */

import jenkins.model.Jenkins



def instance = Jenkins.getInstance()

if(!instance.isQuietingDown()) {
  if(instance.isUsageStatisticsCollected()){
    instance.setNoUsageStatistics(true)
    instance.save()
    println 'Disabled submitting usage stats to Jenkins project.'
  } else {
    println 'Nothing changed.  Usage stats are not submitted to the Jenkins project.'
  }
} else {
  println 'Shutdown mode enabled.  Disable usage stats SKIPPED.'
}
