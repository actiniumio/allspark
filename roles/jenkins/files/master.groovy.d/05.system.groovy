
import jenkins.model.*


def instance = Jenkins.getInstance()


// Fix slave port
instance.setSlaveAgentPort(9489)

instance.save()
