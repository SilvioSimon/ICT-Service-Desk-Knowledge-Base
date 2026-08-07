# Windows-Client-Probleme

**Tags:** `#windows` `#bsod` `#boot` `#performance` `#profil` `#update` `#servicedesk`

## Kurzbeschreibung
Sammlung der häufigsten Windows-Client-Probleme im Support-Alltag: langsame Systeme, Bluescreens (BSOD), Boot-Probleme, einfrierende Anwendungen, Profil-/Anmeldeprobleme, Windows-Update-Fehler und Anzeigeprobleme. Jeder Abschnitt folgt dem Schema Symptom → Ursachenanalyse → Lösungsschritte → Eskalationskriterien.

## Voraussetzungen
- Lokaler Administratorzugriff auf dem betroffenen Client
- Zugriff auf die Ereignisanzeige (`eventvwr.msc`)
- Ggf. Zugriff auf Active Directory / Intune für richtliniengesteuerte Probleme
- Bootfähiger USB-Stick mit Windows-Installationsmedium (für schwere Boot-Probleme)
- Zugriff auf Remote-Support-Tool (z. B. Quick Assist, TeamViewer) für Ferndiagnose

## Inhaltsverzeichnis
1. [Langsames System / hohe CPU- oder RAM-Auslastung](#1-langsames-system--hohe-cpu--oder-ram-auslastung)
2. [Bluescreen (BSOD)](#2-bluescreen-bsod)
3. [Boot-Probleme (System startet nicht)](#3-boot-probleme-system-startet-nicht)
4. [Einfrierende oder abstürzende Anwendungen](#4-einfrierende-oder-abstürzende-anwendungen)
5. [Profil- / Anmeldeprobleme](#5-profil--anmeldeprobleme)
6. [Windows-Update-Fehler](#6-windows-update-fehler)
7. [Schwarzer Bildschirm / Anzeigeprobleme](#7-schwarzer-bildschirm--anzeigeprobleme)
8. [Remote-Support-Hinweise](#remote-support-hinweise)

---

## 1. Langsames System / hohe CPU- oder RAM-Auslastung

**Priorität:** P3 (Standard)

**Symptom:** Anwendungen starten träge, System reagiert verzögert, Lüfter läuft dauerhaft hoch.

**Ursachenanalyse:**

- Zuerst den Task-Manager mit Strg + Umschalt + Esc öffnen und die Prozesse nach CPU, Arbeitsspeicher und Datenträger sortieren.
(`Strg+Umschalt+Esc`)
- Prüfen, ob ein einzelner Prozess dauerhaft hohe Auslastung verursacht (z. B. `svchost.exe`, Windows Search, Virenscanner, Browser mit vielen Tabs)
- Autostart-Programme prüfen (`Task-Manager → Autostart`)
- Datenträgerauslastung prüfen – bei 100 % Disk-Auslastung oft Hinweis auf fehlerhafte HDD/SSD oder Windows Update im Hintergrund
- Zuverlässigkeitsverlauf prüfen (`perfmon /rel`) für wiederkehrende Fehler und Absturzmuster über Zeit

**Lösungsschritte:**
1. Nicht benötigte Autostart-Programme deaktivieren
2. Windows Update-Verlauf prüfen, laufende Installationen abschliessen lassen
3. Datenträgerbereinigung ausführen: `cleanmgr.exe`
4. Bei Verdacht auf Malware: vollständigen Virenscan durchführen
5. Windows Search Index neu aufbauen, falls `SearchIndexer.exe` dauerhaft hohe Last verursacht
6. Treiber (v. a. Chipsatz, SSD-Controller) auf Aktualität prüfen

**Praxishinweis**

Im Service Desk sind Browser mit vielen Tabs und Sicherheitssoftware die häufigsten Ursachen für hohe CPU- oder RAM-Auslastung. Deshalb diese Punkte zuerst prüfen.

**Eskalationskriterien:**
- Auslastung bleibt nach allen Massnahmen dauerhaft > 90 %
- Verdacht auf Hardwaredefekt (S.M.A.R.T.-Fehler im Datenträger)
- Wiederkehrendes Verhalten nach Neuinstallation
- **Eskalation an:** 2nd-Level-Support / Hardware-Team (bei S.M.A.R.T.-Fehlern)

---

## 2. Bluescreen (BSOD)

**Priorität:** P2

**Symptom:** System stürzt mit blauem Bildschirm ab, meist mit einem Fehlercode (z. B. `IRQL_NOT_LESS_OR_EQUAL`, `MEMORY_MANAGEMENT`, `KERNEL_SECURITY_CHECK_FAILURE`).

**Ursachenanalyse:**
- Fehlercode notieren oder Foto machen, bevor das System neu startet
- Ereignisanzeige öffnen → `Windows-Protokolle → System` → nach Einträgen mit Quelle „BugCheck" oder „Kernel-Power" suchen
- Speicherabbild analysieren, falls vorhanden: `C:\Windows\Minidump\`
- Häufige Ursachen: fehlerhafte/inkompatible Treiber, defekter RAM, überhitzte Hardware, fehlerhafte Windows Updates

**Häufige Fehlercodes (Übersicht):**

| Fehlercode | Typische Ursache |
|---|---|
| `IRQL_NOT_LESS_OR_EQUAL` | Fehlerhafter/inkompatibler Treiber, meist Netzwerk- oder Grafiktreiber |
| `MEMORY_MANAGEMENT` | Defekter RAM oder fehlerhafter Treiber |
| `KERNEL_SECURITY_CHECK_FAILURE` | Beschädigte Systemdateien oder inkompatible Treiber |
| `PAGE_FAULT_IN_NONPAGED_AREA` | Defekter RAM, fehlerhafter Treiber oder Datenträgerfehler |
| `CRITICAL_PROCESS_DIED` | Beschädigte Systemdateien, fehlgeschlagenes Update |
| `SYSTEM_SERVICE_EXCEPTION` | Treiberkonflikt, oft nach Grafiktreiber-Update |
| `DPC_WATCHDOG_VIOLATION` | Storage-Treiber (SSD/NVMe) oder fehlerhafte Firmware |
| `WHEA_UNCORRECTABLE_ERROR` | Hardwarefehler (CPU, RAM, Mainboard), oft Überhitzung |
| `VIDEO_TDR_FAILURE` | Grafiktreiber reagiert nicht / stürzt ab |
| `UNEXPECTED_KERNEL_MODE_TRAP` | Defekte Hardware, häufig RAM oder CPU |

**Lösungsschritte:**

(1st Level)

1. Windows-Speicherdiagnose ausführen: mdsched.exe
2. Gerätetreiber prüfen, insbesondere Grafik-, Chipsatz- und Netzwerktreiber.
3. Kürzlich installierte Updates oder Software prüfen und bei zeitlichem Zusammenhang testweise deinstallieren.

(2nd Level)

4. Systemwiederherstellung durchführen.
5. RAM einzeln testen.
6 .Temperaturen und Hardwarezustand prüfen.

**Eskalationskriterien:**
- Bluescreens treten wiederholt trotz Treiber-/Update-Bereinigung auf
- Speicherdiagnose meldet Fehler → Hardware-Austausch nötig
- Gerät fällt unter Garantie/Wartungsvertrag → Hersteller-Support kontaktieren
- **Eskalation an:** 2nd-Level-Support (Minidump-Analyse) bzw. Hardware-Team / Hersteller-Support bei bestätigtem Hardwaredefekt

---

## 3. Boot-Probleme (System startet nicht)

**Priorität:** P1

**Symptom:** Der PC startet nicht korrekt. Häufig bleibt er beim Herstellerlogo hängen, meldet „Kein Startgerät gefunden“ oder startet immer wieder in die Wiederherstellung.

**Ursachenanalyse:**
- Fehlermeldung genau notieren
- Prüfen, ob es sich um ein Software- (Bootloader, Systemdateien) oder Hardwareproblem (Datenträger, Kabel, BIOS-Einstellung) handelt
- Bootreihenfolge im BIOS/UEFI prüfen

**Erfahrungsbericht:**
Bei Boot-Problemen lohnt es sich, am Telefon einfach mal offen zu fragen: "Was ist zuletzt passiert, bevor das Gerät so reagiert hat?" Man hört dann öfter Sachen wie "ist mir runtergefallen" oder "hat komisch geklickt, bevor der Bildschirm schwarz wurde" – und dann weiss man eigentlich schon, dass es wahrscheinlich Richtung Hardware geht, bevor man überhaupt mit bootrec anfängt. Umgekehrt: Kam kurz vorher ein Update oder ein Stromausfall, ist die Chance ziemlich gut, dass es mit den Standardschritten unten gelöst werden kann. Diese eine Frage am Anfang spart oft eine halbe Stunde Herumprobieren.

**Lösungsschritte:**
1. Automatische Reparatur über Windows-Wiederherstellungsumgebung (WinRE) ausführen
2. Kommandozeile in WinRE öffnen und prüfen:
   ```
   bootrec /fixmbr
   bootrec /fixboot
   bootrec /rebuildbcd
   ```
3. Systemdateien auf Beschädigung prüfen (von einem funktionierenden Wiederherstellungsmedium):
   ```
   sfc /scannow
   chkdsk C: /f /r
   ```
4. WinRE nicht erreichbar?: Mit einem Windows-Installationsmedium starten und die Reparaturoptionen verwenden.
5. Wenn keine Reparatur möglich ist: Daten sichern (falls erreichbar) und Neuinstallation vorbereiten.

**Hinweis zu BitLocker:** Ist das Laufwerk verschlüsselt, wird häufig der BitLocker-Recovery-Key benötigt. Vor einer Eskalation zuerst prüfen:

- Entra ID / Azure AD: Gerät → BitLocker-Wiederherstellungsschlüssel
- Intune: Gerät → Wiederherstellungsschlüssel
- Microsoft-Konto des Benutzers: https://account.microsoft.com/devices/recoverykey (`account.microsoft.com/devices/recoverykey`)

**Eskalationskriterien:**
- Datenträger wird im BIOS gar nicht erkannt → Hardwaredefekt, Datenrettung ggf. nötig
- Wiederherstellungsversuche schlagen wiederholt fehl
- Verschlüsselung (BitLocker) verhindert Zugriff und Recovery Key ist nicht auffindbar
- **Eskalation an:** 2nd-Level-Support (sofort bei Produktivsystemen), Hardware-Team bei Datenträger defekt, Security-Team falls Recovery Key nicht auffindbar

---

## 4. Einfrierende oder abstürzende Anwendungen

**Priorität:** P3

**Symptom:** Einzelne Programme reagieren nicht mehr („Keine Rückmeldung") oder stürzen wiederholt ab.

**Ursachenanalyse:**
- Prüfen, ob das Problem nur eine Anwendung oder das gesamte System betrifft
- Ereignisanzeige → „Windows-Protokolle → Anwendung" nach Fehlern der betroffenen Anwendung durchsuchen
- Zuverlässigkeitsverlauf (`perfmon /rel`) als übersichtliche Alternative zur Ereignisanzeige nutzen, um Absturzhäufigkeit und zeitlichen Zusammenhang mit Updates/Installationen zu erkennen
- Prüfen, ob genügend freier Speicherplatz und RAM vorhanden ist

**Lösungsschritte:**
1. Anwendung über Task-Manager beenden und neu starten
2. Anwendung auf aktuelle Version prüfen / aktualisieren
3. Programmcache/-konfiguration zurücksetzen (anwendungsspezifisch, z. B. Outlook-Profil neu anlegen)
4. Kompatibilitätsmodus testen, falls ältere software auf neuem Windows läuft
5. Anwendung deinstallieren und sauber neu installieren

**Eskalationskriterien:**
- Problem tritt bei mehreren Nutzenden mit derselben Anwendung auf → Hinweis auf zentrales Problem (z. B. fehlerhaftes Softwarepaket, GPO)
- Nach Neuinstallation weiterhin instabil → Weiterleitung an Applikationsverantwortliche/Hersteller
- **Eskalation an:** Applikationsverantwortliche/-team; bei GPO-Verdacht an AD/Intune-Team

---

## 5. Profil- / Anmeldeprobleme

**Priorität:** P2

**Symptom:** Anmeldung dauert ungewöhnlich lange, Meldung „Temporäres Profil wird geladen", Desktop-Einstellungen/Dateien fehlen nach dem Login, oder Anmeldung schlägt ganz fehl.

**Ursachenanalyse:**
- Ereignisanzeige → `Windows-Protokolle → Anwendung` nach Einträgen mit Quelle „User Profile Service" durchsuchen
- Prüfen, ob es sich um ein lokales Profil oder ein servergespeichertes/ roaming Profil handelt
- Prüfen, ob das Problem nur bei einem Nutzenden oder bei mehreren auftritt (Hinweis auf zentrales Problem, z. B. Fileserver/GPO)
- Registry prüfen: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList` auf doppelte oder mit `.bak` markierte Profil-Einträge

**Lösungsschritte:**
1. Neustart und erneuter Anmeldeversuch. (schliesst Netzwerk-/Timing-Probleme aus)
2. Bei „Temporäres Profil": Registry-Einträge unter `ProfileList` auf fehlerhafte SID-Einträge (`.bak`) prüfen und bereinigen, danach Neustart
3. Bei Roaming-Profilen: Netzwerkverbindung zum Domain Controller bzw. Profil-Server kontrollieren
4. Lokales Profil-Backup erstellen (Dokumente, Desktop,Browserdaten), beschädigtes Profil löschen und bei nächster Anmeldung neu erstellen lassen.
5. Bei Domänenproblemen: Vertrauensstellung zur Domäne prüfen (`Test-ComputerSecureChannel` in PowerShell), ggf. Client neu der Domäne beitreten lassen

**Eskalationskriterien:**
- Problem betrifft mehrere Nutzende gleichzeitig → Hinweis auf Server-/Infrastrukturproblem
- Roaming-Profil lässt sich nicht synchronisieren trotz funktionierender Netzwerkverbindung
- Vertrauenssstellung zur Domäne wiederholt gestört
- **Eskalation an:** AD/Identity-Team bei Domänen-/Vertrauensstellungsproblemen, Server-Team bei Roaming-Profil-/Fileserver-Problemen

---

## 6. Windows-Update-Fehler

**Priorität:** P3

**Symptom:** Updates bleiben bei einem bestimmten Prozentsatz hängen, schlagen mit Fehlercode fehl (z. B. `0x800f0922`, `0x80070002`, `0x8024402f`) oder wiedreholen sich endlos, ohne je durchzulaufen.

**Ursachenanalyse:**
- Windows-Update-Verlauf prüfen: `Einstellungen → Windows Update → Updateverlauf`
- Fehlercode notieren
- Prüfen, ob genügend freier Speicherplatz vorhanden ist (Updates benötigen oft mehrere GB)
- Prüfen, ob es sich um ein Einzelgerät oder mehrere Geräte handelt (Hinweis auf WSUS/Intune-Konfigurationsproblem)

**Lösungsschritte:**
1. Windows Update-Problembehandlung ausführen: `Einstellungen → System → Problembehandlung → Andere Problembehandlungen → Windows Update`
2. Update-Cache zurücksetzen (Dienste `wuauserv`, `bits`, `cryptsvc` stoppen, Ordner `C:\Windows\SoftwareDistribution` und `C:\Windows\System32\catroot2` umbenennen, Dienste neu starten)
3. Systemdateien prüfen: `sfc /scannow` und `DISM /Online /Cleanup-Image /RestoreHealth`
4. Bei WSUS/Intune-verwalteten Geräten: Richtlinien-Zuweisung und Wartungsfenster prüfen
5. Update manuell über den Microsoft Update Catalog herunterladen und installieren (falls automatischer Weg wiederholt scheitert)

**Eskalationskriterien:**
- Der Fehler tritt bei mehreren Geräten gleichzeitig auf → spricht für ein WSUS-/Intune-Konfigurationsproblem, nicht für einen Einzelfall
- Update läst sich auch nach Cache-Reset und DISM/SFC nicht installieren
- **Eskalation an:** Client-Management-Team (WSUS/Intune) bei Massenproblemen

---

## 7. Schwarzer Bildschirm / Anzeigeprobleme

**Priorität:** P2

**Symptom:** Der Bildschirm bleibt nach dem Einschalten oder nach einem Update schwarz. Teilweise ist noch ein Mauszeiger sichtbar, die Anzeige flackert oder ein externer Monitor wird nicht erkannt. Wichtig: Das Gerät kann im Hintergrund weiterlaufen. Dadurch unterscheidet sich dieses Problem von einem echten Boot-Problem.

**Ursachenanalyse:**
- Reagiert der PC noch? Caps-Lock-LED, Lüftergeräusch oder Netzwerkverbindung prüfen.
- Prüfen, ob das Problem nach einem Windows- oder Grafiktreiber-Update aufgetreten ist
- Monitor, Kabel und Anschluss kontrollieren und falls möglich zweiten Monitor testen, um Hardware auszuschliessen

**Lösungsschritte:**

1. Tastenkombination Windows `Windows-Taste + Strg + Umschalt + B` drücken. Dadurch wird der Grafiktreiber neu initialisiert.
2. Gerät neu starten und prüfen, ob die Anzeige wieder erscheint.
3. Falls Remote-Zugriff möglich ist, prüfen, ob Windows im Hintergrund normal läuft.
4. Im abgesicherten Modus starten und den Grafiktreiber zurücksetzen oder deinstallieren.
5. Grafiktreiber direkt vom Hersteller (Intel, AMD oder NVIDIA) neu installieren.
6. Monitor und Kabel testweise austauschen.

**Eskalationskriterien:**
- Problem besteht auch im abgesicherten Modus → Hinweis auf Hardwaredefekt (Grafikkarte/Display)
- Tritt nach demselben Update bei mehreren Geräten auf → zentrales Treiber-/Update-Problem
- **Eskalation an:** Hardware-Team bei bestätigtem Defekt, Client-Management-Team bei zentralem Treiberproblem

---

## Remote-Support-Hinweise

Für die meisten der oben genannten Probleme kann die Erstdiagnose remote erfolgen, was Reaktionszeit spart und Vor-Ort-Termine reduziert:

- **Quick Assist** (in Windows integriert): geeignet für einfache Nutzer-geführte Diagnosen (Abschnitte 1, 4, 5, 7), da keine Zusatzsoftware nötig ist
- **TeamViewer / vergleichbares Tool:** geeignet für tiefergehende Eingriffe, unbeaufsichtigten Zugriff oder wenn der Nutzende selbst nicht am Gerät ist
- **Vor-Ort-Support nötig, wenn:**
  - Das System nicht mehr bootet (Abschnitt 3) und kein Remote-Zugriff möglich ist
  - Hardwarekomponenten physisch geprüft/getauscht werden müssen (RAM, Datenträger, Kabel)
  - Kein Netzwerkzugriff auf dem betroffenen Gerät besteht

**Faustregel:** Bei P1-Fällen ohne Netzwerkverbindung (z. B. Boot-Probleme) sofort Vor-Ort-Support statt Remote-Diagnose einplanen, um Zeit zu sparen.

---


## Verwandte Themen
- [Drucker-und-Peripherie.md](./Drucker-und-Peripherie.md)
- [Netzwerk-und-VPN.md](./Netzwerk-und-VPN.md)
- [Hardware-Diagnose.md](./Hardware-Diagnose.md)
- [../03-Windows-Administration/Registry-Troubleshooting.md](../03-Windows-Administration/Registry-Troubleshooting.md)

## Changelog
| Datum | Änderung |
|---|---|
| 2026-08-07 | Neue Abschnitte: Profil-/Anmeldeprobleme, Windows-Update-Fehler, Schwarzer Bildschirm/Anzeigeprobleme, Remote-Support-Hinweise. BSOD-Fehlercode-Tabelle ergänzt. Inhaltsverzeichnis, Prioritäten, Eskalations-Zielgruppen und Tags hinzugefügt. |
| 2026-08-06 | Erste Version |
