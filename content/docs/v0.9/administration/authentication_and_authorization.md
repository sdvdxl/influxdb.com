---
title: Authentication and authorization
aliases:
  - /docs/v0.9/concepts/authentication.html
  - /docs/v0.9/concepts/authorization.html
---

This document covers setting up and managing authentication and authorization in InfluxDB.

[Authentication](../administration/authentication.html#authentication)

* [Set up authentication](../administration/authentication.html#set-up-authentication)
* [Authenticating requests](../administration/authentication.html#authenticating-requests)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Authenticate using the HTTP API](../administration/authentication.html#authenticate-using-the-http-api)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Authenticate using the CLI](../administration/authentication.html#authenticate-using-the-cli)  
	
[Authorization](../administration/authentication.html#authorization)

* [User types and their privileges](../administration/authentication.html#user-types-and-their-privileges)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Admin users](../administration/authentication.html#admin-users)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Non-admin users](../administration/authentication.html#non-admin-users)  
* [User management commands](../administration/authentication.html#user-management-commands)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Admin user management](../administration/authentication.html#admin-user-management)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`CREATE` a new admin user](../administration/authentication.html#create-a-new-admin-user)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`GRANT` administrative privileges to an existing user](../administration/authentication.html#grant-administrative-privileges-to-an-existing-user)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`REVOKE` administrative privileges from an admin user](../administration/authentication.html#revoke-administrative-privileges-from-an-admin-user)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`SHOW` all existing users and their admin status](../administration/authentication.html#show-all-existing-users-and-their-admin-status)    
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Non-admin user management](../administration/authentication.html#non-admin-user-management)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`CREATE` a new non-admin user](../administration/authentication.html#create-a-new-non-admin-user)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`GRANT` `READ`,`WRITE`, or `ALL` database privileges to an existing user](../administration/authentication.html#grant-read-write-or-all-database-privileges-to-an-existing-user)   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`REVOKE` `READ`,`WRITE`, or `ALL` database privileges from an existing user](../administration/authentication.html#revoke-read-write-or-all-database-privileges-from-an-existing-user)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`SHOW` a user's database privileges](../administration/authentication.html#show-a-user-s-database-privileges)  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[General admin and non-admin user management](../administration/authentication.html#show-a-user-s-database-privileges)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Re`SET` a user's password](../administration/authentication.html#re-set-a-user-s-password)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;□&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[`DROP` a user](../administration/authentication.html#drop-a-user)  

	
[Authentication and authorization HTTP errors](../administration/authentication.html#authentication-and-authorization-http-errors)


> **Note:** Authentication and authorization should not be relied upon to prevent access and protect data from malicious actors.  If additional security or compliance features are desired, InfluxDB should be run behind a third-party service.

## Authentication

InfluxDB's HTTP API and the command line interface (CLI), which connects to the database using the API, include simple, built-in authentication based on user credentials. When you enable authentication InfluxDB only executes HTTP requests that are sent with valid credentials. 

> **Note:** Authentication only occurs at the HTTP request scope. Plugins do not currently have the ability to authenticate requests and service endpoints (for example, Graphite, collectd, etc.) are not authenticated.

### Set up authentication
---
1. Enable authentication by setting the `auth-enabled` option to `true` in the `[http]` section of the configuration file:

    ```
[http]  
  enabled = true  
  bind-address = ":8086"  
 ✨auth-enabled = true ✨  
  log-enabled = true  
  write-tracing = false  
  pprof-enabled = false  
  https-enabled = false  
  https-certificate = "/etc/ssl/influxdb.pem"  
    ```
    
2. Restart the `influxd` process and direct it to the newly edited configuration file, for example direct the process to the file `/etc/influxdb/influxdb.conf`:  

    ```
    influxd -config '/etc/influxdb/influxdb.conf'
    ```
    
3. If you haven't created any users, create your first user. If no users exist, InfluxDB will **not** enforce authentication until you've created the first user, and InfluxDB will only accept the following query:

    ```sql
    CREATE USER <user_name> WITH PASSWORD <password> WITH ALL PRIVILEGES
    ```
	
	Note that the first user must be an [admin user](../administration/authentication.html#admin-users). See the section on [authorization](../administration/authentication.html#authorization) for the different user types, their privileges, and more on user management. 
	
Now InfluxDB will check user credentials on every request and will only process requests that have valid credentials for an existing user.

### Authenticating requests
---
#### Authenticate using the HTTP API
There are two options for authenticating with the HTTP API. 

* Authenticate with Basic Authentication as described in [RFC 2617, Section 2](http://tools.ietf.org/html/rfc2617) - this is the preferred method for providing user credentials.

    Example:

    ```sh
curl -G http://localhost:8086/query -u todd:influxdbforever --data-urlencode "q=SHOW DATABASES"
    ```

* Authenticate by providing query parameters in the URL. Set `u` as the username and `p` as the password. 

    Example:

    ```sh
curl -G http://localhost:8086/query --data-urlencode "u=todd" --data-urlencode "p=influxdbforever" --data-urlencode "q=SHOW DATABASES"
    ```

    Note that when authentication is disabled, InfluxDB never checks credentials and the password query parameter `p` is not redacted in the InfluxDB logs.
    
The queries in both examples assume that the user is an [admin user](../administration/authentication.html#admin-users). See the section on [authorization](../administration/authentication.html#authorization) for the different user types, their privileges, and more on user management. 

I don't think this is true, but someone else should check:

> **Note:** If you authenticate with both Basic Authentication **and** the URL query parameters, the user credentials specified in the query parameters take precedence.

#### Authenticate using the CLI
Set the `username` and `password` flags when you start the CLI:

```sh
influx -username todd -password influxdbforever
```

## Authorization
Authorization is only enforced once you've [enabled authentication](../administration/authentication.html#set-up-authentication). By default, authentication is disabled, all credentials are silently ignored, and all users have all privileges.

### User types and their privileges
---
#### Admin users
Admin users have `READ` and `WRITE` access to all databases and full access to the following administrative queries:

Database management:  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`CREATE` and `DROP` databases  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`DROP` series and measurements  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`CREATE`, `ALTER`, and `DROP` retention policies  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`CREATE` and `DROP` continuous queries  

See the [database management](link!) page for a complete discussion of the commands listed above.

User management:  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`CREATE` admin users and `GRANT`, `REVOKE`, and `SHOW` admin privileges  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`CREATE` non-admin users and `GRANT`, `REVOKE`, and `SHOW` database privileges  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Re`SET` user passwords  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`DROP` users 

See [below](../administration/authentication.html#user-management-commands) for a complete discussion of the user management commands.

#### Non-admin users
Non-admin users can have one of the following three privileges per database:  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`READ`  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`WRITE`  
&nbsp;&nbsp;&nbsp;◦&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ALL` (both `READ` and `WRITE` access)

`READ`, `WRITE`, and `ALL` privileges are controlled per user per database. A new non-admin user has no access to a given database until an admin user `GRANT`s them privileges on that database.

### User management commands
---
#### Admin user management
* ##### `CREATE` a new admin user:  

    ```sql
CREATE USER <username> WITH PASSWORD '<password>' WITH ALL PRIVILEGES
    ```

    CLI example:
    
    ```sh
> CREATE USER paul WITH PASSWORD 'timeseriesfordays' WITH ALL PRIVILEGES
>
    ```

* ##### `GRANT` administrative privileges to an existing user:

    ```sql
GRANT ALL PRIVILEGES TO <username>
    ```

    CLI example:
    
    ```sh
> GRANT ALL PRIVILEGES TO todd
>
    ```

* ##### `REVOKE` administrative privileges from an admin user:

    ```sql
REVOKE ALL PRIVILEGES FROM <username>
    ```

    CLI example:
    
    ```sh
> REVOKE ALL PRIVILEGES FROM todd
>
    ```

* ##### `SHOW` all existing users and their admin status:

    ```sql
SHOW USERS
    ```

    CLI example:

    ```sh
> SHOW USERS
user 	 admin
todd     false
paul     true
hermione false
dobby    false
    ```

#### Non-admin user management
* ##### `CREATE` a new non-admin user:

    ```sql
CREATE USER <username> WITH PASSWORD '<password>'
    ```
    
    CLI example:
    
    ```sh
> CREATE USER todd WITH PASSWORD 'influxdbforlife'
>
    ```
    > **Note:** The password string must be wrapped in single quotes. Do not include the single quotes when authenticating requests.
    
    > For passwords that include a single quote or a newline character, escape the single quote or newline character with a backslash both when creating the password and when authentication requests.

* ##### `GRANT` `READ`, `WRITE` or `ALL` database privileges to an existing user:

    ```sql
GRANT [READ,WRITE,ALL] ON <database_name> TO <username>
    ```

   CLI examples:
    
    `GRANT` `READ` access to `todd` on the `NOAA_water_database` database:
    
    ```sh
> GRANT READ ON NOAA_water_database TO todd
>
    ```

    `GRANT` `ALL` access to `todd` on the `NOAA_water_database` database:
    
    ```sh
> GRANT ALL ON NOAA_water_database TO todd
>
    ```
    
* ##### `REVOKE` `READ`, `WRITE`, or `ALL` database privileges from an existing user:

    ```sql
REVOKE [READ,WRITE,ALL] ON <database_name> FROM <username>
    ```

    CLI examples:

    `REVOKE` `ALL` privileges from `todd` on the `NOAA_water_database` database:
    
    ```sh
> REVOKE ALL ON NOAA_water_database FROM todd
>
    ```
    
    `REVOKE` `WRITE` privileges from `todd` on the `NOAA_water_database` database:

    ```sh
> REVOKE WRITE ON NOAA_water_database FROM todd
>
    ```

    >**Note:** If a user with `ALL` privileges has `WRITE` privileges revoked, they are left with `READ` privileges, and vice versa.

* ##### `SHOW` a user's database privileges: 

    ```sql
SHOW GRANTS FOR <user_name>
    ```

    CLI example:

    ```sh
> SHOW GRANTS FOR todd
database		            privilege
NOAA_water_database	        WRITE
another_database_name	    READ
yet_another_database_name   ALL PRIVILEGES
    ```

#### General admin and non-admin user management

* ##### Re`SET` a user's password:  

    ```sql
SET PASSWORD FOR <username> = '<password>'
    ```

    CLI example:
    
    ```sh
> SET PASSWORD FOR todd = 'influxdbforever'
>
    ```
    
    > **Note:** The password string must be wrapped in single quotes. Do not include the single quotes when authenticating requests.
    
    > For passwords that include a single quote or a newline character, escape the single quote or newline character with a backslash both when creating the password and when authentication requests.

* ##### `DROP` a user:

    ```sql
DROP USER <username>
    ```

    CLI example:
    
    ```sh
> DROP USER todd
>
    ```

## Authentication and authorization HTTP errors
Requests with invalid credentials and requests by unauthorized users yield the `HTTP 401 Unauthorized` response.
 



