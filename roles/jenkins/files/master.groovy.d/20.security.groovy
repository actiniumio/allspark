#!groovy

import jenkins.model.*
import hudson.security.*


def instance = Jenkins.getInstance();
def hudsonRealm = new HudsonPrivateSecurityRealm(false);

instance.setSecurityRealm(hudsonRealm)

// Disable Jenkins CLI over remoting, which is considered unsecure
// https://jenkins.io/blog/2017/04/11/new-cli/
instance.getDescriptor("jenkins.CLI").get().setEnabled(false)

instance.save()
