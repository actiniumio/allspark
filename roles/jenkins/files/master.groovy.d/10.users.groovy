#!groovy

/*
 *  Create administration user
 */

import jenkins.model.*
import hudson.security.*


def adminUser = new File("/run/secrets/jenkins-user").text.trim()
def adminPass = new File("/run/secrets/jenkins-pass").text.trim()

println "Creating user " + adminUser

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false);

hudsonRealm.createAccount(adminUser, adminPass)
instance.setSecurityRealm(hudsonRealm)
instance.save()
