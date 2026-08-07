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

---

## Verwandte Themen
- [Windows-Client-Probleme.md](./Windows-Client-Probleme.md)
- [Netzwerk-und-VPN.md](./Netzwerk-und-VPN.md)
- [Hardware-Diagnose.md](./Hardware-Diagnose.md)

## Changelog
| Datum | Änderung |
|---|---|
| 2026-08-07 | Erste Version |
