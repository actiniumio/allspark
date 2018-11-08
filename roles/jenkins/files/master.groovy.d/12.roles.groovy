import java.lang.reflect.*


import jenkins.model.*
import hudson.security.*
import com.michelin.cio.hudson.plugins.rolestrategy.*


def adminUser = new File("/run/secrets/jenkins-user").text.trim()
def globalRoleRead = "authenticated"
def globalRoleAdmin = "admin"

// Make constructors accessible
Constructor[] constrs = Role.class.getConstructors();
for (Constructor<?> c : constrs) {
  c.setAccessible(true);
}

// Make the method assignRole accessible
Method assignRoleMethod = RoleBasedAuthorizationStrategy.class.getDeclaredMethod("assignRole", String.class, Role.class, String.class);
assignRoleMethod.setAccessible(true);



Set<Permission> adminPermissions = new HashSet<Permission>();

adminPermissions.add(Permission.fromId("hudson.model.Computer.Connect"));
adminPermissions.add(Permission.fromId("hudson.model.Computer.Create"));
adminPermissions.add(Permission.fromId("hudson.model.Computer.Build"));
adminPermissions.add(Permission.fromId("hudson.model.Computer.Delete"));
adminPermissions.add(Permission.fromId("hudson.model.Computer.Configure"));
adminPermissions.add(Permission.fromId("hudson.model.Computer.Disconnect"));
adminPermissions.add(Permission.fromId("hudson.model.Hudson.Administer"));
adminPermissions.add(Permission.fromId("hudson.model.Hudson.Read"));
adminPermissions.add(Permission.fromId("hudson.model.Hudson.UploadPlugins"));
adminPermissions.add(Permission.fromId("hudson.model.Hudson.ConfigureUpdateCenter"));
adminPermissions.add(Permission.fromId("hudson.model.Hudson.RunScripts"));
adminPermissions.add(Permission.fromId("hudson.model.Run.Update"));
adminPermissions.add(Permission.fromId("hudson.model.Run.Delete"));
adminPermissions.add(Permission.fromId("hudson.model.View.Configure"));
adminPermissions.add(Permission.fromId("hudson.model.View.Create"));
adminPermissions.add(Permission.fromId("hudson.model.View.Delete"));
adminPermissions.add(Permission.fromId("hudson.model.View.Read"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Build"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Cancel"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Configure"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Create"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Discover"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Read"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Workspace"));
adminPermissions.add(Permission.fromId("hudson.model.Item.Delete"));
adminPermissions.add(Permission.fromId("hudson.scm.SCM.Tag"));

Set<Permission> authenticatedPermissions = new HashSet<Permission>();
authenticatedPermissions.add(Permission.fromId("hudson.model.Hudson.Read"));
authenticatedPermissions.add(Permission.fromId("hudson.model.View.Configure"));
authenticatedPermissions.add(Permission.fromId("hudson.model.View.Create"));
authenticatedPermissions.add(Permission.fromId("hudson.model.View.Delete"));
authenticatedPermissions.add(Permission.fromId("hudson.model.View.Read"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Build"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Cancel"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Configure"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Create"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Discover"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Read"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Workspace"));
authenticatedPermissions.add(Permission.fromId("hudson.model.Item.Delete"));

Role adminRole = new Role(globalRoleAdmin, adminPermissions);
Role authenticatedRole = new Role(globalRoleRead, authenticatedPermissions);

def strategy = new RoleBasedAuthorizationStrategy();


strategy.addRole(RoleBasedAuthorizationStrategy.GLOBAL, adminRole);
strategy.addRole(RoleBasedAuthorizationStrategy.GLOBAL, authenticatedRole);

strategy.assignRole(RoleBasedAuthorizationStrategy.GLOBAL, adminRole, adminUser);
strategy.assignRole(RoleBasedAuthorizationStrategy.GLOBAL, authenticatedRole, globalRoleRead);

def instance = Jenkins.getInstance();
instance.setAuthorizationStrategy(strategy)
instance.save()
