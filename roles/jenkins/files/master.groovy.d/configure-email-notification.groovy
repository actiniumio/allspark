println("** Configuring email notification")

import jenkins.model.*

def inst = Jenkins.getInstance()
def desc = inst.getDescriptor("hudson.tasks.Mailer")

//E-mail Server
desc.smtpHost = "smtp_relay"
desc.smtpPort = "25"
desc.replyToAddress = "admin@jenkins.allspark"
desc.charset = "utf-8"

// Save the changes
desc.save()
