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

