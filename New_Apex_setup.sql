
/* Following software are installed in the given order for Apex.
    1-	Oracle Client 19c installation with slient mode.
	
	2-	jdk-17.0.7_linux-x64_bin.tar.gz

	3-	latest oracle apex installtion 

	4-	apache-tomcat-10.1.10.tar.gz

	5-	latest Oracle Rest Data Service (ORDS) installations (ords have  ords.war file which will be deployed on tomacat to access apex).
*/
--step 1 Intallation of oracle client 19c
--Hosts File
  --step 1.1
[root@apexserver ~]# vi /etc/hosts
/*
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.120.40 apexserver.com.np   apexserver

*/
 --step 1.2
--Oracle Installation Prerequisites
[root@apexserver ~]# yum install -y oracle-database-preinstall-19c
/*
Loaded plugins: langpacks, ulninfo
Resolving Dependencies
--> Running transaction check
---> Package oracle-database-preinstall-19c.x86_64 0:1.0-3.el7 will be installed
--> Processing Dependency: ksh for package: oracle-database-preinstall-19c-1.0-3.el7.x86_64
--> Processing Dependency: libaio-devel for package: oracle-database-preinstall-19c-1.0-3.el7.x86_64
--> Running transaction check
---> Package ksh.x86_64 0:20120801-144.0.1.el7_9 will be installed
---> Package libaio-devel.x86_64 0:0.3.109-13.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=========================================================================================================================================================================================
 Package                                                  Arch                             Version                                            Repository                            Size
=========================================================================================================================================================================================
Installing:
 oracle-database-preinstall-19c                           x86_64                           1.0-3.el7                                          ol7_latest                            27 k
Installing for dependencies:
 ksh                                                      x86_64                           20120801-144.0.1.el7_9                             ol7_latest                           882 k
 libaio-devel                                             x86_64                           0.3.109-13.el7                                     ol7_latest                            12 k

Transaction Summary
=========================================================================================================================================================================================
Install  1 Package (+2 Dependent packages)

Total download size: 921 k
Installed size: 3.2 M
Downloading packages:
(1/3): libaio-devel-0.3.109-13.el7.x86_64.rpm                                                                                                                     |  12 kB  00:00:00
(2/3): oracle-database-preinstall-19c-1.0-3.el7.x86_64.rpm                                                                                                        |  27 kB  00:00:00
(3/3): ksh-20120801-144.0.1.el7_9.x86_64.rpm                                                                                                                      | 882 kB  00:00:00
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                    805 kB/s | 921 kB  00:00:01
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
Warning: RPMDB altered outside of yum.
  Installing : libaio-devel-0.3.109-13.el7.x86_64                                                                                                                                    1/3
  Installing : ksh-20120801-144.0.1.el7_9.x86_64                                                                                                                                     2/3
  Installing : oracle-database-preinstall-19c-1.0-3.el7.x86_64                                                                                                                       3/3
  Verifying  : ksh-20120801-144.0.1.el7_9.x86_64                                                                                                                                     1/3
  Verifying  : libaio-devel-0.3.109-13.el7.x86_64                                                                                                                                    2/3
  Verifying  : oracle-database-preinstall-19c-1.0-3.el7.x86_64                                                                                                                       3/3

Installed:
  oracle-database-preinstall-19c.x86_64 0:1.0-3.el7

Dependency Installed:
  ksh.x86_64 0:20120801-144.0.1.el7_9                                                        libaio-devel.x86_64 0:0.3.109-13.el7

Complete!

*/


----step 1.3
[root@apexserver ~]#  yum update -y
--The following packages are listed as required.
/*
yum install -y bc    
yum install -y binutils
yum install -y compat-libcap1
yum install -y compat-libstdc++-33
#yum install -y dtrace-modules
#yum install -y dtrace-modules-headers
#yum install -y dtrace-modules-provider-headers
yum install -y dtrace-utils
yum install -y elfutils-libelf
yum install -y elfutils-libelf-devel
yum install -y fontconfig-devel
yum install -y glibc
yum install -y glibc-devel
yum install -y ksh
yum install -y libaio
yum install -y libaio-devel
yum install -y libdtrace-ctf-devel
yum install -y libXrender
yum install -y libXrender-devel
yum install -y libX11
yum install -y libXau
yum install -y libXi
yum install -y libXtst
yum install -y libgcc
yum install -y librdmacm-devel
yum install -y libstdc++
yum install -y libstdc++-devel
yum install -y libxcb
yum install -y make
yum install -y net-tools # Clusterware
yum install -y nfs-utils # ACFS
yum install -y python # ACFS
yum install -y python-configshell # ACFS
yum install -y python-rtslib # ACFS
yum install -y python-six # ACFS
yum install -y targetcli # ACFS
yum install -y smartmontools
yum install -y sysstat

# Added by me.
yum install -y unixODBC

*/
 --step 1.4
--Create the new groups and users.
[root@apexserver ~]# useradd -u 54321 -g oinstall -G dba,oper oracle

 --step 1.5
--Additional Setup
[root@apexserver ~]# passwd oracle
/*
Changing password for user oracle.
New password:
BAD PASSWORD: The password is shorter than 8 characters
Retype new password:
passwd: all authentication tokens updated successfully.
*/
 --step 1.6
[root@apexserver ~]# vi /etc/selinux/config
/*
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
*/
--steo 1.7 disable firewall 
[root@apexserver ~]# setenforce Permissive
[root@apexserver ~]# systemctl stop firewalld
[root@apexserver ~]# systemctl disable firewalld
/*
Removed symlink /etc/systemd/system/multi-user.target.wants/firewalld.service.
Removed symlink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service.
*/
--step 1.8 create necessary directorires 
[root@apexserver ~]# mkdir -p /u01/app/oraInventory
[root@apexserver ~]# chown -R oracle:oinstall /u01/app/oraInventory
[root@apexserver ~]# chmod -R 775 /u01/app/oraInventory
[root@apexserver ~]# mkdir -p /u01/app/oracle/product/19.0.0/client_1
[root@apexserver ~]# chown -R oracle:oinstall /u01
[root@apexserver ~]# chmod -R 775 /u01

--step 1.9
--Download Client software from oracle websites and unzip software client binaries 
[root@apexserver ~]# mkdir -p /home/oracle/software
[root@apexserver ~]# chown -R oracle:oinstall /home/oracle/software
[root@apexserver ~]# chmod -R 775 /home/oracle/software

[oracle@apexserver ~]$ unzip V982064-01.zip -d /home/oracle/software/
[oracle@apexserver ~]$ cd /home/oracle/software/client
[oracle@apexserver client]$ ll
/*
drwxrwxr-x.  4 oracle oinstall 4096 Jul 18 07:37 install
drwxrwxr-x.  2 oracle oinstall   49 Jul 18 08:10 response
-rwxrwxr-x.  1 oracle oinstall 8854 Jul 18 07:37 runInstaller
drwxrwxr-x. 15 oracle oinstall 4096 Jul 18 07:38 stage
-rwxrwxr-x.  1 oracle oinstall  500 Jul 18 07:38 welcome.html
*/

--step 1.10
[oracle@apexserver client]$ cd response/
[oracle@apexserver response]$ vi client_install.rsp
/*

INVENTORY_LOCATION=/u01/app/oraInventory
UNIX_GROUP_NAME=oinstall
SELECTED_LANGUAGES=en
ORACLE_HOME=/u01/app/oracle/product/19.0.0/client_1
ORACLE_BASE=/u01/app/oracle
oracle.install.client.installType=Administrator
oracle.install.client.customComponents=oracle.rdbms.util:19.0.0.0.0,oracle.javavm.client:19.0.0.0.0,oracle.sqlplus:19.0.0.0.0,oracle.dbjava.jdbc:19.0.0.0.0,
oracle.oraolap.mgmt:19.0.0.0.0,oracle.network.client:19.0.0.0.0,oracle.network.listener:19.0.0.0.0,oracle.odbc:19.0.0.0.0
*/
--step 1.11
[oracle@apexserver client]$ ./runInstaller -ignoreSysPrereqs -showProgress -silent -responseFile /home/oracle/software/client/response/client_install.rsp
/*
Starting Oracle Universal Installer...

Checking Temp space: must be greater than 415 MB.   Actual 1647 MB    Passed
Checking swap space: must be greater than 150 MB.   Actual 8191 MB    Passed
Preparing to launch Oracle Universal Installer from /tmp/OraInstall2023-07-18_08-10-47AM. Please wait ...[oracle@apexserver client]$ The response file for this session can be found at:
 /u01/app/oracle/product/19.0.0/client_1/install/response/client_2023-07-18_08-10-47AM.rsp

..........
Prepare in progress.
..................................................   7% Done.

Prepare successful.

Copy files in progress.
..................................................   12% Done.
..................................................   17% Done.
..................................................   22% Done.
..................................................   27% Done.
..................................................   32% Done.
..................................................   37% Done.
..................................................   42% Done.
..................................................   47% Done.
..................................................   52% Done.
........................................
Copy files successful.

Link binaries in progress.
..........
Link binaries successful.

Setup files in progress.
..................................................   57% Done.
....................
Setup files successful.

Setup Inventory in progress.

Setup Inventory successful.

Finish Setup in progress.
..........
Finish Setup successful.
The installation of Oracle Client 19c was successful.
Please check '/u01/app/oraInventory/logs/silentInstall2023-07-18_08-10-47AM.log' for more details.

Setup Oracle Base in progress.

Setup Oracle Base successful.
..................................................   67% Done.

Prepare for configuration steps in progress.

Prepare for configuration steps successful.
..................................................   82% Done.

Oracle Client Configuration in progress.

Oracle Client Configuration successful.
..................................................   96% Done.

As a root user, execute the following script(s):
        1. /u01/app/oraInventory/orainstRoot.sh



Successfully Setup Software.
..................................................   100% Done.
The log of this install session can be found at:
 /u01/app/oraInventory/logs/installActions2023-07-18_08-10-47AM.log

*/

[oracle@apexserver client]$ su - root
Password:
Last login: Tue Jul 18 07:47:47 +0545 2023 on pts/1
[root@apexserver ~]# /u01/app/oraInventory/orainstRoot.sh
/*
Changing permissions of /u01/app/oraInventory.
Adding read,write permissions for group.
Removing read,write,execute permissions for world.

Changing groupname of /u01/app/oraInventory to oinstall.
The execution of the script is complete.

*/

[oracle@apexserver~] export ORACLE_HOME=/u01/app/oracle/product/19.0.0/client_1
[oracle@apexserver~] export PATH=$ORACLE_HOME/bin:$PATH

--step 1.12 
[oracle@apexserver~]cd  /u01/app/oracle/product/19.0.0/client_1/network/admin/

[oracle@apexserver oracle_client]$ vi tnsnames.ora
/*
#tnsnames.ora Network Configuration File: /u01/app/oracle/product/19.0.0/dbhome_1/network/admin/tnsnames.ora
# Generated by Oracle configuration tools.

LISTENER_ORCL =
  (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.120.42)(PORT = 1521))


ORCL =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.120.42)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )


ORCLPDB =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.120.42)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orclpdb)
    )
  )
  
 */

[oracle@apexserver admin]$ sqlplus sys/Adminrabin1@orcl as sysdba
/*
SQL*Plus: Release 19.0.0.0.0 - Production on Thu Jul 20 08:16:05 2023
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> show con_name;

CON_NAME
------------------------------
CDB$ROOT
SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         2 PDB$SEED                       READ ONLY  NO
         3 ORCLPDB                        READ WRITE NO
	


*/

[oracle@apexserver admin]$ sqlplus sys/Adminrabin1@orclpdb as sysdba
/*
SQL*Plus: Release 19.0.0.0.0 - Production on Thu Jul 20 08:15:46 2023
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> show con_name;

CON_NAME
------------------------------
ORCLPDB
SQL> show pdbs;

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         3 ORCLPDB                        READ WRITE NO

*/
-- step 2 Installation jdk 17 on machine
--  step 2.1 download the jdk software from oracle website
[root@apexserver ]$ wget https://download.oracle.com/java/17/archive/jdk-17.0.7_linux-x64_bin.tar.gz
  --step 2.2 extract Java
[oracle@apexserver ~]$ tar -zxvf jdk-17.0.7_linux-x64_bin.tar.gz  -C /u01/app/oracle/java/
[oracle@apexserver java]# ln -s jdk-17.0.7 latest

[oracle@apexserver ]$ export JAVA_HOME=/u01/app/oracle/java/jdk-17.0.7
[oracle@apexserver ]$ export PATH=$JAVA_HOME/bin:$PATH
[oracle@apexserver ~]$ java --version
/*
java 17.0.7 2023-04-18 LTS
Java(TM) SE Runtime Environment (build 17.0.7+8-LTS-224)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.7+8-LTS-224, mixed mode, sharing)
*/
--step 3 Apex installation   
  --step 3.1 Download from apex software from oracle website.
[oracle@apexserver ~]$ wget https://download.oracle.com/otn_software/apex/apex_23.1.zip
/*
--2023-07-18 23:45:38--  https://download.oracle.com/otn_software/apex/apex_23.1.zip
Resolving download.oracle.com (download.oracle.com)... 124.41.244.73
Connecting to download.oracle.com (download.oracle.com)|124.41.244.73|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 256253990 (244M) [application/zip]
Saving to: ‘apex_23.1.zip’

100%[===============================================================================================================================================>] 256,253,990 21.4MB/s   in 11s

2023-07-18 23:45:49 (22.6 MB/s) - ‘apex_23.1.zip’ saved [256253990/256253990]
*/
[oracle@apexserver ~]$ unzip apex_23.1.zip -d /u01/app/oracle/

--necessary directory and it's premession
[root@apexserver ]# mkdir -p  /u01/app/oracle/apex
[root@apexserver ]# chown -R oracle:oinstall /u01/app/oracle/apex
[root@apexserver ]# chmod -R 775 /u01/app/oracle/apex

[root@apexserver ]# mkdir -p  /u01/app/oracle/ords
[root@apexserver ]# chown -R oracle:oinstall /u01/app/oracle/ords
[root@apexserver ]# chmod -R 775 /u01/app/oracle/ords

[root@apexserver ]# mkdir -p  /u01/app/oracle/java
[root@apexserver ]# chown -R oracle:oinstall /u01/app/oracle/java
[root@apexserver ]# chmod -R 775 /u01/app/oracle/java

[root@apexserver ]# mkdir -p  /u01/app/oracle/tomcat
[root@apexserver ]# chown -R oracle:oinstall /u01/app/oracle/tomcat
[root@apexserver ]# chmod -R 775 /u01/app/oracle/tomcat
--setup .bash_profile
/*
export TNS_ADMIN=/u01/app/oracle/product/19.0.0/dbhome_1/network/admin
export ORACLE_HOME=/u01/app/oracle/product/19.0.0/client_1
export PATH=$ORACLE_HOME/bin:$PATH
export JAVA_HOME=/u01/app/oracle/java/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH
export APEX_HOME=/u01/app/oracle/apex
export ORDS_HOME=/u01/app/oracle/ords
export CATALINA_HOME=/u01/app/oracle/tomcat/apache-tomcat-9.0.76
export CATALINA_BASE=/u01/app/oracle/tomcat/apache-tomcat-9.0.76
export ORDS_CONFIG=/u01/app/oracle/ords/config
export JAVA_OPTS="-Dconfig.url=${ORDS_CONFIG} -Xms2048M -Xmx4096M"


*/




--step 4 Installation of Apex on Oracle linux 

--Create APEX_DATA and APEX_FILES tablespaces on pluggable Database

SQL> CREATE TABLESPACE APEX_DATA DATAFILE '/u01/app/oracle/oradata/ORCL/orclpdb/apex_data01.dbf' size 2G autoextend on;

TABLESPACE APEX_DATA created.

SQL> CREATE TABLESPACE APEX_FILES DATAFILE '/u01/app/oracle/oradata/ORCL/orclpdb/apex_files01.dbf' size 2G autoextend on;

TABLESPACE APEX_FILES created.

SQL> SELECT TABLESPACE_NAME, FILE_NAME, AUTOEXTENSIBLE, MAXBYTES/1024/1024 AS "MAXSIZE(MB)" FROM DBA_DATA_FILES;
/*
   TABLESPACE_NAME                                                FILE_NAME    AUTOEXTENSIBLE     MAXSIZE(MB)
__________________ ________________________________________________________ _________________ _______________
UNDOTBS1           /u01/app/oracle/oradata/ORCL/orclpdb/undotbs01.dbf       YES                  32767.984375
SYSAUX             /u01/app/oracle/oradata/ORCL/orclpdb/sysaux01.dbf        YES                  32767.984375
SYSTEM             /u01/app/oracle/oradata/ORCL/orclpdb/system01.dbf        YES                  32767.984375
USERS              /u01/app/oracle/oradata/ORCL/orclpdb/users01.dbf         YES                  32767.984375
APEX_DATA          /u01/app/oracle/oradata/ORCL/orclpdb/apex_data01.dbf     YES                  32767.984375
APEX_FILES         /u01/app/oracle/oradata/ORCL/orclpdb/apex_files01.dbf    YES                  32767.984375

*/

3. Run various APEX SQL scripts. If each script exits the sqlplus prompt, then simply reconnect and run the next script.

[root@apexserver] cd /u01/app/oracle/apex

[root@apexserver apex]# sqlplus "sys/Adminrabin1@orclpdb as sysdba"
/*
SQL*Plus: Release 19.0.0.0.0 - Production on Thu Jul 6 20:32:37 2023
Version 19.19.0.0.0

Copyright (c) 1982, 2022, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.19.0.0.0

SQL> show pdbs

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         3 ORCLPDB                        READ WRITE NO
*/

[root@apexserver apex]# sqlplus "sys/Adminrabin1@orclpdb as sysdba"
/*
SQL*Plus: Release 19.0.0.0.0 - Production on Thu Jul 6 20:36:16 2023
Version 19.19.0.0.0

Copyright (c) 1982, 2022, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.19.0.0.0

SQL> @apexins.sql APEX_DATA APEX_FILES TEMP /i/
...set_appun.sql

PL/SQL procedure successfully completed.


...set_ufrom_and_upgrade.sql

PL/SQL procedure successfully completed.


Session altered.


FOO3
------------------------------
install2023-07-06_20-37-03.log

. ORACLE
.
. Oracle APEX Installation.
..........................................
.
...set_appun.sql
... Checking prerequisites (MANUAL)
.
. SYSDBA Privilege
.   pass - Connection with SYSDBA privilege.
. Database rolling upgrade
.   pass - No rolling upgrade.
. DB components
.   pass - CATPROC: version=19.0.0.0.0
.   pass - XDB: version=19.0.0.0.0
. XDB
.   pass - is valid
. DB parameters
.   pass - workarea_size_policy is AUTO
. PL/SQL Web Toolkit
.   pass - version 11.2.0.0.1
. Tablespaces
.   pass - found APEX_DATA
.   pass - found APEX_FILES
.   pass - found TEMP
. PHASES (1,2,3)...

PL/SQL procedure successfully completed.

.
... Prerequisite checks passed.
.
...gen_adm_pwd.sql
Phase 1 (Installation)
#
# Bootstrapping
#
...apxsqler_exit.sql
...setting session environment
...Creating users
...create user APEX_220200
...create user FLOWS_FILES
...create user APEX_PUBLIC_USER
Installing SYS views
...sys_core_views.sql
...core_grants.sql
...grant APEX owner core privileges
...done grant APEX owner core privileges
...Creating APEX_220200 Install Objects
...wwv_flows_release
...wwv_install_api.sql
No errors.
...wwv_install_tabs.sql
...wwv_install_seq
...wwv_install$
...wwv_install_action$
...wwv_install_error$
...wwv_flow_install_errors
No errors.
...wwv_install_api.plb
No errors.
...wwv_install_error$_bi
No errors.
# Proceeding with new installation.

timing for: Bootstrapping
Elapsed: 00:00:04.93
#
# Creating APEX_GRANTS_FOR_NEW_USERS_ROLE
#

timing for: Creating APEX_GRANTS_FOR_NEW_USERS_ROLE
Elapsed: 00:00:00.38
#
# Creating SYS Objects
#
...Create validate procedure in SYS schema and start registration
...validate_apex
No errors.
...sys.wwv_flow_val



No errors.
...wwv_flow_val_wrap18.sql
No errors.
No errors.
...wwv_util_APEX_220200
No errors.
...wwv_util_APEX_220200
No errors.
... Key created.
... created package wwv_flow_key
... created package body wwv_flow_key
...CONNECT as the Oracle user who will own the Oracle APEX engine

timing for: Creating SYS Objects
Elapsed: 00:00:00.27
#
# Creating APEX Tables
#
...create flows_files
... create wwv_flow_file_objects
...create flow objects
GENERIC OBJECTS
WORKSPACE
SESSION STATE MANAGEMENT
PROPERTY EDITOR
APPLICATION > SHARED COMPONENTS > CREDENTIALS
APPLICATION > SHARED COMPONENTS > REMOTE SERVERS
APPLICATION
...wwv_flow_application_groups
...wwv_flows_reserved
...wwv_flow_pages_reserved
WORKSPACE USERS AND GROUPS
...wwv_flow_fnd_user
...wwv_flow_developers
...wwv_flow_password_history
...wwv_flow_fnd_user_groups
...wwv_flow_fnd_group_users
...wwv_flow_fnd_group_groups
...wwv_flow_acl_group_users
...wwv_flow_preferences$
...wwv_flow_persistent_auth$
APPLICATION > SHARED COMPONENTS > DATA PROFILES
APPLICATION > SHARED COMPONENTS > WEB SOURCES
APPLICATION > SHARED COMPONENTS > AUTHORIZATION
...create wwv_flow_security_schemes
APPLICATION > SHARED COMPONENTS > BUILD OPTIONS
APPLICATION > SHARED COMPONENTS > THEMES
themes
APPLICATION > SHARED COMPONENTS > TEMPLATES
...wwv_flow_list_templates
calendar templates
APPLICATION > SHARED COMPONENTS > SHORTCUTS
APPLICATION > SHARED COMPONENTS > PLUGINS
APPLICATION > SHARED COMPONENTS > REPORTS
APPLICATION > SHARED COMPONENTS > GLOBALIZATION
APPLICATION > SHARED COMPONENTS > EMAIL TEMPLATES
APPLICATION > SHARED COMPONENTS > APPLICATION PROCESSES
APPLICATION > SHARED COMPONENTS > APPLICATION ITEMS
APPLICATION > SHARED COMPONENTS > APPLICATION COMPUTATIONS
APPLICATION > SHARED COMPONENTS > AUTHENTICATIONS
APPLICATION > SHARED COMPONENTS > WEB SERVICE REFERENCES
APPLICATION > SHARED COMPONENTS > TABS
APPLICATION > SHARED COMPONENTS > LISTS
APPLICATION > SHARED COMPONENTS > BREADCRUMBS
APPLICATION > SHARED COMPONENTS > TREES
APPLICATION > SHARED COMPONENTS > NAVIGATION BAR ENTRIES
APPLICATION > SHARED COMPONENTS > LISTS OF VALUES
APPLICATION > SHARED COMPONENTS > DATA LOADING
APPLICATION > SHARED COMPONENTS > USER INTERFACE > COMBINED FILES
APPLICATION > SHARED COMPONENTS > APPLICATION SETTINGS
APPLICATION > SHARED COMPONENTS > AUTOMATIONS
APPLICATION > PAGE
...create indexes on wwv_flow_steps table
APPLICATION > PAGE > META TAG
APPLICATION > PAGE > REGION (GENERIC)
APPLICATION > PAGE > BUTTON
APPLICATION > PAGE > ITEM
APPLICATION > PAGE > DYNAMIC ACTIONS
APPLICATION > PAGE > REGION (TREE)
APPLICATION > PAGE > REGION (CALENDAR)
APPLICATION > PAGE > REGION > COLUMN GROUPS
APPLICATION > PAGE > REGION > COLUMNS
APPLICATION > PAGE > REGION (INTERACTIVE REPORTS - GENERIC)
APPLICATION > PAGE > REGION (MAP)
APPLICATION > PAGE > REGION (CARD)
APPLICATION > PAGE > CACHING
APPLICATION > DEVELOPER LOCKING
APPLICATION > SUPPORTING OBJECTS
APPLICATION > APPLICATION MODELS
WORKSHEETS (INTERACTIVE REPORTS)
REGION > INTERACTIVE GRID
REGION > INTERACTIVE GRID > REPORTS
ADVISOR
USER INTERFACE DEFAULTS
FEEDBACK
MAIL QUEUE
LOGS
PURGE
TEAM DEVELOPMENT
SQL WORKSHOP > QUERY BUILDER
...create wwv_flow_sw_stmts
REGION > WEB SOURCE > COMPONENT PARAMETERS
PROCESS > INVOKE API > PARAMETERS
...done create tables
...create ODG tables
...creating global temporary table apex_dg_datasets
...creating global temporary table apex_dg_dataset_rows
...insert default companies
creating object type wwv_flow_tree_entry
creating object type wwv_flow_tree_subs
creating object type wwv_flow_tree_num_arr
creating object type wwv_flow_t_varchar2
creating object type wwv_flow_t_clob
creating object type wwv_flow_t_number
creating object type wwv_flow_t_temp_lov_value
creating object type wwv_flow_t_temp_lov_data
No errors.

creating object type wwv_flow_t_approval_task
No errors.
creating object type wwv_flow_t_approval_tasks
No errors.
creating object type wwv_flow_t_approval_log_row
No errors.
creating object type wwv_flow_t_approval_log_table
No errors.
creating object type wwv_flow_t_search_result_row
No errors.
creating object type wwv_flow_t_search_result_table
No errors.
...done create object types

timing for: Creating APEX Tables
Elapsed: 00:00:10.33
#
# Installing Package Specs (Runtime)
#
...Create v function stub
No errors.
...Create nv function stub
JOB_QUEUE_PROCESSES: 1
timing for: Validating Installation
Elapsed: 00:00:01.23
#
# Actions in Phase 3:
#
    ok 1 - BEGIN                                                        |   0.00
    ok 2 - Updating DBA_REGISTRY                                        |   0.00
    ok 3 - Computing Pub Syn Dependents                                 |   0.00
    ok 4 - Upgrade Hot Metadata and Switch Schemas                      |   0.00
    ok 5 - Removing Jobs                                                |   0.00
    ok 6 - Creating Public Synonyms                                     |   0.02
    ok 7 - Granting Public Synonyms                                     |   0.07
    ok 8 - Granting to FLOWS_FILES                                      |   0.00
    ok 9 - Creating FLOWS_FILES grants and synonyms                     |   0.00
    ok 10 - Syncing ORDS Gateway Allow List                             |   0.00
    ok 11 - Creating Jobs                                               |   0.02
    ok 12 - Creating Dev Jobs                                           |   0.00
    ok 13 - Installing FLOWS_FILES Objects                              |   0.00
    ok 14 - Installing APEX$SESSION Context                             |   0.00
    ok 15 - Recompiling APEX_220200                                     |   0.02
    ok 16 - Installing APEX REST Config                                 |   0.00
    ok 17 - Set Loaded/Upgraded in Registry                             |   0.00
    ok 18 - Removing Unused SYS Objects and Public Privs                |   0.00
    ok 19 - Validating Installation                                     |   0.02
ok 3 - 19 actions passed, 0 actions failed                              |   0.13



Thank you for installing Oracle APEX 22.2.0

Oracle APEX is installed in the APEX_220200 schema.

The structure of the link to the Oracle APEX administration services is as follows:
http://host:port/ords/apex_admin

The structure of the link to the Oracle APEX development interface is as follows:
http://host:port/ords

timing for: Phase 3 (Switch)
Elapsed: 00:00:07.88
timing for: Complete Installation
Elapsed: 00:04:22.82
*/
SYS> @apxchpwd.sql
/*
...set_appun.sql
================================================================================
This script can be used to change the password of an Oracle APEX
instance administrator. If the user does not yet exist, a user record will be
created.
================================================================================
Enter the administrator's username [ADMIN] press enter
User "ADMIN" does not yet exist and will be created.
Enter ADMIN's email [ADMIN] press enter
Enter ADMIN's password []  password Nepal@#123
Created instance administrator ADMIN.
*/
Post-installation tasks
Check validity of installation

SYS> SELECT STATUS FROM DBA_REGISTRY WHERE COMP_ID = 'APEX';
/*
STATUS
--------------------------------------------
VALID
*/

--APEX schemas post installation

SYS> SET LINESIZE 500
SYS> COLUMN username FORMAT A25
SYS> SELECT * FROM ALL_USERS WHERE username LIKE '%APEX%' OR username LIKE '%FLOWS%';
/*

USERNAME                     USER_ID CREATED   COM O INH DEFAULT_COLLATION                                                                                    IMP ALL
------------------------- ---------- --------- --- - --- ---------------------------------------------------------------------------------------------------- --- ---
APEX_230100                      107 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO
FLOWS_FILES                      108 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO
APEX_PUBLIC_USER                 109 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO
*/
SYS> @apex_rest_config.sql
/*

Enter a password for the APEX_LISTENER user              [] oracle123
Enter a password for the APEX_REST_PUBLIC_USER user              [] oracle123
...set_appun.sql
...setting session environment
...create APEX_LISTENER and APEX_REST_PUBLIC_USER users
...grants for APEX_LISTENER and ORDS_METADATA user
INFO: 10:31:41 Setup the APEX REST migration privileges using APEX_230100 schema version 23.1.0
INFO: 10:31:41 grant execute on "ORDS_METADATA"."ORDS_MIGRATE" to "APEX_230100"
INFO: 10:31:41 Configuring APEX and ORDS schemas for url mapping
INFO: 10:31:41 Made APEX_PUBLIC_USER proxiable from ORDS_PUBLIC_USER
INFO: 10:31:41 Made APEX_REST_PUBLIC_USER proxiable from ORDS_PUBLIC_USER
INFO: 10:31:41 APEX_POOL_CONFIG Synonym exists
INFO: 10:31:41 grant select on "APEX_230100"."WWV_FLOW_POOL_CONFIG" to "ORDS_RUNTIME_ROLE"
INFO: 10:31:41 Created ORDS_METADATA.APEX_WWV_FLOW_POOL_CONFIG as view over APEX_230100.WWV_FLOW_POOL_CONFIG
INFO: 10:31:41 grant select on "ORDS_METADATA"."APEX_WWV_FLOW_POOL_CONFIG" to "ORDS_RUNTIME_ROLE"
INFO: 10:31:41 Created ORDS_METADATA.UNIFIED_POOL_CONFIG view.
INFO: 10:31:41 grant select on "ORDS_METADATA"."UNIFIED_POOL_CONFIG" to "ORDS_RUNTIME_ROLE"
Found APEX 23.1.0. Migrating APEX entry points to ORDS PL/SQL Procedure Gateway Allow List
Found APEX 23.1.0. Granting execute on ORDS_APEX_SSO package to APEX_230100
Updated ORDS views and synonyms successfully.

*/
SYS>  SELECT * FROM ALL_USERS WHERE username LIKE '%APEX%' OR username LIKE '%FLOWS%';
/*
USERNAME                     USER_ID CREATED   COM O INH DEFAULT_COLLATION                                                                                    IMP ALL
------------------------- ---------- --------- --- - --- ---------------------------------------------------------------------------------------------------- --- ---
APEX_230100                      107 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO
FLOWS_FILES                      108 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO
APEX_PUBLIC_USER                 109 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO
APEX_LISTENER                    113 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO
APEX_REST_PUBLIC_USER            114 19-JUL-23 NO  Y NO  USING_NLS_COMP                                                                                       NO  NO





--Unlock public user

SYS> ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK IDENTIFIED BY oracle123;
SYS> ALTER USER APEX_LISTENER ACCOUNT UNLOCK IDENTIFIED BY oracle123;
SYS> ALTER USER APEX_REST_PUBLIC_USER ACCOUNT UNLOCK IDENTIFIED BY oracle123;
SYS> exit
*/

--step 4 download Tomcat
 --step 4.1
[oracle@apexserver ~]$ wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
/*
--2023-07-19 08:27:02--  https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
Resolving dlcdn.apache.org (dlcdn.apache.org)... 151.101.2.132, 2a04:4e42::644
Connecting to dlcdn.apache.org (dlcdn.apache.org)|151.101.2.132|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 11684406 (11M) [application/x-gzip]
Saving to: ‘apache-tomcat-9.0.78.tar.gz’

100%[===============================================================================================================================================>] 11,684,406  15.9MB/s   in 0.7s

2023-07-19 08:27:03 (15.9 MB/s) - ‘apache-tomcat-9.0.78.tar.gz’ saved [11684406/11684406]
*/
--step 4.2
[oracle@apexserver ~]$ tar -zxvf apache-tomcat-9.0.78.tar.gz -C /u01/app/oracle/tomcat/
--step 4.3
[oracle@apexserver ]# cd /u01/app/oracle/tomcat/apache-tomcat-9.0.76/bin
[oracle@apexserver bin]# ./startup.sh
/*
Using CATALINA_BASE:   /u01/app/oracle/apache-tomcat-10.1.10
Using CATALINA_HOME:   /u01/app/oracle/apache-tomcat-10.1.10
Using CATALINA_TMPDIR: /u01/app/oracle/apache-tomcat-10.1.10/temp
Using JRE_HOME:        /u01/app/oracle/java/jdk-17.0.7
Using CLASSPATH:       /u01/app/oracle/apache-tomcat-10.1.10/bin/bootstrap.jar:/u01/app/oracle/apache-tomcat-10.1.10/bin/tomcat-juli.jar
Using CATALINA_OPTS:
Tomcat started.

Tomcat started.
*/
--step 4.4
[oracle@apexserver bin]$ ./shutdown.sh
/*
Using CATALINA_BASE:   /u01/app/oracle/tomcat/apache-tomcat-9.0.78
Using CATALINA_HOME:   /u01/app/oracle/tomcat/apache-tomcat-9.0.78
Using CATALINA_TMPDIR: /u01/app/oracle/tomcat/apache-tomcat-9.0.78/temp
Using JRE_HOME:        /u01/app/oracle/java/jdk-17.0.7
Using CLASSPATH:       /u01/app/oracle/tomcat/apache-tomcat-9.0.78/bin/bootstrap.jar:/u01/app/oracle/tomcat/apache-tomcat-9.0.78/bin/tomcat-juli.jar
Using CATALINA_OPTS:
NOTE: Picked up JDK_JAVA_OPTIONS:  --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/java.util.concurrent=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED

*/
--step 4.4
[oracle@apexserver bin]# ps -ef | grep tomcat
/*
[oracle@apexserver ~]$ ps -ef | grep tomcat
oracle    5141     1  2 08:40 pts/1    00:00:05 /u01/app/oracle/java/jdk-17.0.7/bin/java -Djava.util.logging.config.file=/u01/app/oracle/tomcat/apache-tomcat-9.0.78/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Dconfig.url=/u01/app/oracle/ords/config -Xms2048M -Xmx4096M -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -Dignore.endorsed.dirs= -classpath /u01/app/oracle/tomcat/apache-tomcat-9.0.78/bin/bootstrap.jar:/u01/app/oracle/tomcat/apache-tomcat-9.0.78/bin/tomcat-juli.jar -Dcatalina.base=/u01/app/oracle/tomcat/apache-tomcat-9.0.78 -Dcatalina.home=/u01/app/oracle/tomcat/apache-tomcat-9.0.78 -Djava.io.tmpdir=/u01/app/oracle/tomcat/apache-tomcat-9.0.78/temp org.apache.catalina.startup.Bootstrap start
oracle    5350  4204  0 08:43 pts/1    00:00:00 grep --color=auto tomcat

*/


--step 5 configuration ORDS
--step 5.1 (download latest ords from oracle website)
[oracle@apexserver software]$ wget https://download.oracle.com/otn_software/java/ords/ords-latest.zip
/*
--2023-07-20 10:42:28--  https://download.oracle.com/otn_software/java/ords/ords-latest.zip
Resolving download.oracle.com (download.oracle.com)... 23.213.180.112
Connecting to download.oracle.com (download.oracle.com)|23.213.180.112|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 101343108 (97M) [application/zip]
Saving to: ‘ords-latest.zip’

100%[=========================================================================================================================>] 101,343,108 6.20MB/s   in 17s

2023-07-20 10:42:45 (5.78 MB/s) - ‘ords-latest.zip’ saved [101343108/101343108]

*/
--step 5.2  unzip ords 
[oracle@apexserver software]$ unzip ords-latest.zip -d /u01/app/oracle/ords/
--step 5.3
[oracle@apexserver oracle]$ $ORDS_HOME/bin/ords --config ${ORDS_CONFIG} install
/*
2[oracle@apexserver ords]$ $ORDS_HOME/bin/ords --config ${ORDS_CONFIG} install
2023-07-19T03:02:47.941Z INFO        Your configuration folder /u01/app/oracle/ords/config is located in ORDS product folder.  Oracle recommends to use a different configuration folder.

ORDS: Release 23.2 Production on Wed Jul 19 03:02:47 2023

Copyright (c) 2010, 2023, Oracle.

Configuration:
  /u01/app/oracle/ords/config

The configuration folder /u01/app/oracle/ords/config does not contain any configuration files.

Oracle REST Data Services - Interactive Install

  Enter a number to select the type of installation
    [1] Install or upgrade ORDS in the database only
    [2] Create or update a database pool and install/upgrade ORDS in the database
    [3] Create or update a database pool only
  Choose [2]:
Created folder /u01/app/oracle/ords/config
  Enter a number to select the database connection type to use
    [1] Basic (host name, port, service name)
    [2] TNS (TNS alias, TNS directory)
    [3] Custom database URL
  Choose [1]:
  Enter the database host name [localhost]: 192.168.120.42
  Enter the database listen port [1521]:
  Enter the database service name [orcl]: orclpdb
  Provide database user name with administrator privileges.
    Enter the administrator username: sys
  Enter the database password for SYS AS SYSDBA:
Connecting to database user: SYS AS SYSDBA url: jdbc:oracle:thin:@//192.168.120.42:1521/orclpdb

Retrieving information.
  Enter the default tablespace for ORDS_METADATA and ORDS_PUBLIC_USER [SYSAUX]:
  Enter the temporary tablespace for ORDS_METADATA and ORDS_PUBLIC_USER [TEMP]:
  Enter a number to select additional feature(s) to enable:
    [1] Database Actions  (Enables all features)
    [2] REST Enabled SQL and Database API
    [3] REST Enabled SQL
    [4] Database API
    [5] None
  Choose [1]:
  Enter a number to configure and start ORDS in standalone mode
    [1] Configure and start ORDS in standalone mode
    [2] Skip
  Choose [1]: 2
The setting named: db.connectionType was set to: basic in configuration: default
The setting named: db.hostname was set to: 192.168.120.42 in configuration: default
The setting named: db.port was set to: 1521 in configuration: default
The setting named: db.servicename was set to: orclpdb in configuration: default
The setting named: plsql.gateway.mode was set to: proxied in configuration: default
The setting named: db.username was set to: ORDS_PUBLIC_USER in configuration: default
The setting named: db.password was set to: ****** in configuration: default
The setting named: feature.sdw was set to: true in configuration: default
The global setting named: database.api.enabled was set to: true
The setting named: restEnabledSql.active was set to: true in configuration: default
The setting named: security.requestValidationFunction was set to: ords_util.authorize_plsql_gateway in configuration: default
2023-07-19T03:03:31.579Z INFO        Installing Oracle REST Data Services version 23.2.0.r1770931 in ORCLPDB
------------------------------------------------------------
Date       : 19 Jul 2023 03:03:31
Release    : Oracle REST Data Services 23.2.0.r1770931
Type       : ORDS Install
Database   : Oracle Database 19c Enterprise Edition
DB Version : 19.3.0.0.0
------------------------------------------------------------
Container Name: ORCLPDB
Executing scripts for core
------------------------------------------------------------

[*** script: ords_prereq_env.sql]

INFO: Checking prerequisites for Oracle REST Data Services

PL/SQL procedure successfully completed.


PL/SQL procedure successfully completed.


PL/SQL procedure successfully completed.

INFO: Prerequisites verified.

2023-07-19T03:03:33.321Z INFO        ... Verified database prerequisites
[*** script: ords_verify_tablespace.sql]

PL/SQL procedure successfully completed.

[*** script: ords_alter_session_script.sql]

PL/SQL procedure successfully completed.

[*** script: ords_create_rest_users.sql]

PL/SQL procedure successfully completed.

2023-07-19T03:03:34.286Z INFO        ... Created Oracle REST Data Services proxy user
[*** script: ords_alter_session_script.sql]

PL/SQL procedure successfully completed.

[*** script: ords_create_schema.sql]
INFO: Creating schema for Oracle REST Data Services

PL/SQL procedure successfully completed.

INFO: Created schema ORDS_METADATA
2023-07-19T03:03:35.057Z INFO        ... Created Oracle REST Data Services schema
[*** script: ords_grant_privs.sql]
INFO: Grant object and system privileges to ORDS owner
GRANT EXECUTE ON SYS.DBMS_NETWORK_ACL_ADMIN TO "ORDS_METADATA"
GRANT READ ON SYS.DBA_OBJECTS TO "ORDS_METADATA"
GRANT READ ON SYS.DBA_ROLE_PRIVS TO "ORDS_METADATA"
GRANT READ ON SYS.DBA_TAB_COLUMNS TO "ORDS_METADATA"
GRANT READ ON SYS.DBA_USERS TO "ORDS_METADATA"
GRANT READ ON SYS.DBA_NETWORK_ACL_PRIVILEGES TO "ORDS_METADATA"
GRANT READ ON SYS.DBA_NETWORK_ACLS TO "ORDS_METADATA"
GRANT READ ON SYS.DBA_REGISTRY TO "ORDS_METADATA"


PL/SQL procedure successfully completed.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.

INFO: Completed granting object and system privileges
2023-07-19T03:03:35.539Z INFO        ... Granted privileges to Oracle REST Data Services
[*** script: ords_alter_session_metadata.sql]

Session altered.

[*** script: ords_validate.sql]

Procedure VALIDATE_ORDS compiled

[*** script: ords_database_objects.sql]

Table CFG_PLSQL_GATEWAYS created.


Comment created.


Comment created.


Comment created.


INDEX CFG_PLSQL_GATEWAYS_IDX1 created.


INDEX CFG_PLSQL_GATEWAYS_IDX2 created.


Table CFG_PLSQL_GATEWAYS altered.


Table OAUTH_APPROVAL_PRIVS created.


INDEX OAUTH_APP_PRIVS_UNIQUE1 created.


Index OAUTH_APP_PRIVS_IDX1 created.


Index OAUTH_APP_PRIVS_IDX2 created.


Table OAUTH_APPROVAL_PRIVS altered.


Table OAUTH_APPROVALS created.


Table OAUTH_APPROVALS altered.


Comment created.


Comment created.


Comment created.


INDEX OAUTH_APPROVALS_UNIQUE1 created.


Index OAUTH_APPROVALS_IDX1 created.


Index OAUTH_APPROVALS_IDX2 created.


Index OAUTH_APPROVALS_IDX3 created.


Table OAUTH_APPROVALS altered.


Table OAUTH_CLIENT_PRIVILEGES created.


INDEX OAUTH_CLIENT_PRIVS_UNIQ1 created.


Index OAUTH_CLIENT_PRIVS_IDX1 created.


Index OAUTH_CLIENT_PRIVS_IDX2 created.


Table OAUTH_CLIENT_PRIVILEGES altered.


Table OAUTH_CLIENT_ROLES created.


Table OAUTH_CLIENT_ROLES altered.


Table OAUTH_CLIENTS created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX OAUTH_CLIENTS_UNIQUE1 created.


INDEX OAUTH_CLIENTS_UNIQUE2 created.


Index OAUTH_CLIENTS_IDX1 created.


Table OAUTH_CLIENTS altered.


Table OAUTH_CLIENTS altered.


Table OAUTH_CLIENTS altered.


Table OAUTH_PENDING_APPROVALS created.


Comment created.


Comment created.


Index OAUTH_PEND_APPRV_IDX1 created.


Index OAUTH_PEND_APPRV_IDX2 created.


Index OAUTH_PEND_APPRV_IDX3 created.


Table OAUTH_PENDING_APPROVALS altered.


Table OAUTH_PENDING_APPROVALS altered.


Table OAUTH_SESSIONS created.


Comment created.


INDEX OAUTH_USER_SESS_IDX1 created.


Index OAUTH_USER_SESS_IDX4 created.


Table OAUTH_SESSIONS altered.


Table ORDS_HANDLERS created.


Table ORDS_HANDLERS altered.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX ORDS_HANDLERS_UNIQUE1 created.


Index ORDS_HANDLERS_IDX2 created.


Index ORDS_HANDLERS_IDX3 created.


Table ORDS_HANDLERS altered.


Table ORDS_MODULES created.


Table ORDS_MODULES altered.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX ORDS_MODULES_UNIQUE1 created.


Table ORDS_MODULES altered.


Table ORDS_MODULES altered.


Table ORDS_MODULES altered.


Table ORDS_OBJECTS created.


Table ORDS_OBJECTS altered.


Table ORDS_OBJECTS altered.


Table ORDS_OBJECTS altered.


Table ORDS_OBJECTS altered.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX ORDS_OBJECTS_PK created.


INDEX ORDS_OBJECTS_ALIAS_UN created.


Index ORDS_OBJECTS_UOS_IDX created.


Table ORDS_OBJECTS altered.


Table ORDS_PARAMETERS created.


Table ORDS_PARAMETERS altered.


Table ORDS_PARAMETERS altered.


Table ORDS_PARAMETERS altered.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX ORDS_PARAMS_UNIQUE1 created.


INDEX ORDS_PARAMS_UNIQUE2 created.


Index ORDS_PARAMS_IDX1 created.


Index ORDS_PARAMS_IDX2 created.


Table ORDS_PARAMETERS altered.


Table ORDS_PARAMETERS altered.


Table ORDS_PARAMETERS altered.


Table ORDS_PARAMETERS altered.


Table ORDS_PARAMETERS altered.


Table ORDS_PROP_FACTS created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX ORDS_PROP_FACTS_UNQ created.


Index ORDS_PROP_FACTS_IDX created.


Index ORDS_PROP_FACTS_IDX2 created.


Table ORDS_PROP_FACTS altered.


Table ORDS_PROP_FACTS altered.


Table ORDS_PROP_FACTS altered.


Table ORDS_PROP_VALUES created.


Comment created.


Comment created.


Comment created.


Index ORDS_PROP_VALUES_IDX created.


Index ORDS_PROP_VALUES_IDX2 created.


Table ORDS_PROP_VALUES altered.


Table ORDS_SCHEMA_REQUESTS created.


Index ORDS_SCHEMA_REQUESTS_IDX1 created.


Index ORDS_SCHEMA_REQUESTS_IDX2 created.


Index ORDS_SCHEMA_REQUESTS_IDX3 created.


Table ORDS_SCHEMA_REQUESTS altered.


Table ORDS_SCHEMA_REQUESTS altered.


Table ORDS_SCHEMA_REQUESTS_ROLES created.


Index ORDS_SCHEMA_REQUESTS_ROLES_IDX created.


Table ORDS_SCHEMA_REQUESTS_ROLES altered.


Table ORDS_SCHEMA_VERSION created.


Comment created.


Comment created.


Comment created.


Table ORDS_SCHEMA_VERSION altered.


Table ORDS_SCHEMAS created.


Table ORDS_SCHEMAS altered.


Table ORDS_SCHEMAS altered.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX ORDS_SCHEMAS_PARSING created.


Table ORDS_SCHEMAS altered.


Table ORDS_TEMPLATES created.


Table ORDS_TEMPLATES altered.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX ORDS_TEMPLATES_UNIQUE1 created.


Index ORDS_TEMPLATES_IDX1 created.


Index ORDS_TEMPLATES_IDX2 created.


Table ORDS_TEMPLATES altered.


Table ORDS_TEMPLATES altered.


Table ORDS_TEMPLATES altered.


Table ORDS_TEMPLATES altered.


Table ORDS_URL_MAPPINGS created.


Table ORDS_URL_MAPPINGS altered.


Table ORDS_URL_MAPPINGS altered.


Table ORDS_URL_MAPPINGS altered.


Table ORDS_WORKSPACE_SCHEMAS created.


Table ORDS_WORKSPACE_SCHEMAS altered.


Table ORDS_WORKSPACE_SCHEMAS altered.


Table SEC_AUTHENTICATORS created.


Table SEC_AUTHENTICATORS altered.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX SEC_AUTHS_UNQ_NAME created.


INDEX SEC_AUTHS_UNQ_PROVIDER created.


Table SEC_AUTHENTICATORS altered.


Table SEC_KEYS created.


Table SEC_KEYS altered.


Table SEC_OBJECT_ALLOW_LIST created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX SEC_OBJECT_ALLOW_LIST_UNIQUE1 created.


Table SEC_OBJECT_ALLOW_LIST altered.


Table SEC_OBJECT_ALLOW_LIST altered.


Table SEC_ORIGINS_ALLOWED_MODULES created.


Table SEC_ORIGINS_ALLOWED_MODULES altered.


Table SEC_ORIGINS_ALLOWED_MODULES altered.


Table SEC_PRIVILEGE_AUTHS created.


INDEX PRIVILEGE_AUTHS_UNIQUE1 created.


Table SEC_PRIVILEGE_AUTHS altered.


Table SEC_PRIVILEGE_MAPPINGS created.


Table SEC_PRIVILEGE_MAPPINGS altered.


Table SEC_PRIVILEGE_MAPPINGS altered.


Table SEC_PRIVILEGE_MODULES created.


Table SEC_PRIVILEGE_MODULES altered.


Table SEC_PRIVILEGE_MODULES altered.


Table SEC_PRIVILEGE_ROLES created.


INDEX PRIVILEGE_ROLES_UNIQUE1 created.


Table SEC_PRIVILEGE_ROLES altered.


Table SEC_PRIVILEGES created.


Comment created.


Comment created.


Comment created.


Comment created.


Comment created.


INDEX PRIVILEGES_UNQ_NAME created.


Table SEC_PRIVILEGES altered.


Table SEC_ROLE_MAPPINGS created.


INDEX ROLE_MAPPINGS_UNQ_PATTERN created.


Table SEC_ROLE_MAPPINGS altered.


Table SEC_ROLES created.


INDEX ROLES_UNQ_NAME created.


Table SEC_ROLES altered.


Table SEC_SESSIONS created.


Table SEC_SESSIONS altered.


Table SEC_SESSIONS altered.


Table SEC_SESSIONS altered.


Table SEC_AUTHENTICATORS altered.


Table OAUTH_APPROVAL_PRIVS altered.


Table OAUTH_APPROVAL_PRIVS altered.


Table OAUTH_APPROVAL_PRIVS altered.


Table OAUTH_APPROVALS altered.


Table OAUTH_APPROVALS altered.


Table OAUTH_CLIENT_PRIVILEGES altered.


Table OAUTH_CLIENT_PRIVILEGES altered.


Table OAUTH_CLIENT_PRIVILEGES altered.


Table OAUTH_CLIENT_ROLES altered.


Table OAUTH_CLIENT_ROLES altered.


Table OAUTH_CLIENT_ROLES altered.


Table OAUTH_CLIENTS altered.


Table OAUTH_PENDING_APPROVALS altered.


Table OAUTH_PENDING_APPROVALS altered.


Table OAUTH_SESSIONS altered.


Table OAUTH_SESSIONS altered.


Table OAUTH_SESSIONS altered.


Table ORDS_HANDLERS altered.


Table ORDS_HANDLERS altered.


Table ORDS_MODULES altered.


Table ORDS_OBJECTS altered.


Table ORDS_PARAMETERS altered.


Table ORDS_PARAMETERS altered.


Table ORDS_PROP_VALUES altered.


Table ORDS_PROP_VALUES altered.


Table ORDS_SCHEMA_REQUESTS_ROLES altered.


Table ORDS_SCHEMAS altered.


Table ORDS_TEMPLATES altered.


Table ORDS_TEMPLATES altered.


Table ORDS_WORKSPACE_SCHEMAS altered.


Table SEC_PRIVILEGE_AUTHS altered.


Table SEC_PRIVILEGE_AUTHS altered.


Table SEC_PRIVILEGE_AUTHS altered.


Table SEC_PRIVILEGE_ROLES altered.


Table SEC_PRIVILEGE_ROLES altered.


Table SEC_PRIVILEGE_ROLES altered.


Table SEC_PRIVILEGES altered.


Table SEC_ROLE_MAPPINGS altered.


Table SEC_ROLE_MAPPINGS altered.


Table SEC_ROLES altered.


Table SEC_KEYS altered.


Table SEC_ORIGINS_ALLOWED_MODULES altered.


Table SEC_PRIVILEGE_MAPPINGS altered.


Table SEC_PRIVILEGE_MAPPINGS altered.


Table SEC_PRIVILEGE_MODULES altered.


Table SEC_PRIVILEGE_MODULES altered.


Table SEC_PRIVILEGE_MODULES altered.


Table SEC_SESSIONS altered.


View DBA_ORDS_PROP_DB_VALUES created.


View DBA_ORDS_PROP_FACTS created.


View DBA_ORDS_PROP_SCHEMA_VALUES created.


View DBA_ORDS_SCHEMAS created.


View DBA_ORDS_URL_MAPPINGS created.


View DBA_PLSQL_GATEWAY_ALLOW_LIST created.


View ORDS_CLIENT_ROLES created.


View ORDS_MODULE_SERVICES created.


View ORDS_PRIVILEGE_MAPPINGS created.


View ORDS_REPVERSION created.


View ORDS_VERSION created.


View PLSQL_GATEWAY_ALLOW_LIST created.


View PLSQL_GATEWAY_CONFIG created.


View POOL_CONFIG created.


View USER_ORDS_APPROVALS created.


View USER_ORDS_CLIENT_PRIVILEGES created.


View USER_ORDS_CLIENT_ROLES created.


View USER_ORDS_CLIENTS created.


View USER_ORDS_ENABLED_OBJECTS created.


View USER_ORDS_HANDLERS created.


View USER_ORDS_MODULES created.


View USER_ORDS_OBJ_MEMBERS created.


View USER_ORDS_OBJECTS created.


View USER_ORDS_PARAMETERS created.


View USER_ORDS_PENDING_APPROVALS created.


View USER_ORDS_PRIVILEGE_MAPPINGS created.


View USER_ORDS_PRIVILEGES created.


View USER_ORDS_PRIVILEGE_MODULES created.


View USER_ORDS_ROLES created.


View USER_ORDS_PRIVILEGE_ROLES created.


View USER_ORDS_PROPERTIES created.


View USER_ORDS_SCHEMAS created.


View USER_ORDS_SERVICES created.


View USER_ORDS_TEMPLATES created.

2023-07-19T03:03:37.832Z INFO        ... Created Oracle REST Data Services database objects
[*** script: ords_triggers.sql]

Sequence ORDS_ID_SEQ created.


Trigger ORDS_SCHEMA_REQUESTS_ROLES_TRG compiled


Trigger ORDS_SCHEMA_REQUESTS_TRG compiled


Trigger OAUTH_APPROVALS_TRG compiled


Trigger OAUTH_APPROVAL_PRIVS_TRG compiled


Trigger OAUTH_CLIENTS_TRG compiled


Trigger OAUTH_CLIENT_PRIVILEGES_TRG compiled


Trigger OAUTH_PENDING_APPROVALS_TRG compiled


Trigger OAUTH_SESSIONS_TRG compiled


Trigger ORDS_HANDLERS_TRG compiled


Trigger ORDS_MODULES_TRG compiled


Trigger ORDS_PARAMETERS_TRG compiled


Trigger ORDS_SCHEMAS_TRG compiled


Trigger ORDS_OBJECTS_TRG compiled


Trigger ORDS_TEMPLATES_TRG compiled


Trigger ORDS_URL_MAPPINGS_TRG compiled


Trigger SEC_AUTHENTICATORS_TRG compiled


Trigger SEC_ROLES_TRG compiled


Trigger SEC_PRIVILEGES_TRG compiled


Trigger SEC_ROLE_MAPPINGS_TRG compiled


Trigger SEC_PRIVILEGE_AUTHS_TRG compiled


Trigger SEC_PRIVILEGE_ROLES_TRG compiled


Trigger SEC_PRIVILEGE_MODULES_TRG compiled


Trigger SEC_SESSIONS_TRG compiled


Trigger SEC_KEYS_TRG compiled


Trigger ORDS_WORKSPACE_SCHEMAS_TRG compiled


Trigger SEC_ORIG_ALLOWED_MOD_TRG compiled


Trigger SEC_PRIV_MAPS_TRG compiled


Trigger OAUTH_CLIENT_ROLES_TRG compiled


Trigger ORDS_SCHEMA_VERSION_TRG compiled


Trigger CFG_PLSQL_GATEWAYS_TRG compiled


Trigger SEC_OBJECT_ALLOW_LIST_TRG compiled


Trigger ORDS_PROP_FACTS_TRG compiled


Trigger ORDS_PROP_VALUES_TRG compiled

[*** script: ords_types.sql]

Type T_ORDS_VCHAR_TAB compiled


Type T_ORDS_NUM_TAB compiled


Type T_ORDS_ATTR_SUPPORT_OBJ compiled


Type T_ORDS_ATTR_SUPPORT_TAB compiled


PL/SQL procedure successfully completed.


Type T_ORDS_METADATA_TYPE compiled


Type T_ORDS_METADATA_TYPE_LIST compiled


Type T_ORDS_MODULE_PRIVILEGE compiled


Type Body T_ORDS_MODULE_PRIVILEGE compiled


Type T_ORDS_MODULE_ORIGINS_ALLOWED compiled


Type Body T_ORDS_MODULE_ORIGINS_ALLOWED compiled


Type T_ORDS_PARAMETER compiled


Type Body T_ORDS_PARAMETER compiled


Type T_ORDS_PARAMETER_LIST compiled


Type T_ORDS_HANDLER compiled


Type Body T_ORDS_HANDLER compiled


Type T_ORDS_HANDLER_LIST compiled


Type T_ORDS_TEMPLATE compiled


Type Body T_ORDS_TEMPLATE compiled


Type T_ORDS_TEMPLATE_LIST compiled


Type T_ORDS_MODULE compiled


Type Body T_ORDS_MODULE compiled


Type T_ORDS_MODULE_LIST compiled

[*** script: ords_version.sql]

Session altered.


PL/SQL procedure successfully completed.

[*** script: ords_constants.pls]

Package ORDS_CONSTANTS compiled

[*** script: ords_util.pls]

Package ORDS_UTIL compiled

[*** script: ords.pls]

Package ORDS compiled

[*** script: ords_internal.pls]

Package ORDS_INTERNAL compiled

[*** script: ords_security.pls]

Package ORDS_SECURITY compiled

[*** script: ords_services_internal.pls]

Package ORDS_SERVICES_INTERNAL compiled

[*** script: ords_services.pls]

Package ORDS_SERVICES compiled

[*** script: ords_oper.pls]

Package ORDS_OPER compiled

[*** script: oauth_internal.pls]

Package OAUTH_INTERNAL compiled

[*** script: oauth.pls]

Package OAUTH compiled

[*** script: ords_export.pls]

Package ORDS_EXPORT compiled

[*** script: ords_admin_internal.pls]

Package ORDS_ADMIN_INTERNAL compiled

[*** script: ords_admin.pls]

Package ORDS_ADMIN compiled

[*** script: ords_self_service_schema.pls]

Package ORDS_SELF_SERVICE_SCHEMA compiled

[*** script: ords_util.plb]

Package Body ORDS_UTIL compiled

[*** script: ords_internal.plb]

Package Body ORDS_INTERNAL compiled

[*** script: ords_security.plb]

Package Body ORDS_SECURITY compiled

[*** script: ords_services_internal.plb]

Package Body ORDS_SERVICES_INTERNAL compiled

[*** script: ords_services.plb]

Package Body ORDS_SERVICES compiled

[*** script: ords.plb]

Package Body ORDS compiled

[*** script: ords_oper.plb]

Package Body ORDS_OPER compiled

[*** script: oauth_internal.plb]

Package Body OAUTH_INTERNAL compiled

[*** script: oauth.plb]

Package Body OAUTH compiled

[*** script: ords_export.plb]

Package Body ORDS_EXPORT compiled

[*** script: ords_admin_internal.plb]

Package Body ORDS_ADMIN_INTERNAL compiled

[*** script: ords_admin.plb]

Package Body ORDS_ADMIN compiled

[*** script: ords_self_service_schema.plb]

Package Body ORDS_SELF_SERVICE_SCHEMA compiled

[*** script: ords_database_roles.sql]

PL/SQL procedure successfully completed.

[*** script: ords_pub_synonyms_grants.sql]

PL/SQL procedure successfully completed.


PL/SQL procedure successfully completed.


Grant succeeded.


SYNONYM USER_ORDS_REPOVERSIONS created.


PL/SQL procedure successfully completed.


PL/SQL procedure successfully completed.


PL/SQL procedure successfully completed.

[*** script: ords_schema_mapping.sql]
INFO: Configuring ORDS_PUBLIC_USER to map APEX Workspaces and ORDS schemas

Session altered.

Configuring APEX and ORDS schemas for url mapping
Made APEX_PUBLIC_USER proxiable from ORDS_PUBLIC_USER
Made APEX_REST_PUBLIC_USER proxiable from ORDS_PUBLIC_USER
APEX_POOL_CONFIG Synonym exists
Created ORDS_METADATA.APEX_WWV_FLOW_POOL_CONFIG as view over
APEX_230100.WWV_FLOW_POOL_CONFIG


PL/SQL procedure successfully completed.

INFO: Completed configuring ORDS_PUBLIC_USER to map APEX Workspaces and ORDS Schemas

Session altered.

[*** script: ords_app_contexts.sql]

PL/SQL procedure successfully completed.

[*** script: ords_seed.sql]

PL/SQL procedure successfully completed.


PL/SQL procedure successfully completed.

[*** script: ords_verify_install.sql]

Session altered.

INFO: 08:48:40 Validating objects for Oracle REST Data Services.
VALIDATION: 08:48:40 Starting validation for schema: ORDS_METADATA
VALIDATION: 08:48:40 Validating objects
VALIDATION: 08:48:40 Validating roles granted to ORDS_METADATA and
ORDS_PUBLIC_USER
VALIDATION: 08:48:40 Validating ORDS Public Synonyms
VALIDATION: 08:48:41 Total objects: 302, invalid objects: 0, missing objects: 0
VALIDATION: 08:48:41     95  INDEX
VALIDATION: 08:48:41      3  LOB
VALIDATION: 08:48:41     14  PACKAGE
VALIDATION: 08:48:41     13  PACKAGE BODY
VALIDATION: 08:48:41      1  PROCEDURE
VALIDATION: 08:48:41     51  PUBLIC SYNONYM
VALIDATION: 08:48:41      1  SEQUENCE
VALIDATION: 08:48:41     33  TABLE
VALIDATION: 08:48:41     33  TRIGGER
VALIDATION: 08:48:41     16  TYPE
VALIDATION: 08:48:41      6  TYPE BODY
VALIDATION: 08:48:41     36  VIEW
VALIDATION: 08:48:41 Validation completed.
INFO: 08:48:41 Completed validation for Oracle REST Data Services.


PL/SQL procedure successfully completed.


Commit complete.

[*** script: ords_version.sql]

Session altered.


PL/SQL procedure successfully completed.

------------------------------------------------------------
Container Name: ORCLPDB
Executing scripts for datamodel
------------------------------------------------------------

[*** script: ords_alter_session_script.sql]

PL/SQL procedure successfully completed.

[*** script: ords_alter_session_metadata.sql]

Session altered.

[*** script: dm_grant_privs.sql]
INFO: Grant object and system privileges to ORDS owner for datamodel team

Grant succeeded.

INFO: Completed granting object and system privileges for datamodel team
[*** script: dm_types.sql]

Type DM_VARCHAR_TABLE compiled


Type DM_DDL_DESC compiled


Type DM_DDL_ROW compiled


Type DM_DDL_TAB compiled

[*** script: osddm_dbms_md_ddl.pls]

Package OSDDM_DBMS_MD_DDL compiled

[*** script: osddm_dbms_md_ddl.plb]

Package Body OSDDM_DBMS_MD_DDL compiled

[*** script: dm_grants_synonyms.sql]

PL/SQL procedure successfully completed.

[*** script: ords_verify_install.sql]

Session altered.

INFO: 08:48:41 Validating objects for Oracle REST Data Services.
VALIDATION: 08:48:41 Starting validation for schema: ORDS_METADATA
VALIDATION: 08:48:41 Validating objects
VALIDATION: 08:48:41 Validating roles granted to ORDS_METADATA and
ORDS_PUBLIC_USER
VALIDATION: 08:48:41 Validating ORDS Public Synonyms
VALIDATION: 08:48:41 Total objects: 309, invalid objects: 0, missing objects: 0
VALIDATION: 08:48:41     95  INDEX
VALIDATION: 08:48:41      3  LOB
VALIDATION: 08:48:41     15  PACKAGE
VALIDATION: 08:48:41     14  PACKAGE BODY
VALIDATION: 08:48:41      1  PROCEDURE
VALIDATION: 08:48:41     52  PUBLIC SYNONYM
VALIDATION: 08:48:41      1  SEQUENCE
VALIDATION: 08:48:41     33  TABLE
VALIDATION: 08:48:41     33  TRIGGER
VALIDATION: 08:48:41     20  TYPE
VALIDATION: 08:48:41      6  TYPE BODY
VALIDATION: 08:48:41     36  VIEW
VALIDATION: 08:48:41 Validation completed.
INFO: 08:48:41 Completed validation for Oracle REST Data Services.


PL/SQL procedure successfully completed.


Commit complete.

------------------------------------------------------------
Container Name: ORCLPDB
Executing scripts for scheduler
------------------------------------------------------------

[*** script: ords_alter_session_script.sql]

PL/SQL procedure successfully completed.

[*** script: ords_alter_session_metadata.sql]

Session altered.

[*** script: sch_grant_privs.sql]
INFO: Grant object and system privileges to ORDS owner for scheduler team
INFO: Completed granting object and system privileges for scheduler team
[*** script: ords_sdw_scheduler.pls]

Package ORDS_SDW_SCHEDULER compiled

[*** script: ords_sdw_sched_jobs.pls]

Package ORDS_SDW_SCHED_JOBS compiled

[*** script: ords_sdw_sched_rprt.pls]

Package ORDS_SDW_SCHED_RPRT compiled

[*** script: ords_sdw_scheduler.plb]

Package Body ORDS_SDW_SCHEDULER compiled

[*** script: ords_sdw_sched_jobs.plb]

Package Body ORDS_SDW_SCHED_JOBS compiled

[*** script: ords_sdw_sched_rprt.plb]

Package Body ORDS_SDW_SCHED_RPRT compiled

[*** script: sch_grants_synonyms.sql]

PL/SQL procedure successfully completed.

[*** script: ords_verify_install.sql]

Session altered.

INFO: 08:48:43 Validating objects for Oracle REST Data Services.
VALIDATION: 08:48:43 Starting validation for schema: ORDS_METADATA
VALIDATION: 08:48:43 Validating objects
VALIDATION: 08:48:43 Validating roles granted to ORDS_METADATA and
ORDS_PUBLIC_USER
VALIDATION: 08:48:43 Validating ORDS Public Synonyms
VALIDATION: 08:48:43 Total objects: 318, invalid objects: 0, missing objects: 0
VALIDATION: 08:48:43     95  INDEX
VALIDATION: 08:48:43      3  LOB
VALIDATION: 08:48:43     18  PACKAGE
VALIDATION: 08:48:43     17  PACKAGE BODY
VALIDATION: 08:48:43      1  PROCEDURE
VALIDATION: 08:48:43     55  PUBLIC SYNONYM
VALIDATION: 08:48:43      1  SEQUENCE
VALIDATION: 08:48:43     33  TABLE
VALIDATION: 08:48:43     33  TRIGGER
VALIDATION: 08:48:43     20  TYPE
VALIDATION: 08:48:43      6  TYPE BODY
VALIDATION: 08:48:43     36  VIEW
VALIDATION: 08:48:43 Validation completed.
INFO: 08:48:43 Completed validation for Oracle REST Data Services.


PL/SQL procedure successfully completed.


Commit complete.

------------------------------------------------------------
Container Name: ORCLPDB
Executing scripts for mle_js
------------------------------------------------------------

[*** script: ords_alter_session_script.sql]

PL/SQL procedure successfully completed.

[*** script: ords_alter_session_metadata.sql]

Session altered.

[*** script: ords_sdw_mle_js.pls]

Package ORDS_SDW_MLE_JS compiled

[*** script: ords_sdw_mle_js.plb]

Package Body ORDS_SDW_MLE_JS compiled

[*** script: mle_js_grants_synonyms.sql]

PL/SQL procedure successfully completed.

[*** script: ords_verify_install.sql]

Session altered.

INFO: 08:48:43 Validating objects for Oracle REST Data Services.
VALIDATION: 08:48:43 Starting validation for schema: ORDS_METADATA
VALIDATION: 08:48:43 Validating objects
VALIDATION: 08:48:43 Validating roles granted to ORDS_METADATA and
ORDS_PUBLIC_USER
VALIDATION: 08:48:43 Validating ORDS Public Synonyms
VALIDATION: 08:48:43 Total objects: 321, invalid objects: 0, missing objects: 0
VALIDATION: 08:48:43     95  INDEX
VALIDATION: 08:48:43      3  LOB
VALIDATION: 08:48:43     19  PACKAGE
VALIDATION: 08:48:43     18  PACKAGE BODY
VALIDATION: 08:48:43      1  PROCEDURE
VALIDATION: 08:48:43     56  PUBLIC SYNONYM
VALIDATION: 08:48:43      1  SEQUENCE
VALIDATION: 08:48:43     33  TABLE
VALIDATION: 08:48:43     33  TRIGGER
VALIDATION: 08:48:43     20  TYPE
VALIDATION: 08:48:43      6  TYPE BODY
VALIDATION: 08:48:43     36  VIEW
VALIDATION: 08:48:43 Validation completed.
INFO: 08:48:43 Completed validation for Oracle REST Data Services.


PL/SQL procedure successfully completed.


Commit complete.

------------------------------------------------------------
Container Name: ORCLPDB
Executing scripts for apex
------------------------------------------------------------

[*** script: ords_alter_session_script.sql]

PL/SQL procedure successfully completed.

[*** script: ords_alter_session_metadata.sql]

Session altered.

[*** script: ords_migrate.pls]

Package ORDS_MIGRATE compiled

[*** script: ords_apex_repair_internal.pls]

Package ORDS_APEX_REPAIR_INTERNAL compiled

[*** script: ords_apex_repair.pls]

Package ORDS_APEX_REPAIR compiled

[*** script: ords_apex_sso.pls]

Package ORDS_APEX_SSO compiled

[*** script: ords_migrate.plb]

Package Body ORDS_MIGRATE compiled

[*** script: ords_apex_repair_internal.plb]

Package Body ORDS_APEX_REPAIR_INTERNAL compiled

[*** script: ords_apex_repair.plb]

Package Body ORDS_APEX_REPAIR compiled

[*** script: ords_apex_sso.plb]

Package Body ORDS_APEX_SSO compiled

[*** script: ords_migrate_pub_synonym.sql]

Synonym ORDS_MIGRATE created.

[*** script: ords_migrate_grant_priv.sql]
INFO: Verify if Application Express exists to setup the migration privileges for
ORDS.
INFO: Completed setting up the APEX REST migration privileges for ORDS.


PL/SQL procedure successfully completed.


Session altered.

[*** script: ords_apex_repair_pub_synonym.sql]

Synonym ORDS_APEX_REPAIR created.

[*** script: ords_apex_grants.sql]
APEX schema APEX_230100


PL/SQL procedure successfully completed.

[*** script: allow_apex_entry_points.sql]
Found APEX 23.1.0. Migrating APEX entry points to ORDS PL/SQL Procedure Gateway
Allow List


PL/SQL procedure successfully completed.

[*** script: ords_verify_install.sql]

Session altered.

INFO: 08:48:44 Validating objects for Oracle REST Data Services.
VALIDATION: 08:48:44 Starting validation for schema: ORDS_METADATA
VALIDATION: 08:48:44 Validating objects
VALIDATION: 08:48:44 Validating roles granted to ORDS_METADATA and
ORDS_PUBLIC_USER
VALIDATION: 08:48:44 Validating ORDS Public Synonyms
VALIDATION: 08:48:45 Total objects: 331, invalid objects: 0, missing objects: 0
VALIDATION: 08:48:45     95  INDEX
VALIDATION: 08:48:45      3  LOB
VALIDATION: 08:48:45     23  PACKAGE
VALIDATION: 08:48:45     22  PACKAGE BODY
VALIDATION: 08:48:45      1  PROCEDURE
VALIDATION: 08:48:45     58  PUBLIC SYNONYM
VALIDATION: 08:48:45      1  SEQUENCE
VALIDATION: 08:48:45     33  TABLE
VALIDATION: 08:48:45     33  TRIGGER
VALIDATION: 08:48:45     20  TYPE
VALIDATION: 08:48:45      6  TYPE BODY
VALIDATION: 08:48:45     36  VIEW
VALIDATION: 08:48:45 Validation completed.
INFO: 08:48:45 Completed validation for Oracle REST Data Services.


PL/SQL procedure successfully completed.


Commit complete.

2023-07-19T03:03:46.418Z INFO        Completed installation for Oracle REST Data Services version 23.2.0.r1770931. Elapsed time: 00:00:14.791

[*** Info: Completed installation for Oracle REST Data Services version 23.2.0.r1770931. Elapsed time: 00:00:14.791
 ]
------------------------------------------------------------
Container Name: ORCLPDB
------------------------------------------------------------

[*** script: ords_configure_gateway.sql]
Configured PL/SQL Gateway user APEX_PUBLIC_USER to be proxiable from
ORDS_PUBLIC_USER


PL/SQL procedure successfully completed.

2023-07-19T03:03:46.475Z INFO        Completed configuring PL/SQL gateway user for Oracle REST Data Services version 23.2.0.r1770931. Elapsed time: 00:00:00.56

[*** Info: Completed configuring PL/SQL gateway user for Oracle REST Data Services version 23.2.0.r1770931. Elapsed time: 00:00:00.56


*/
--step 5.4  
[oracle@apexserver ]$ cd /u01/app/oracle/ords
[oracle@apexserver ]$ cp ords.war /u01/app/oracle/tomcat/apache-tomcat-9.0.76/webapps/
[oracle@apexserver apache-tomcat-9.0.76]$ cd /u01/app/oracle/tomcat/apache-tomcat-9.0.76/webapps
[oracle@apexserver apache-tomcat-9.0.76/webapps]$ mkdir i
[oracle@apexserver apache-tomcat-9.0.76]$ cd i
[oracle@apexserver apache-tomcat-9.0.76]$cp -r  /u01/app/oracle/apex/images/* .

--at final we go to web browser http://192.168.120.30:8080/ords/
type Workspace:INTERNAL
username:ADMIN
password:Nepal@#123
