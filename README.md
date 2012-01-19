Stable release download
=======================

If you're looking for stable releases, you can download this module at
the [Puppet Forge](http://forge.puppetlabs.com/users/cparedes/modules/puppet_opsview).

Introduction
=============

Right now, the module only contains libraries to handle all of the REST
requests to a given Opsview server.  You will need to create
/etc/puppet/opsview.conf with the following format on each client that you wish
to connect with an Opsview server:

    url: http://example.com/rest
    username: foobar
    password: foobaz

The libraries are heavily based off of the original Opsview libraries, with
contributions by Devon Peters.

These libraries are currently used in production at [Seattle Biomed][1].

Please file bugs via the issue tracker above.

Prerequisites
=============

* Puppet (of course :))  Tested with Puppet 2.6.8.
* rest-client, json gems.

Resources/Providers
===================

TODO: Need to list parameters for each resource.

* opsview_contact
* opsview_hostgroup
* opsview_hosttemplate
* opsview_keyword
* opsview_monitored
* opsview_role
* opsview_servicecheck
* opsview_servicegroup

Changes
=======

1. Use rest-client library instead of net/http.  This allows us to authenticate
clients over HTTPS and, overall, abstract a lot of the HTTP calls to the
server.

2. Create a subclass called "Puppet::Provider::Opsview" with default methods
that may be overridden by any of the providers.  The class contains methods
that actually hook into the server - thus, the provider Ruby files (in
particular, the flush method in each file) are reduced quite a bit, and we
don't need to explicitly define a function that reads in token information from
the Opsview server. 

3. Rename variables and methods, so they don't use camel case.

4. Rename resources so that they have underscores in them (seems to make more
sense to me to use opsview_monitored vs. opsviewmonitored.)

List of things to do
====================

1. Separate out a few get/set methods from Puppet::Provider::Opsview - put them
in a utility module instead.

2. Clean up Puppet::Provider::Opsview in general.  Cull any class/instance
methods we don't need (there's lots of duplication.)

3. Add default providers so that Puppet runs don't fail when there's no rest-client / json gems to use.

Authors
=======

* Devon Peters &lt;devon.peters@gmail.com&gt; (original author of every provider except opsview_monitored)
* Christian Paredes &lt;christian.paredes@sbri.org&gt;

[1]: http://seattlebiomed.org
