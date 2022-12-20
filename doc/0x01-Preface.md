# Vorwort {-}
<!-- markdownlint-configure-file { "MD013": { "tables": false } } -->
## Über Oracle Name Resolution mit 389-DS {.unlisted .unnumbered}

Willkommen zum *Oracle Name Resolution mit LDAP - Administrations- und Benutzerhandbuch*.
Dieses Dokument beschreibt das Konzept, die Architektur sowie die Konfiguration
der Oracle Namensauflösung mit *LDAP*. Neben der initialen Konfiguration der
*LDAP Directory* Umgebung werden zudem die betrieblichen Aufgaben beschrieben.

## Copyright und Haftungsausschluss {.unlisted .unnumbered}

Alle Begriffe, bei denen es sich um bekannte Marken oder Dienstleistungsmarken
handelt, wurden in Großbuchstaben geschrieben. Alle Warenzeichen sind Eigentum
der jeweiligen Inhaber.

Oracle und Java sind eingetragene Marken von Oracle und/oder seinen verbundenen
Unternehmen. Andere Namen können Marken ihrer jeweiligen Eigentümer sein. Für
die in diesem Bericht aufgeführten Oracle-Produkte gelten die Lizenzbedingungen
von Oracle.

Die Autoren und der Herausgeber übernehmen keine Haftung oder Verantwortung
gegenüber Verlusten oder Schäden, die sich aus den Informationen in dieser Dokumentation
entstanden sind. Diese Dokumentation kann Ungenauigkeiten oder typografische Fehler
enthalten und geben ausschliesslich die Meinung der Autoren wieder. Änderungen
werden bis zum offiziellen Release von Zeit zu Zeit ohne Vorankündigung an diesem
Dokument vorgenommen.

## Dokumentinformation {.unlisted .unnumbered}

* **Dokument:**             Oracle Name Resolution mit LDAP
* **Klassifizierung:**      internal
* **Status:**               work in Progress
* **Letzte Änderungen:**    2022.02.28
* **Dokumentname:**         tvd-ldap.pdf

| Hauptautoren | Mitwirkende & Gutachter   |
|---------------|--------------------------|
| Stefan Oehrli |                          |

Table: Übersicht der Autoren

## Historie der Revision {.unlisted .unnumbered}

| Version | Datum      | Visum | Bemerkung                                            |
|---------|------------|-------|------------------------------------------------------|
| 0.0.1   | 2021.11.05 | soe   | Initial release                                      |
| 0.1.0   | 2021.11.15 | soe   | Erstellen von Kapitel 1,2 und restliche Struktur     |
| 0.1.1   | 2021.12.03 | soe   | Dokumentation Installation, Generelle Info           |
| 0.2.0   | 2021.12.10 | soe   | Reorg documentation for 389-DS                       |
| 0.2.1   | 2021.12.16 | soe   | Update documentation for 389-DS                      |
| 0.3.0   | 2021.12.16 | soe   | Update Scripts and Appendix C                        |
| 0.3.1   | 2021.12.16 | soe   | Appendix A                                           |
| 0.4.0   | 2022.01.27 | soe   | Update Scripts and Appendix C                        |
| 0.4.1   | 2022.02.22 | soe   | Reorg Installation Chapter                           |
| 0.5.0   | 2022.02.23 | soe   | Update Scripts and Appendix C for other LDAP Clients |
| 0.5.1   | 2022.02.24 | soe   | Fix misc errors in Scripts                           |
| 0.6.0   | 2022.02.25 | soe   | Reorg chapter Installation and Troubleshooting       |
| 0.6.1   | 2022.02.25 | soe   | First Release of additional Chapters                 |
| 0.7.0   | 2022.02.28 | soe   | Update Installation Big Picture and minor doc update |
| 0.8.0   | 2022.03.01 | soe   | Update Installation Chapter based on latest tests    |
| 0.8.1   | 2022.03.07 | soe   | Patch Scripts                                        |
| 0.9.0   | 2022.04.05 | soe   | Introduce Aliases                                    |

Table: Historie der Revision
