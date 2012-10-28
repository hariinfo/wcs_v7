README for WXS DEV config.

1. Default Dynacache WXS config files are available OOB at following location
eXtremeScale\ObjectGrid\dynacache\etc
	dynacache-remote-deployment.xml
	dynacache-remote-objectgrid.xml
2. Ensure following properties are set from WCS JVM custom properties

com.ibm.websphere.xs.dynacache.topology	 remote
com.ibm.websphere.xs.dynacache.disable_recursive_invalidate	 true
com.ibm.websphere.xs.dynacache.ignore_value_in_change_event	 true
com.ibm.websphere.xs.dynacache.enable_compression	 true

3. Ensure Catalog server is configured from WAS admin console.
System Administration -> WebSphere eXtreme Scale 
Reference:
https://www.ibm.com/developerworks/wikis/display/extremescale/Configure+WebSphere+Commerce+to+use+WebSphere+eXtreme+Scale+for+dynamic+cache+to+improve+performance+and+scale

4. Extreme Scale Catalog server contracts.
---------------------------------------
1. Grid clients connect to catalog server to get details of location of a shard.
2. Catalog server also determines logic to distribute shard across multiple container.
3. The memory and CPU requirement of catalog server does not depend on data that is stored in the Grid.
4. Catalog server can be started with no min heap, but max heap of -Xmx1g
5. -Xgcpolicy:gencon
6. -verbose:gc -Xverbosegclog:<VERBOSE GC LOG File Location>

5. Shard
------
1. The shard distribution algorithm ensures that a Shards replica never existing in the same conatiner or same ip 
as compared to the primary shard, this ensures fault tolerance and high availability.
2. If the machine and primary shard container fails, the catalog service promotes replica shard as primary
and creates a new replica shard on another grid container or IP address.
3. 

6. Container
----------
1. Heap size for container is -Xms2g -Xmx4g
2. -Xgcpolicy:gencon
3. -verbose:gc
4. -Xcompressedrefs -Xmn800m
5. -Djava.net.preferIPv4Stack=true
If you are sure that you will only communicate with IPv4 addresses, you can set the following Java property in each server



7. -Dcom.ibm.cacheLocalHost=True
The following IBM JVM property will cache the ip address of the hostname in a static string,
upon the first call to getLocalHost(). Later calls will use this string if it exists.
This will turn on the caching to change the behavior back to what it was prior
to Java 1.4.1 so that a full network DNS lookup is not performed every time the method is called.
http://www-01.ibm.com/support/docview.wss?uid=swg21170467
