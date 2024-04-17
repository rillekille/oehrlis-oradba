Easy Audit Data Analysis with SQL Developer Reports

A few days ago I wrote a blog post about my SQL Toolbox for simplified
Oracle Unified Audit data analysis. The scripts introduced are ideal for
analysing the data in the Unified Audit Trail ad hoc with SQL*Plus. Of course,
you can also use the scripts in SQL Developer or any other SQL tool for Oracle.
The scripts are quite convenient. Nevertheless, there are always cases where
you would like to fall back on predefined reports with drill-down options.
User Defined Reports in SQL Developer are a very convenient solution in this case.

List of current Reports

Predefined reports for Unified Audit Trail Assessment available as 
[unified_audit_reports.xml](https://github.com/oehrlis/oradba/blob/master/sql/unified_audit_reports.xml) in the GitHub repository oehrlis/oradba.

The reports are divided into the following categories for better organisation.

- **Generic Audit** Generic Reports to start analysing audit events.
- **Audit Configuration** Reports to display information about the audit configuration.
- **Audit Sessions** Reports to list and break down information on audit sessions.
- **Generate Statements** Reports/scripts for generating different types of SQL statements for maintenance and housekeeping
- **Top Audit Events** Reports listing the most important audit events, grouped by various attributes such as policies, users, action names, object names and more.

### Generic Audit

| Report                                      | Purpose                                                                                                                                |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Audit Events by Day                         | Chart with number of Audit events by days with a couple of subqueries for history, by hour or DB Info                                  |
| Audit Events by User                        | Chart with number of Audit events by user with a couple of subqueries for history, by hour or DB Info                                  |
| Audit Events by User                        | Show of Audit Events by Users with a couple of subqueries for audit policies, actions, clients and Policy                              |

### Audit Configuration

| Audit Storage Usage                         | Information about the Audit storage usage and configuration.                                                                           |
| Clean Up Events                             | Displays the audit cleanup event history                                                                                               |
| Clean Up Jobs                               | Displays the currently configured audit trail purge jobs                                                                               |
| Configuration                               | Show current audit configuration parameter                                                                                             |
| Last Archive Timestamp                      | Displays the last archive timestamps set for the audit trails                                                                          |
| Unified Audit Policies                      | Display overview about unified audit policies based on the views AUDIT_UNIFIED_POLICIES and AUDIT_UNIFIED_ENABLED_POLICIES.            |

### Audit Sessions

| Proxy Sessions                              | Show information about proxy sessions for audit type Standard based on UNIFIED_AUDIT_TRAIL                                             |
| Session by Audit Type Standard              | Show information about sessions for audit type Standard based on UNIFIED_AUDIT_TRAIL                                                   |
| Session Details                             | Show details of a particular session                                                                                                   |
| Session Overview                            | Overview of standard audit session                                                                                                     |
| Sessions by any Audit Type                  | Show information about sessions any audit type based on UNIFIED_AUDIT_TRAIL                                                            |
| Sessions by Audit Type Database Vault       | Show information about sessions for audit type Database Vault based on UNIFIED_AUDIT_TRAIL                                             |
| Sessions by Audit Type Datapump             | Show information about sessions for audit type Datapump based on UNIFIED_AUDIT_TRAIL                                                   |
| Sessions by Audit Type Direct path API      | Show information about sessions for audit type Direct path API based on UNIFIED_AUDIT_TRAIL                                            |
| Sessions by Audit Type Fine Grained Audit   | Show information about sessions for audit type Fine Grained Audit based on UNIFIED_AUDIT_TRAIL                                         |
| Sessions by Audit Type Protocol             | Show information about sessions for audit type Protocol based on UNIFIED_AUDIT_TRAIL                                                   |
| Sessions by Audit Type RMAN_AUDIT           | Show information about sessions for audit type RMAN_AUDIT based on UNIFIED_AUDIT_TRAIL                                                 |

### Generate Statements

| Create all Audit Policy                     | Generate statements to create all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES. Requires DBA privileges. |
| Disable all Audit Policy                    | Generate statements to disable all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.                         |
| Drop all Audit Policy                       | Generate statements to drop all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.                            |
| Enable all Audit Policy                     | Generate statements to enable all audit policies as they are currently set in AUDIT_UNIFIED_ENABLED_POLICIES.                          |

### Top Audit Events

| Top Audit Events by Action                  | Show top unified audit events by Action Name                                                                                           |
| Top Audit Events by Application Context     | Show top unified audit events by Application Context                                                                                   |
| Top Audit Events by Audit Type              | Show top unified audit events by Audit Type                                                                                            |
| Top Audit Events by Client                  | Show top unified audit events by Client                                                                                                |
| Top Audit Events by Client Program name     | Show top unified audit events by Client Program                                                                                        |
| Top Audit Events by DBID                    | Show top unified audit events by Database ID                                                                                           |
| Top Audit Events by External User ID        | Show top unified audit events by External User ID                                                                                      |
| Top Audit Events by Global User ID          | Show top unified audit events by Global User ID                                                                                        |
| Top Audit Events by Object Name             | Show top unified audit events by Object Name                                                                                           |
| Top Audit Events by none Oracle Object Name | Show top unified audit events by Object Name without Oracle maintained schemas                                                         |
| Top Audit Events by Object Schema           | Show top unified audit events by Object Schema                                                                                         |
| Top Audit Events by OS User                 | Show top unified audit events by OS User                                                                                               |
| Top Audit Events by Unified Policy          | Show top unified audit events by Unified Audit Policy                                                                                  |
| Top Audit Events by SQL Text                | Show top unified audit events by SQL Text                                                                                              |
| Top Audit Events by User                    | Show top unified audit events by User                                                                                                  |

A few Examples and Use Cases



How to add the Reports

via Config

via context menu

Conclusion

Just like the SQL scripts, the reports are helpful for the configuration and a
first analysis of the audit data in the Unified Audit Trail. Especially if you
always work with SQL Developer anyway. As mentioned, you can find the XML report file
[unified_audit_reports.xml](https://github.com/oehrlis/oradba/blob/master/sql/unified_audit_reports.xml)
on GitHub under [oehrlis/oradba](https://github.com/oehrlis/oradba). I would be
happy if you share or like them. Feedback and ideas in the form of comments on
this blogpost or better directly as a GitHub issue are very welcome.
