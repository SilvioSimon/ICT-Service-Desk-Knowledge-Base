# Drucker- und Peripherie-Probleme

**Tags:** `#drucker` `#peripherie` `#scanner` `#usb` `#bluetooth` `#netzwerkdrucker` `#servicedesk`

## Kurzbeschreibung
Sammlung der häufigsten Probleme im Support-Alltag rund um Drucker, Scanner und angeschlossene Peripheriegeräte: hängende Druckaufträge, offline Drucker, Netzwerkdrucker-Verbindungsprobleme, Druckqualität, Papierstau, Scan-Probleme sowie USB- und Bluetooth-Geräte, die nicht erkannt werden. Jeder Abschnitt folgt dem Schema Symptom → Ursachenanalyse → Lösungsschritte → Eskalationskriterien.

## Voraussetzungen
- Lokaler Administratorzugriff auf dem betroffenen Client
- Zugriff auf die Druckerverwaltung (`Systemsteuerung → Geräte und Drucker` bzw. `printmanagement.msc`)
- Kenntnis oder Zugriff auf den Druckserver (Name/IP), falls Netzwerkdrucker betroffen sind
- Zugriff auf Remote-Support-Tool (z. B. Quick Assist, TeamViewer) für Ferndiagnose
- Bei Multifunktionsgeräten: Zugriff auf das Web-Interface des Geräts (IP im Browser), sofern im Netzwerk erreichbar

## Inhaltsverzeichnis
1. [Druckauftrag hängt in der Warteschlange](#1-druckauftrag-hängt-in-der-warteschlange)
2. [Drucker offline / wird nicht erkannt](#2-drucker-offline--wird-nicht-erkannt)
3. [Netzwerkdrucker – Verbindungsprobleme](#3-netzwerkdrucker--verbindungsprobleme)
4. [Druckqualität (Streifen, blasse Ausdrucke, Farbfehler)](#4-druckqualität-streifen-blasse-ausdrucke-farbfehler)
5. [Papierstau / Papiereinzugsprobleme](#5-papierstau--papiereinzugsprobleme)
6. [Scan-Probleme (Scan-to-Email / Scan-to-Folder)](#6-scan-probleme-scan-to-email--scan-to-folder)
7. [USB-Peripheriegeräte werden nicht erkannt](#7-usb-peripheriegeräte-werden-nicht-erkannt)
8. [Bluetooth- / Wireless-Peripheriegeräte](#8-bluetooth--wireless-peripheriegeräte)
9. [Remote-Support-Hinweise](#remote-support-hinweise)

---

## 1. Druckauftrag hängt in der Warteschlange

**Priorität:** P3

**Symptom:** Ein oder mehrere Druckaufträge bleiben in der Warteschlange stehen, der Status wechselt nicht auf „Wird gedruckt" oder es erscheint „Fehler beim Drucken". Teilweise blockiert ein hängender Auftrag alle nachfolgenden.

**Ursachenanalyse:**
- Druckerwarteschlange öffnen (`Geräte und Drucker → Drucker doppelklicken`) und prüfen, welcher Auftrag hängt
- Prüfen, ob der Spooler-Dienst (`Print Spooler`, `spoolsv.exe`) noch läuft
- Grösse des Druckauftrags prüfen – sehr grosse Dateien (z. B. PDFs mit hochauflösenden Bildern) können den Spooler überlasten
- Prüfen, ob dasselbe Problem bei mehreren Nutzenden am selben Drucker auftritt (Hinweis auf Geräte- statt Client-Problem)

**Lösungsschritte:**
1. Alle Druckaufträge aus der Warteschlange entfernen.
2. Print-Spooler-Dienst neu starten:
   ```
   net stop spooler
   net start spooler
   ```
3. Falls der Spooler-Ordner verstopft ist, Inhalt von `C:\Windows\System32\spool\PRINTERS` löschen (nur bei gestopptem Dienst) und Spooler danach neu starten.
4. Testseite drucken, um zu prüfen, ob die Warteschlange wieder normal funktioniert.
5. Bei wiederholtem Problem: Drucker entfernen und mit aktuellem Treiber neu einrichten.

**Eskalationskriterien:**
- Problem tritt bei mehreren Nutzenden am selben Drucker auf → Hinweis auf Problem am Druckserver oder Gerät selbst
- Spooler-Dienst stürzt wiederholt ab, auch nach Neuinstallation des Treibers

**Eskalation an:** Client-Management-Team bei Druckserver-Verdacht, Hardware-Team bei Geräteverdacht

---

## 2. Drucker offline / wird nicht erkannt

**Priorität:** P3

**Symptom:** Der Drucker wird in Windows als „Offline" angezeigt, obwohl er physisch eingeschaltet und bereit ist, oder er taucht in der Geräteliste gar nicht mehr auf.

**Erfahrungsbericht:** Bei diesem Ticket lohnt sich fast immer zuerst der Griff zum Gerät selbst, statt am PC herumzukonfigurieren: Steht wirklich „Bereit" auf dem Display, oder meldet der Drucker im Hintergrund einen Fehler (Toner, Papier, offene Klappe), den Windows einfach als „Offline" interpretiert? Ein grosser Teil dieser Tickets löst sich, sobald man den Drucker kurz aus- und wieder einsteckt und die Nutzenden direkt bittet, aufs Display zu schauen, statt nur den Windows-Status zu melden.

**Ursachenanalyse:**
- Physischen Status am Gerät prüfen (Display, Fehlermeldungen, LEDs)
- Prüfen, ob „Drucker offline verwenden" versehentlich aktiviert ist (`Rechtsklick auf Drucker → Als Standarddrucker offline verwenden`)
- Bei USB-Anschluss: Kabel und Port wechseln, um ein defektes Kabel auszuschliessen
- Bei Netzwerkdrucker: prüfen, ob sich die IP-Adresse des Geräts geändert hat (z. B. nach DHCP-Lease-Ablauf)

**Lösungsschritte:**
1. Drucker aus- und wieder einschalten.
2. „Offline verwenden" deaktivieren, falls gesetzt.
3. USB-Kabel/-Port wechseln bzw. bei Netzwerkdruckern die IP-Adresse im Druckerport mit der aktuellen Geräte-IP abgleichen.
4. Drucker in Windows entfernen und neu hinzufügen.
5. Aktuellen Treiber vom Hersteller neu installieren, falls das Problem nach einem Windows-Update aufgetreten ist.

**Eskalationskriterien:**
- Drucker bleibt auch nach Neustart und Treiber-Neuinstallation offline
- IP-Adresse ändert sich wiederholt trotz eingerichteter DHCP-Reservierung

**Eskalation an:** Netzwerk-Team bei wiederholten IP-Wechseln, Hardware-Team bei Geräteverdacht

---

## 3. Netzwerkdrucker – Verbindungsprobleme

**Priorität:** P3

**Symptom:** Der Drucker ist im Netzwerk grundsätzlich erreichbar, aber Druckaufträge kommen nicht an, brechen ab oder es dauert ungewöhnlich lange, bis gedruckt wird.

**Ursachenanalyse:**
- Ping auf die Drucker-IP prüfen, um grundlegende Netzwerkerreichbarkeit auszuschliessen
- Prüfen, ob das Problem nur einen Client oder mehrere/alle Nutzenden am gleichen Drucker betrifft
- Druckerport-Konfiguration im Client prüfen (`Standard TCP/IP-Port`, korrekte IP)
- Prüfen, ob am Gerät selbst ein Papierstau, eine Fehlermeldung oder ein voller Speicher die Ursache ist

**Lösungsschritte:**
1. Ping auf die Drucker-IP ausführen, um Netzwerkerreichbarkeit zu bestätigen.
2. Druckerport-Einstellungen im Client kontrollieren und bei Bedarf korrigieren.
3. Am Gerät selbst nachsehen, ob ein Fehlerstatus (Papierstau, Speicher voll, Verbrauchsmaterial) die Verarbeitung blockiert.
4. Testdruck direkt vom Druckserver aus veranlassen, um Client-seitige Ursachen auszuschliessen.
5. Firmware des Druckers auf Aktualität prüfen, besonders nach Netzwerk- oder Switch-Änderungen.
6. Netzwerk-Team beiziehen, falls VLAN- oder Firewall-Regeln kürzlich geändert wurden.

**Eskalationskriterien:**
- Mehrere Nutzende oder Standorte gleichzeitig betroffen → Hinweis auf zentrales Netzwerk- oder Druckserverproblem
- Ping schlägt fehl, obwohl das Gerät laut Display „Bereit" meldet
- Problem tritt nach einer bekannten Netzwerkänderung (VLAN, Switch, Firewall-Regel) auf

**Eskalation an:** Netzwerk-Team bei Erreichbarkeitsproblemen, Client-Management-Team bei Druckserververdacht

---

## 4. Druckqualität (Streifen, blasse Ausdrucke, Farbfehler)

**Priorität:** P4

**Symptom:** Ausdrucke sind blass, haben Streifen, falsche Farben oder wiederkehrende Flecken/Muster auf der Seite.

**Ursachenanalyse:**
- Muster der Fehlerdruckseite anschauen: gleichmässige Streifen deuten meist auf Tonerstand oder Druckkopf hin, wiederkehrende Flecken im gleichen Abstand eher auf eine defekte Trommel/Walze
- Toner-/Tintenstand am Gerät oder über das Web-Interface prüfen
- Prüfen, ob das Problem bei allen Dokumenten auftritt oder nur bei bestimmten Anwendungen/Dateiformaten
- Druckereinstellungen (Qualität, Papiertyp) im Treiber kontrollieren

**Lösungsschritte:**
1. Toner-/Tintenstand prüfen und bei Bedarf ersetzen.
2. Düsenreinigung bzw. Druckkopfreinigung über das Bedienpanel oder die Druckersoftware ausführen.
3. Papiertyp-Einstellung im Treiber mit dem tatsächlich eingelegten Papier abgleichen.
4. Testseite direkt am Gerät drucken (ohne PC), um Treiber als Ursache auszuschliessen.
5. Bei wiederkehrendem Muster: Trommel-/Walzeneinheit gemäss Herstellerangabe prüfen oder ersetzen.

**Eskalationskriterien:**
- Problem besteht auch nach Reinigung und neuem Verbrauchsmaterial weiter
- Wiederkehrendes Fleckenmuster deutet auf einen Defekt an Trommel, Fixiereinheit oder Walze hin

**Eskalation an:** Hardware-Team bzw. Vertragspartner für Geräteservice (bei Leasing-/Wartungsvertrag)

---
## 5. Papierstau / Papiereinzugsprobleme

**Priorität:** P4

**Symptom:** Drucker meldet wiederholt Papierstau, auch nachdem gestautes Papier entfernt wurde, oder zieht mehrere Blätter gleichzeitig bzw. gar kein Papier ein.

**Erfahrungsbericht:** Gerade bei älteren Geräten lohnt sich der Hinweis an die Nutzenden, das Papier vor dem Einlegen kurz aufzufächern – klingt banal, löst aber überraschend viele „zieht mehrere Blätter gleichzeitig ein"-Tickets, vor allem wenn frisches Papier direkt aus einer neu geöffneten Packung kommt und die Blätter noch aneinanderhaften.

**Ursachenanalyse:**
- Alle Papierfächer und den Ausgabebereich auf Papierreste kontrollieren, auch an Stellen, die auf den ersten Blick leer wirken
- Papierqualität und -zustand prüfen (feucht, gewellt, falsches Format eingelegt)
- Prüfen, ob der Fehler immer an der gleichen Stelle im Gerät auftritt (Hinweis auf verschlissene Einzugsrollen)

**Lösungsschritte:**
1. Gerät ausschalten und alle Fächer sowie den Ausgabebereich sorgfältig auf Papierreste prüfen.
2. Papier vor dem Einlegen auffächern und auf korrektes Format/Ausrichtung im Fach achten.
3. Einzugsrollen auf Verschleiss oder Verschmutzung prüfen, bei Bedarf mit einem leicht feuchten Tuch reinigen.
4. Gerät neu starten und Testdruck durchführen.

**Eskalationskriterien:**
- Papierstau tritt wiederholt an derselben Stelle im Gerät auf, auch nach Reinigung
- Einzugsrollen sind sichtbar verschlissen

**Eskalation an:** Hardware-Team bzw. Vertragspartner für Geräteservice

---

## 6. Scan-Probleme (Scan-to-Email / Scan-to-Folder)

**Priorität:** P3

**Symptom:** Das Scannen selbst funktioniert, aber der Versand per E-Mail oder die Ablage in einem Netzwerkordner schlägt fehl, bricht ab oder das Ziel erhält nichts.

**Ursachenanalyse:**
- Prüfen, ob das Problem beim Scan-to-Email oder Scan-to-Folder liegt (unterschiedliche Ursachen)
- Bei Scan-to-Email: SMTP-Konfiguration am Gerät prüfen, insbesondere nach Änderungen an Mailserver-Zertifikaten oder Authentifizierungsanforderungen
- Bei Scan-to-Folder: Berechtigungen auf dem Zielordner sowie das im Gerät hinterlegte Dienstkonto prüfen
- Prüfen, ob sich kürzlich das Passwort des im Gerät hinterlegten Kontos geändert hat

**Lösungsschritte:**
1. Testscan an eine interne, bekannt funktionierende Adresse bzw. in einen Testordner durchführen.
2. Bei Scan-to-Email: SMTP-Einstellungen am Gerät (Server, Port, Authentifizierung) mit den aktuellen Vorgaben des Mail-Teams abgleichen.
3. Bei Scan-to-Folder: Berechtigungen auf dem Zielordner sowie das hinterlegte Dienstkonto und dessen Passwort prüfen.
4. Firmware des Geräts auf Aktualität prüfen, falls das Problem nach einer zentralen Änderung (z. B. TLS-Anforderung) begann.

**Eskalationskriterien:**
- Problem betrifft mehrere Geräte gleichzeitig → Hinweis auf zentrale Änderung am Mailserver oder Dienstkonto
- Zugangsdaten des Dienstkontos sind unbekannt oder nicht mehr auffindbar

**Eskalation an:** Mail-/Exchange-Team bei SMTP-Problemen, Server-Team bei Fileserver-/Berechtigungsproblemen

---

## 7. USB-Peripheriegeräte werden nicht erkannt

**Priorität:** P3

**Symptom:** Maus, Tastatur, Webcam, Docking Station oder externe Laufwerke werden nach dem Anschliessen nicht erkannt oder funktionieren nur zeitweise.

**Ursachenanalyse:**
- Prüfen, ob das Gerät an einem anderen USB-Port oder an einem anderen PC funktioniert, um zwischen Geräte- und Portdefekt zu unterscheiden
- Geräte-Manager (`devmgmt.msc`) auf Fehler-Symbole oder unbekannte Geräte prüfen
- Bei Docking Stations: prüfen, ob die Dockingstation selbst noch aktuelle Firmware/Treiber hat
- Stromversorgung prüfen, insbesondere bei mehreren gleichzeitig angeschlossenen Geräten über einen USB-Hub

**Lösungsschritte:**
1. Gerät an einem anderen USB-Port testen.
2. Im Geräte-Manager nach Fehlereinträgen suchen und betroffene Treiber deinstallieren, danach Gerät neu anschliessen.
3. USB-Controller-Treiber über den Geräte-Manager aktualisieren.
4. Bei Docking Stations: Firmware und Treiber vom Hersteller aktualisieren.
5. Gerät an einem zweiten PC testen, um einen Gerätedefekt sicher auszuschliessen.

**Eskalationskriterien:**
- Gerät funktioniert an keinem PC und keinem Port → Hinweis auf Gerätedefekt
- Mehrere USB-Geräte am selben PC gleichzeitig betroffen → Hinweis auf USB-Controller- oder Mainboard-Defekt

**Eskalation an:** Hardware-Team

---

## 8. Bluetooth- / Wireless-Peripheriegeräte

**Priorität:** P4

**Symptom:** Kabellose Maus, Tastatur oder Headset verbinden sich nicht, verlieren immer wieder die Verbindung oder lassen sich gar nicht erst koppeln.

**Erfahrungsbericht:** Bei Verbindungsabbrüchen lohnt sich fast immer zuerst die Frage nach dem Standort: Sitzt die Person in einem Grossraumbüro mit vielen anderen Bluetooth-Geräten in unmittelbarer Nähe, oder steht der PC in der Nähe eines WLAN-Access-Points? Beides stört das 2,4-GHz-Band und führt zu genau diesem Symptom, ohne dass am Gerät selbst etwas defekt ist. Ein einfacher Test: Gerät an einem anderen Arbeitsplatz koppeln – bleibt das Problem bestehen, liegt es am Gerät; verschwindet es, war es die Umgebung.

**Ursachenanalyse:**
- Batteriestand des Peripheriegeräts prüfen
- Prüfen, ob andere Bluetooth-/2,4-GHz-Geräte in unmittelbarer Nähe Störungen verursachen könnten
- Bluetooth-Treiber und Windows-Version auf Aktualität prüfen
- Bei USB-Dongle-Geräten: Dongle an einem anderen Port testen

**Lösungsschritte:**
1. Batterie des Geräts prüfen bzw. ersetzen.
2. Gerät im Bluetooth-Menü entfernen und neu koppeln.
3. Bluetooth-Treiber über den Geräte-Manager aktualisieren oder neu installieren.
4. Bei Dongle-Geräten: anderen USB-Port testen, idealerweise ohne direkt neben anderen USB-3.0-Geräten (können Störungen im 2,4-GHz-Band verursachen).
5. Gerät testweise an einem anderen Arbeitsplatz koppeln, um Umgebungsstörungen auszuschliessen.

**Eskalationskriterien:**
- Verbindungsabbrüche bestehen auch an einem anderen Arbeitsplatz mit neuer Batterie weiter → Hinweis auf Gerätedefekt

**Eskalation an:** Hardware-Team

---

## Remote-Support-Hinweise

Bei Drucker- und Peripherieproblemen ist der Anteil an Vor-Ort-Support höher als bei reinen Software-Themen, da viele Ursachen physischer Natur sind (Papierstau, Kabel, Verbrauchsmaterial):

- **Quick Assist / TeamViewer:** geeignet für alle Client-seitigen Schritte (Abschnitte 1, 2, 3, 6, 7 teilweise), z. B. Treiberinstallation, Spooler-Neustart, Portkonfiguration
- **Vor-Ort-Support nötig, wenn:**
  - Verbrauchsmaterial (Toner, Trommel, Papier) physisch geprüft oder ersetzt werden muss (Abschnitte 4, 5)
  - Ein Papierstau oder eine Fehlermeldung direkt am Gerät behoben werden muss (Abschnitt 5)
  - USB- oder Bluetooth-Hardware selbst getauscht werden muss (Abschnitte 7, 8)
  - Das Gerät über kein erreichbares Web-Interface verfügt und lokale Konfiguration nötig ist

**Faustregel:** Sobald die Ursache am Gerät selbst liegt und nicht am Client oder Netzwerk, lohnt sich meist der direkte Griff zum Vor-Ort-Support – Ferndiagnose bringt hier oft nur eine Verzögerung, bevor am Ende doch jemand vor Ort schauen muss.


---

## Verwandte Themen
- [Windows-Client-Probleme.md](./Windows-Client-Probleme.md)
- [Netzwerk-und-VPN.md](./Netzwerk-und-VPN.md)
- [Hardware-Diagnose.md](./Hardware-Diagnose.md)

## Changelog
| Datum | Änderung |
|---|---|
| 2026-08-07 | Erste Version |
