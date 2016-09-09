# Register the standby information
 srvctl add database -d Standby_Db_Unique_name  -o Oracle Home Path  -p SPFILE_Location_in_ASM -n DB_Name  -r PHYSICAL_STANDBY  -s mount
 srvctl add instance -d Standby_DB_Unique_name  -i Node1_SID -n Node1_Physical_Hostname
 srvctl add instance -d Standby_DB_Unique_name  -i Node2_SID -n Node2_Physical_Hostname

#Verify the Configuration,
 srvctl config database -d  Standby_DB_Unique_name
 srvctl config database -d  Standby_DB_Unique_name  –a

#Verify start/stop of the database. And check it works successfully,
 srvctl stop database –d  Standby_DB_Unique_name
 srvctl start database –d  Standby_DB_Unique_name
