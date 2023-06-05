# Anhang C: Skripte

## Allgemeines

Für die Administration der *Net Service Names* im LDAP Directory stehen eine Reihe
von Tools und Skripten zur Verfügung. Diese sollen die verwaltung der Einträge
vereinfachen. Neben diesen Tools können natürlich die Einträge auch direkt mit
den LDAP Utilities *ldapsearch*, *ldapadd*, *ldapmodify* oder *ldapdelete* sowie
mit jedem LDAP Browser verwaltet werden. Für den lesenden Zugriff reicht in der
Regel ein *ANONYMOUS* LDAP Bind. Für den schreibenden Zugriff wird ein Bind DN
z.B. *cn=Directory Manager* oder ein anderer Benutzer aus der *TNS Admin* Gruppe
benötigt. Damit dies nicht immer via Kommandozeile angegeben werden muss, kann man
diese Information auch direkt in einer Konfigurationsdatei erfassen.

Die Verzeichnisstruktur der Tools ist analog der Trivadis *DB Star* Tools aufgebaut.
Somit fügen sich alle Skripte, Log- und Konfigurationsdateien in die TVD-BasEnv
Struktur ein. Unter dem Tool Verzeichnis gibt es folgende Verzeichnisse:

- **bin** Verzeichnis für die Shell Skripte
- **doc** Dokumentation zu *Net Service Names* und LDAP Server
- **etc** Konfigurationsdateien
- **images** Bilder zur Dokumentation
- **ldif** LDIF Dateien zum initialen der LDAP Verzeichnisse
- **log** Verzeichnis für die lokalen Log Dateien falls *$LOG_BASE* nicht
  definiert ist.

In *TVD-LDAP* stehen folgende Tools und Skripte zur Verfügung:

- **tns_add.sh** Hinzufügen eines *Net Service Names* mit entsprechender
  *Oracle Net Service Description* in einer oder mehreren Base DN.
- **tns_delete.sh** Löschen eines *Oracle Net Service Names* in einer / mehreren
  Base DN.
- **tns_dump.sh** Erstellen eines *tnsnames.ora* Files für eine / mehreren Base DN.
- **tns_functions.sh** allgemeine Funktionen für die Skripte
- **tns_load.sh** Laden einer oder mehrere *tnsnames.ora* Dateien.
- **tns_modify.sh** Modifizieren eines *Oracle Net Service Names* mit entsprechender
  *Net Service Description* in einer oder mehreren Base DN.
- **tns_search.sh** Suchen von *Oracle Net Service Names* in einer oder mehreren
  Base DN.
- **tns_test.sh** Testen von *Oracle Net Service Names* in einer oder mehreren
  Base DN. Die Tests erfolgen mit *tnsping* und *sqlplus*.

Alle Skripte erstellen bei jeder Ausführung eine Log Datei. Diese werden zentral
in *$LOG_BASE* gespeichert. Falls *LOG_BASE* nicht definiert ist, wird das *log*
Verzeichnis unter *tvdldap* verwendet. Das Housekeeping der Log Dateien wird jeweils
direkt durch jedes Skript sicher gestellt. D.h. die Log Dateien werden jeweils
nach n-Tagen wieder gelöscht. Wobei n durch die Variable *TVDLDAP_KEEP_LOG_DAYS*
definiert ist. Standardwert ist 14 Tage.

::: note
**Hinweis** Die Skripte benötigen die OpenLDAP Client Tools *ldapsearch*, *ldapadd*,
*ldapmodify* und *ldapdelete*. Es muss sichergestellt werden, dass diese Tools in
der *PATH* Variable an erster Stelle definiert werden oder zumindest vor anderen
LDAP tools z.B. im *ORACLE_HOME* Optional kann auch die *PATH* Variable in
*tvdldap_custom.conf* entsprechend definiert werden.
:::

## Konfigurationsdateien

Wenn vorhanden, laden die Skripte jeweils vorhandene Konfigurationsdateien. Somit
können viele Parameter als Standard definiert werden, ohne diese immer via
Kommandozeile angeben zu müssen. z.B. Bind DN.

Die Konfigurationsdateien werden in der folgenden Reihenfolge geladen:

1. Package Standard Konfiguration *${TVDLDAP_BASE}/etc/tvdldap.conf*
2. Package Custom Konfiguration *${TVDLDAP_BASE}/etc/tvdldap_custom.conf*
3. Package Custom Konfiguration *${ETC_BASE}/tvdldap.conf*
4. Package Custom Konfiguration *${ETC_BASE}/tvdldap_custom.conf*
5. Kommandozeilen Parameter

Die Datei ** enthält ein beispiel von Standard Parameter / Variablen. Weitere wie
z.B. *PATH* Variable sind möglich.

- *TVDLDAP_KEEP_LOG_DAYS* Anzahl der Tage für die Aufbewahrung der Logdateien.
  Standardwert ist 14 Tage.
- *TVDLDAP_BINDDN* Standard Bind DN. *-D Option*
- *TVDLDAP_BINDDN_PWDASK* Flag um interaktiv die Passwörter abzufragen. *-W Option*
- *TVDLDAP_BINDDN_PWD* Bind Passwort, Nicht wirlich ideal das hier zu speichern.
- *TVDLDAP_BINDDN_PWDFILE* Pfad zu einer Password Datei *-y Option*

## Net Service Einträge suchen *tns_search.sh*

Usage / Hilfe zum Skript *tns_search.sh*:

```bash
INFO : Start tns_search.sh on host db19 at Thu Dec 16 09:56:59 CET 2021

  Usage: tns_search.sh [options] [bind options] [search options]
                       [services]

  where:
    services            Comma separated list of Oracle Net Service Names
                        to search
        
  Common Options:
    -m                  Usage this message
    -v                  Enable verbose mode
                        (default $TVDLDAP_VERBOSE=FALSE)
    -d                  Enable debug mode (default $TVDLDAP_DEBUG=FALSE)
    -b <BASEDN>         Specify Base DN to search Net Service Name.
                        Either specific base DN or ALL to search Net
                        Service Name in all available namingContexts. By
                        the default the Base DN is derived from a fully
                        qualified Net Service Name. Otherwise the default
                        Base DN is taken from ldap.ora
    -h <HOST>           LDAP server (default take from ldap.ora)
    -p <PORT>           port on LDAP server (default take from ldap.ora)

  Bind Options:
    -D <BINDDN>         Bind DN (default ANONYMOUS)
    -w <PASSWORD>       Bind password
    -W                  prompt for bind password
    -y <PASSWORD FILE>  Read password from file

  Search options:
    -S <NETSERVICE>     Oracle Net Service Names to search for
                        (default $ORACLE_SID)
    
  Logfile : /u01/app/oracle/local/dba/log/tns_search_2021.12.16_095659.log

INFO : Successfully finish tns_search.sh
```

- Beispiel für die Suche nach einem *Net Service Name* *TDB01* im Standard Names
  Kontext (übernommen aus *ldap.ora*).

```bash
oracle@db19:~/ [rdbms19] tns_search.sh TDB01
INFO : Start tns_search.sh on host db19 at Thu Dec 16 11:45:37 CET 2021

INFO : Process base dn dc=epu,dc=corpintra,dc=net
TDB01.epu.corpintra.net=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=db19)
(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)
(SERVICE_NAME=TDB01.trivadislabs.com))(UR=A))

INFO : Successfully finish tns_search.sh
```

- Suchen eines *Net Service Name* *TDB01* in allen verfügbaren Names Kontexte

```bash
tns_search.sh -b ALL -S TDB01
```

- Suchen mit Wildcards *Net Service Name* *TDB01* im Names Kontext *dc=prod*.

```bash
tns_search.sh -b "dc=prod" -S TDB*
```

## Net Service Einträge testen *tns_test.sh*

Usage / Hilfe zum Skript *tns_test.sh*:

```bash
INFO : Start tns_test.sh on host db19 at Mon Feb 21 14:24:50 CET 2022

  Usage: tns_test.sh [options] [test options] [bind options] [search options] [services]

  where:
    services            Comma separated list of Oracle Net Service Names to test

  Common Options:
    -m                  Usage this message
    -v                  Enable verbose mode (default $TVDLDAP_VERBOSE=FALSE)
    -d                  Enable debug mode (default $TVDLDAP_DEBUG=FALSE)
    -b <BASEDN>         Specify Base DN to search Net Service Name. Either
                        specific base DN or ALL to search Net Service Name in
                        all available namingContexts. By the default the Base
                        DN is derived from a fully qualified Net Service Name.
                        Otherwise the default Base DN is taken from ldap.ora
    -h <HOST>           LDAP server (default take from ldap.ora)
    -p <PORT>           port on LDAP server (default take from ldap.ora)
    -t <DURATION>       Specific a timeout for the test commands using core utility
                        timeout. DURATION is a number with an optional suffix: 's'
                        for seconds (the default), 'm' for minutes, 'h' for
                        hours or 'd' for days. A duration of 0 disables the
                        associated timeout.     
  
  Test Options:
    -U <USERNAME>       Username for SQLPlus test. If no username is specified,
                        the SQLPlus test will be omitted.
    -c <PASSWORD>       SQLPlus password
    -C                  prompt for SQLPlus password
    -Z <PASSWORD FILE>  Read password from file
  
  Bind Options:
    -D <BINDDN>         Bind DN (default ANONYMOUS)
    -w <PASSWORD>       Bind password
    -W                  prompt for bind password
    -y <PASSWORD FILE>  Read password from file

  Search options:
    -S <NETSERVICE>     Oracle Net Service Names to search for
                        (default $ORACLE_SID)

  Logfile : /u01/app/oracle/local/dba/log/tns_test_2022.02.21_142450.log

INFO : Successfully finish tns_test.sh
```

- Beispiel für das Testen der *Net Service Names* im Standard Names
  Kontext (übernommen aus *ldap.ora*).

```bash
oracle@db19:~/ [rdbms19] tns_test.sh
INFO : Start tns_test.sh on host db19 at Mon Feb 21 14:25:32 CET 2022
INFO : Skip test timeout as duration is set to 0.
WARN : Skip SQLPlus test. No user name defined.

INFO : Process base dn dc=epu,dc=corpintra,dc=net
INFO : Test Net Service Connect String for TDB01.epu.corpintra.net ...OK  (tnsping)
INFO : Test Net Service Connect String for TDB02.epu.corpintra.net ...OK  (tnsping)
INFO : Test Net Service Connect String for TDB03.epu.corpintra.net ...NOK (TNS-12533)
INFO : Test Net Service Connect String for TDB04.epu.corpintra.net ...NOK (TNS-12541)
INFO : Successfully finish tns_test.sh
```

- Testen der *Net Service Names* in allen verfügbaren Names Kontexte

```bash
tns_test.sh -b ALL
```

- Testen der *Net Service Names* im Names Kontext *dc=prod*.

```bash
tns_test.sh -b "dc=prod"
```

- Testen der *Net Service Names* in allen verfügbaren Names Kontexte inklusive
  SQLPlus login test mit dem Test Benutzer **system** und dem Passwort aus der
  Datei **$ORACLE_BASE/admin/TDB02/etc/TDB02_password.txt**. Alternativ kann der
  Benutzer und das Passwort respektive Passwort File auch in
  **etc/tvdldap_custom.conf** mit den Variablen *TVDLDAP_SQL_USER*,
  *TVDLDAP_SQL_PWD* und *TVDLDAP_SQL_PWDFILE*.

```bash
tns_test.sh -U "system" -Z $ORACLE_BASE/admin/TDB02/etc/TDB02_password.txt -S ALL
```

## Net Service Einträge hinzufügen *tns_add.sh*

Mit *tns_add.sh* neue *Net Service Names* erstellt. Sind diese bereits vorhanden,
können diese mit dem Parameter Force modifiziert werden.

Usage / Hilfe zum Skript *tns_add.sh*:

```bash
INFO : Start tns_add.sh on host db19 at Thu Dec 16 10:03:21 CET 2021

  Usage: tns_add.sh [options] [bind options] [add options]

  Common Options:
    -m                  Usage this message
    -v                  Enable verbose mode
                        (default $TVDLDAP_VERBOSE=FALSE)
    -d                  Enable debug mode
                        (default $TVDLDAP_DEBUG=FALSE)
    -b <BASEDN>         Specify Base DN to add Net Service Name.
                        Either specific base DN or ALL to add Net
                        Service Name into all available namingContexts.
                        By the default the Base DN is derived from a fully
                        qualified Net Service Name. Otherwise the default
                        Base DN is taken from ldap.ora
    -h <HOST>           LDAP server (default take from ldap.ora)
    -p <PORT>           port on LDAP server (default take from ldap.ora)

  Bind Options:
    -D <BINDDN>         Bind DN (default ANONYMOUS)
    -w <PASSWORD>       Bind password
    -W                  prompt for bind password
    -y <PASSWORD FILE>  Read password from file

  Add options:
    -S <NETSERVICE>     Oracle Net Service Name to add (mandatory)
    -N <NETDESCSTRING>  Oracle Net Service description string
                        (mandatory)
    -n                  Show what would be done but do not actually do it
    -F                  Force mode to modify existing entry

  Logfile : /u01/app/oracle/local/dba/log/tns_add_2021.12.16_100321.log

INFO : Successfully finish tns_add.sh
```

- Hinzufügen eines *Net Service Namens* im aktuellen Namens Kontext mit Angabe der
  Bind DN

```bash
tns_add.sh -D "uid=oracle,ou=people,dc=epu,dc=corpintra,dc=net" \
-w LAB42-Schulung -S TDB02 -N "(Test Connect String)"
```

- Hinzufügen eines *Net Service Namens* ohne Bind Informationen in allen vorhandenen
  Namenskontexte. Die Bind Informationen müssen vorgängig mit den
  Umgebungsvariablen *TVDLDAP_BINDDN* sowie *TVDLDAP_BINDDN_PWDFILE* definiert
  werden. Z.B. in der Konfigurationsdatei.

```bash
tns_add.sh -b ALL -S TDB02 -N "(Test Connect String)"
```

## Net Service Einträge modifizieren *tns_modify.sh*

Mit *tns_modify.sh* werden vorhandene *Net Service Names* angepasst. Sind diese
noch nicht vorhanden, können diese mit dem Parameter Force erstellt werden.

Usage / Hilfe zum Skript *tns_modify.sh*:

```bash
INFO : Start tns_modify.sh on host db19 at Thu Dec 16 10:06:20 CET 2021

  Usage: tns_modify.sh [options] [bind options] [modify options]

  Common Options:
    -m                  Usage this message
    -v                  Enable verbose mode
                        (default $TVDLDAP_VERBOSE=FALSE)
    -d                  Enable debug mode
                        (default $TVDLDAP_DEBUG=FALSE)
    -b <BASEDN>         Specify Base DN to add Net Service Name.
                        Either specific base DN or ALL to add Net
                        Service Name into all available namingContexts.
                        By the default the Base DN is derived from a fully
                        qualified Net Service Name. Otherwise the default
                        Base DN is taken from ldap.ora
    -h <HOST>           LDAP server (default take from ldap.ora)
    -p <PORT>           port on LDAP server (default take from ldap.ora)

  Bind Options:
    -D <BINDDN>         Bind DN (default ANONYMOUS)
    -w <PASSWORD>       Bind password
    -W                  prompt for bind password
    -y <PASSWORD FILE>  Read password from file

  Modify options:
    -S <NETSERVICE>     Oracle Net Service Name to modify (mandatory)
    -N <NETDESCSTRING>  Oracle Net Service description string (mandatory)
    -n                  Show what would be done but do not actually do it
    -F                  Force mode to add entry it it does not exists

  Logfile : /u01/app/oracle/local/dba/log/tns_modify_2021.12.16_100620.log

INFO : Successfully finish tns_modify.sh
```

- Modifizieren eines *Net Service Namens* im aktuellen Namens Kontext mit Angabe
  der Bind DN. Das Passwort wird interaktiv abgefragt.

```bash
tns_modify.sh -D "uid=oracle,ou=people,dc=epu,dc=corpintra,dc=net" \
-W -S TDB02 -N "(Test Connect String)"
```

- Hinzufügen eines *Net Service Namens* ohne Bind Informationen in allen vorhandenen
  Namenskontexte. Die Bind Informationen müssen vorgängig mit den
  Umgebungsvariablen *TVDLDAP_BINDDN* sowie *TVDLDAP_BINDDN_PWDFILE* definiert
  werden. Z.B. in der Konfigurationsdatei.

```bash
tns_modify.sh -b ALL -S TDB02 -N "(Test Connect String)"
```

## Net Service Einträge löschen *tns_delete.sh*

Usage / Hilfe zum Skript *tns_delete.sh*:

```bash
INFO : Start tns_delete.sh on host db19 at Thu Dec 16 10:04:34 CET 2021

  Usage: tns_delete.sh [options] [bind options] [delete options] [services]

  where:
    services            Comma separated list of Oracle Net Service Names to delete

  Common Options:
    -m                  Usage this message
    -v                  Enable verbose mode
                        (default $TVDLDAP_VERBOSE=FALSE)
    -d                  Enable debug mode
                        (default $TVDLDAP_DEBUG=FALSE)
    -b <BASEDN>         Specify Base DN to add Net Service Name.
                        Either specific base DN or ALL to add Net
                        Service Name into all available namingContexts.
                        By the default the Base DN is derived from a fully
                        qualified Net Service Name. Otherwise the default
                        Base DN is taken from ldap.ora
    -h <HOST>           LDAP server (default take from ldap.ora)
    -p <PORT>           port on LDAP server (default take from ldap.ora)

  Bind Options:
    -D <BINDDN>         Bind DN (default ANONYMOUS)
    -w <PASSWORD>       Bind password
    -W                  prompt for bind password
    -y <PASSWORD FILE>  Read password from file

  Delete options:
    -S <NETSERVICE>     Oracle Net Service Names to delete (mandatory)
    -n                  Show what would be done but do not actually do it
    -F                  Force mode to modify existing entry

  Logfile : /u01/app/oracle/local/dba/log/tns_delete_2021.12.16_100434.log

INFO : Successfully finish tns_delete.sh
```

- Löschen eines *Net Service Namens* im aktuellen Namens Kontext mit Angabe der
  Bind DN

```bash
tns_delete.sh -D "uid=oracle,ou=people,dc=epu,dc=corpintra,dc=net" \
-w LAB42-Schulung -S TDB02
```

- Löschen eines *Net Service Namens* ohne Bind Informationen in allen vorhandenen
  Namenskontexte. Die Bind Informationen müssen vorgängig mit den
  Umgebungsvariablen *TVDLDAP_BINDDN* sowie *TVDLDAP_BINDDN_PWDFILE* definiert
  werden. Z.B. in der Konfigurationsdatei.

```bash
tns_delete.sh -b ALL -S TDB02
```

## tnsnames Datei generieren *tns_dump.sh*

Usage / Hilfe zum Skript *tns_dump.sh*:

```bash
INFO : Start tns_dump.sh on host db19 at Thu Dec 16 10:05:43 CET 2021

  Usage: tns_dump.sh [options] [bind options] [dump options]

  Common Options:
    -m                  Usage this message
    -v                  Enable verbose mode
                        (default $TVDLDAP_VERBOSE=FALSE)
    -d                  Enable debug mode
                        (default $TVDLDAP_DEBUG=FALSE)
    -b <BASEDN>         Specify Base DN to add Net Service Name.
                        Either specific base DN or ALL to add Net
                        Service Name into all available namingContexts.
                        By the default the Base DN is derived from a fully
                        qualified Net Service Name. Otherwise the default
                        Base DN is taken from ldap.ora
    -h <HOST>           LDAP server (default take from ldap.ora)
    -p <PORT>           port on LDAP server (default take from ldap.ora)

  Bind Options:
    -D <BINDDN>         Bind DN (default ANONYMOUS)
    -w <PASSWORD>       Bind password
    -W                  prompt for bind password
    -y <PASSWORD FILE>  Read password from file

  Dump options:
    -T <OUTPUT DIRECTORY> Output Directory to dump the tnsnames information
                          (default /u01/app/oracle/network/admin)
    -o <OUTPUT FILE>      Output file with tnsnames dump from specified Base
                          DN (default ldap_dump_<BASEDN>_<DATE>.ora)
    -n                    Show what would be done but do not actually do it
    -F                    Force mode to overwrite existing tnsnames dump files

  Logfile : /u01/app/oracle/local/dba/log/tns_dump_2021.12.16_100543.log

INFO : Successfully finish tns_dump.sh
```

- Erstellen eines tnsnames.ora Dump Files für alle Namenskontexte

```bash
oracle@db19:~/ [rdbms19] tns_dump.sh -b ALL -T . 
INFO : Start tns_dump.sh on host db19 at Thu Dec 16 12:17:40 CET 2021

INFO : Process base dn dc=epu,dc=corpintra,dc=net
INFO : Dump TNS Names into ./ldap_dump_epu.corpintra.net_2021.12.16_121740.ora
INFO : Process base dn dc=devm
INFO : Dump TNS Names into ./ldap_dump_devm_2021.12.16_121740.ora
INFO : Process base dn dc=devp
INFO : Dump TNS Names into ./ldap_dump_devp_2021.12.16_121740.ora
INFO : Process base dn dc=intm
INFO : Dump TNS Names into ./ldap_dump_intm_2021.12.16_121740.ora
INFO : Process base dn dc=intp
INFO : Dump TNS Names into ./ldap_dump_intp_2021.12.16_121740.ora
INFO : Process base dn dc=labo
INFO : Dump TNS Names into ./ldap_dump_labo_2021.12.16_121740.ora
INFO : Process base dn dc=prod
INFO : Dump TNS Names into ./ldap_dump_prod_2021.12.16_121740.ora
INFO : Process base dn dc=wrld
INFO : Dump TNS Names into ./ldap_dump_wrld_2021.12.16_121740.ora

INFO : Successfully finish tns_dump.sh
```

## tnsnames Datei laden *tns_load.sh*

Mit *tns_load.sh* können *Net Service Names* Einträge direkt aus einem
*tnsnames.ora* geladen werden. Vorhandene Einträge werden übersprungen und in
einer *skip Datei* aufgelistet. Mit der Option FORCE, können bestehende Einträge
auch Modifiziert werden. Einträge, welche nicht geladen werden können z.B. weil
die Base DN nicht bekannt ist, werden in einer *reject Datei* aufgeführt.

Usage / Hilfe zum Skript *tns_load.sh*:

```bash
INFO : Start tns_load.sh on host db19 at Thu Dec 16 10:06:03 CET 2021

  Usage: tns_load.sh [options] [bind options] [load options]

  Common Options:
    -m                  Usage this message
    -v                  Enable verbose mode
                        (default $TVDLDAP_VERBOSE=FALSE)
    -d                  Enable debug mode
                        (default $TVDLDAP_DEBUG=FALSE)
    -b <BASEDN>         Specify Base DN to add Net Service Name.
                        Either specific base DN or ALL to add Net
                        Service Name into all available namingContexts.
                        By the default the Base DN is derived from a fully
                        qualified Net Service Name. Otherwise the default
                        Base DN is taken from ldap.ora
    -h <HOST>           LDAP server (default take from ldap.ora)
    -p <PORT>           port on LDAP server (default take from ldap.ora)

  Bind Options:
    -D <BINDDN>         Bind DN (default ANONYMOUS)
    -w <PASSWORD>       Bind password
    -W                  prompt for bind password
    -y <PASSWORD FILE>  Read password from file

  Load options:
    -t <TNSNAMES FILE>  tnsnames.ora file to read and load (mandatory)
    -n                  Show what would be done but do not actually do it
    -F                  Force mode to add entry it it does not exists

  Logfile : /u01/app/oracle/local/dba/log/tns_load_2021.12.16_100603.log

INFO : Successfully finish tns_load.sh
```

- Laden der *tnsnames_ePU5.ora* Datei im Dry Run Mode mit Angabe der Bind
  Informationen

```bash
tns_load.sh -D "uid=oracle,ou=people,dc=epu,dc=corpintra,dc=net" \
-y $TVDLDAP_BASE/etc/.oraNetoracle.pwd -t ./tnsnames_ePU5.ora -n
```

::: note
**Hinweis** Die *tnsnames.ora* Dateien können ziemlich unterschiedlich formatiert
sein. Das Skript *tns_load.sh* kann nicht alle Varianten abdecken. Insbesondere
werden *ifile* sowie commas in *Net Service Names* nicht unterstützt. Es wird
empfohlen mit der *-n* Option vorgängig zu prüfen, ob ein *tnsnames.ora* File
korrekt gelesen wird.
:::

## Allgemeine Funktionen *tns_functions.sh*

Um die Bash Skripte einfacher und lesbarer zu machen, werden verschiedene allgemeine
Aufgaben in Funktionen zusammen gefasst. Diese Funktionen werden im Skripte
*tns_functions.sh* definiert und in den jeweiligen Skripten jeweils zu begin
geladen. Es stehen folgende Funktionen zur Verfügung:

- **ask_bindpwd** Abfragen des Bind Passwortes für den Parameter -W bei allen
  LDAP Tools ausser OpenLDAP
- **basedn_exists** Prüfen ob eine Base DN im LDAP Server *namingContexts*
  vorhanden ist.
- **check_bind_parameter** Prüfen der richtigen Bindungsparameter und der richtige
  Kombination.
- **check_ldap_tools** Prüfen welche LDAP Tools im *PATH* verfügbar sind.
  Entsprechend wird *TVDLDAP_LDAPTOOLS* auf *OPENLDAP*, *OUD* oder *DB* gesetzt.
- **check_openldap_tools** Prüfen ob die benötigten OpenLDAP Client tools
  verfügbar sind.
- **check_tools** Prüfen ob eine *LISTE* von Tools verfügbar ist.
- **clean_quit** Funktion zum ordentlichen Beenden und Ausgabe der Fehlermeldungen.
- **command_exists** Prüfen, ob das Kommando *PARAMETER* verfügbar ist.
- **dryrun_enabled** Prüfen, ob der DRYRUN-Modus aktiviert ist.
- **dump_runtime_config** Dump / Display der Runtime Konfiguration und Variablen
  im Debug Mode.
- **echo_debug** Ausgabe an STDOUT when TVDLDAP_DEBUG Variable TRUE ist.
- **force_enabled** Prüfen, ob der FORCE-Modus aktiviert ist.
- **get_all_basedn** Abfragen aller Base DN welche im LDAP Server *namingContexts*
  definiert wurden.
- **get_basedn** Abfragen der korrekter Basis-DN. Entweder Standard, *ldap.ora*
  oder alle. Wenn die Base DN ohne *dc=* angegeben wurde, wird dies entsprechend
  berücksichtigt / korrigiert.
- **get_binddn_param** Bind DN Parameter erstellen.
- **get_bindpwd_param** Bind-Passwort-Parameter erstellen.
- **get_ldaphost** LDAP-Host aus ldap.ora abrufen.
- **get_ldapport** LDAP-Port aus ldap.ora abrufen.
- **get_local_basedn** Base DN von *ldap.ora* bzw. *DEFAULT_ADMIN_CONTEXT* abrufen.
- **ldapadd_options** Festlegen der Optionen für *ldapadd* abhängig von *TVDLDAP_LDAPTOOLS*
- **ldapmodify_options** Festlegen der Optionen für *ldapmodify* abhängig von *TVDLDAP_LDAPTOOLS*
- **ldapsearch_options** Festlegen der Optionen für *ldapsearch* abhängig von *TVDLDAP_LDAPTOOLS*
- **load_config** Laden der Konfigurationsdateien aus *$ETC_BASE* und *$TVDLDAP_BASE/etc*.
- **net_service_exists** Prüfen, ob Net Service Name existiert
- **rotate_logfiles** Rotieren und Löschen der Logfiles abhängig von  *TVDLDAP_KEEP_LOG_DAYS*
- **split_net_service_basedn** Basis-DN von voll qualifiziertem Net Service Name
  abspalten.
- **split_net_service_cn** Net Service Name von voll qualifiziertem Net Service
  Name abspalten.

Das Script und die Funktionen können auch individuell in der Shell Umgebung oder
anderen Skripten genutzt werden. Dazu muss lediglich das Skript *tns_functions.sh*
wie folgt geladen werden:

```bash
# source common functions from tns_functions.sh
if [ -f ${TVDLDAP_BASE}/bin/tns_functions.sh ]; then
    . ${TVDLDAP_BASE}/bin/tns_functions.sh
else
    echo "ERROR: Can not find common functions ${TVDLDAP_BASE}/bin/tns_functions.sh"
    exit 5
fi
```
