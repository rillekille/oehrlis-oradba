# Unified Audit Scripts and Tools
<!-- markdownlint-configure-file { "MD013": { "tables": false } } -->
For easier analysis and evaluation of the local audit data, a number of scripts
and tools are available.

## Command Line based SQL Scripts

There are a bunch of audit specific scripts available within this git repository.

| Script                           | Purpose                                                                                                        |
|----------------------------------|----------------------------------------------------------------------------------------------------------------|
| as.sql                           | Provide information about the audit trails e.g. Standard, FGA and Unified Audit Trail                          |
| au_cleanup_audit_policies.sql    | Disable all audit policies and drop all policies not maintained by ORACLE                                      |
| au_config_audit.sql              | Initialize Audit environment. Create Tablespace, reorganize Audit tables and create jobs                       |
| au_create_audit_policies_loc.sql | Create custom local audit policies                                                                             |
| au_disable_audit_policies.sql    | Initialize Audit environment                                                                                   |
| au_enable_audit_policies_loc.sql | Enable custom local audit policies                                                                             |
| au_list_audit_policies.sql       | List local audit policies                                                                                      |
| aue_action.sql                   | Top unified audit events by action for current DBID                                                            |
| aue_client.sql                   | Top unified audit events by client_program_name for current DBID                                               |
| aue_dbid.sql                     | Top unified audit events by DBID                                                                               |
| aue_dbusername.sql               | Top unified audit events by dbusername for current DBID                                                        |
| aue_object_name.sql              | Top unified audit events by object_name for current DBID                                                       |
| aue_object_schema.sql            | Top unified audit events by object_schema for current DBID                                                     |
| aue_os_username.sql              | Top unified audit events by os_username for current DBID                                                       |
| aue_pol.sql                      | Top unified audit events by unified_audit_policies for current DBID                                            |
| aue_policy.sql                   | Top unified audit events by unified_audit_policies, dbusername, action for current DBID                        |
| aue_session_dbv.sql              | List of audit sessions for audit type Database Vault                                                           |
| aue_session_details.sql          | List entries of a particular audit session with unified_audit_policies                                         |
| aue_session_details2.sql         | List entries of a particular audit session with SQL_TEXT                                                       |
| aue_session_dp.sql               | List of audit sessions for audit type Datapump                                                                 |
| aue_session_fga.sql              | List of audit sessions for audit type FineGrainedAudit                                                         |
| aue_session_rman.sql             | List of audit sessions for audit type RMAN_AUDIT                                                               |
| aue_session_std.sql              | List of audit sessions for audit type Standard                                                                 |
| aue_sessions.sql                 | List of audit sessions for audit type any                                                                      |
| aue_userhost.sql                 | Top unified audit events by userhost for current DBID                                                          |
| aus.sql                          | Unified Audit trail storage usage                                                                              |
| ausap.sql                        | Generate statements to enable all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.  |
| auscap.sql                       | Generate statements to create all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.  |
| ausdap.sql                       | Generate statements to drop all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.    |
| ausnap.sql                       | Generate statements to disable all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES. |
| ausp.sql                         | Unified Audit trail storage usage purge statements                                                             |
| auss.sql                         | Unified Audit trail storage usage storage statements                                                           |
| auts.sql                         | Unified Audit trail table and partition size                                                                   |

## SQL Developer Reports

Predefined reports for Unified Audit Assessment available via [unified_audit_reports.xml](https://github.com/oehrlis/oradba/blob/b4bc6e713405e8836e21532b6e0cd4075a576848/sql/unified_audit_reports.xml)

The scripts are divided into the following categories.

- **Generic Audit**
- **Audit Configuration**
- **Audit Sessions**
- **Generate Statements**
- **Top Audit Events**

| Folder              | Report                                    | Purpose                                                                                                                     |
|---------------------|-------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| Generic             | Audit Events by Day                       | Chart with number of Audit events by days with a couple of subqueries for history, by hour or DB Info                       |
| Generic             | Audit Events by User                      | Chart with number of Audit events by user with a couple of subqueries for history, by hour or DB Info                       |
| Generic             | Audit Events by User                      | List of Audit Events by Users with a couple of subqueries for audit policies, actions, clients and Policy                   |
| Audit Configuration | Audit Storage Usage                       | Information about the Audit storage usage and configuration.                                                                |
| Audit Configuration | Clean Up Events                           | Displays the audit cleanup event history                                                                                    |
| Audit Configuration | Clean Up Jobs                             | Displays the currently configured audit trail purge jobs                                                                    |
| Audit Configuration | Configuration                             | List current audit configuration parameter                                                                                  |
| Audit Configuration | Last Archive Timestamp                    | Displays the last archive timestamps set for the audit trails                                                               |
| Audit Configuration | Unified Audit Policies                    | Display overview about unified audit policies based on the views AUDIT_UNIFIED_POLICIES and AUDIT_UNIFIED_ENABLED_POLICIES. |
| Audit Sessions      | Proxy Sessions                            | List information about proxy sessions for audit type Standard based on UNIFIED_AUDIT_TRAIL                                  |
| Audit Sessions      | Session by Audit Type Standard            | List information about sessions for audit type Standard based on UNIFIED_AUDIT_TRAIL                                        |
| Audit Sessions      | Session Details                           | List detail of a particular session                                                                                         |
| Audit Sessions      | Session Overview                          | Overview of standard audit session                                                                                          |
| Audit Sessions      | Sessions by any Audit Type                | List information about sessions any audit type based on UNIFIED_AUDIT_TRAIL                                                 |
| Audit Sessions      | Sessions by Audit Type Database Vault     | List information about sessions for audit type Database Vault based on UNIFIED_AUDIT_TRAIL                                  |
| Audit Sessions      | Sessions by Audit Type Datapump           | List information about sessions for audit type Datapump based on UNIFIED_AUDIT_TRAIL                                        |
| Audit Sessions      | Sessions by Audit Type Direct path API    | List information about sessions for audit type Direct path API based on UNIFIED_AUDIT_TRAIL                                 |
| Audit Sessions      | Sessions by Audit Type Fine Grained Audit | List information about sessions for audit type Fine Grained Audit based on UNIFIED_AUDIT_TRAIL                              |
| Audit Sessions      | Sessions by Audit Type Protocol           | List information about sessions for audit type Protocol based on UNIFIED_AUDIT_TRAIL                                        |
| Audit Sessions      | Sessions by Audit Type RMAN_AUDIT         | List information about sessions for audit type RMAN_AUDIT based on UNIFIED_AUDIT_TRAIL                                      |
| Generate Statements | Create all Audit Policy                   | Generate statements to create all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.               |
| Generate Statements | Disable all Audit Policy                  | Generate statements to disable all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES               |
| Generate Statements | Drop all Audit Policy                     | Generate statements to drop all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.                 |
| Generate Statements | Enable all Audit Policy                   | Generate statements to enable all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.               |
| Top Audit Events    | Top Audit Events by Action                | Top Audit Events by Action Name                                                                                             |
| Top Audit Events    | Top Audit Events by Application Context   | Top Audit Events by Application Context                                                                                     |
| Top Audit Events    | Top Audit Events by Audit Type            | Top Audit Events by Audit Type                                                                                              |
| Top Audit Events    | Top Audit Events by Client                | Top Audit Events by Client                                                                                                  |
| Top Audit Events    | Top Audit Events by Client Program name   | Top Audit Events by Client Program                                                                                          |
| Top Audit Events    | Top Audit Events by DBID                  | Top Audit Events by Database ID                                                                                             |
| Top Audit Events    | Top Audit Events by External User ID      | Top Audit Events by External User ID                                                                                        |
| Top Audit Events    | Top Audit Events by Global User ID        | Top Audit Events by Global User ID                                                                                          |
| Top Audit Events    | Top Audit Events by Object Name           | Top Audit Events by Object Name                                                                                             |
| Top Audit Events    | Top Audit Events by Object Schema         | Top Audit Events by Object Schema                                                                                           |
| Top Audit Events    | Top Audit Events by OS User               | Top Audit Events by OS User                                                                                                 |
| Top Audit Events    | Top Audit Events by Unified Policy        | Top Audit Events by Unified Audit Policy                                                                                    |
| Top Audit Events    | Top Audit Events by SQL Text              | Top Audit Events by SQL Text                                                                                                |
| Top Audit Events    | Top Audit Events by User                  | Top Audit Events by User                                                                                                    |
