set echo on

 alter system set db_unique_name='PRIM_DB_UNIQUE_NAME' scope=both;
 alter system set log_archive_config='dg_config=(PRIM_DB_UNIQUE_NAME,STBY_DB_UNIQUE_NAME)' scope=both;
 alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=PRIM_DB_UNIQUE_NAME' scope=both;
 alter system set log_archive_dest_2='SERVICE=STBY_DB_UNIQUE_NAME LGWR  ASYNC  VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=STBY_DB_UNIQUE_NAME' scope=both;
 alter system set standby_file_management=AUTO scope=both;
 alter system set fal_client='PRIM_DB_UNIQUE_NAME' scope=both;
 alter system set fal_server='STBY_DB_UNIQUE_NAME' scope=both;

set echo off
