#!groovy

import jenkins.model.*

// Disable executors on master, as we run the workloads on a separated
// container
Jenkins.instance.setNumExecutors(0)
