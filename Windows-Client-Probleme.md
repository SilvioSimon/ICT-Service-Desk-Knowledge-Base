# Windows-Client-Probleme

## Kurzbeschreibung
Sammlung der häufigsten Windows-Client-Probleme im Support-Alltag: langsame Systeme, Bluescreens (BSOD), Boot-Probleme und einfrierende Anwendungen. Jeder Abschnitt folgt dem Schema Symptom → Ursachenanalyse → Lösungsschritte → Eskalationskriterien.

## Voraussetzungen
- Lokaler Administratorzugriff auf dem betroffenen Client
- Zugriff auf die Ereignisanzeige (`eventvwr.msc`)
- Ggf. Zugriff auf Active Directory / Intune für richtliniengesteuerte Probleme
- Bootfähiger USB-Stick mit Windows-Installationsmedium (für schwere Boot-Probleme)

---

## 1. Langsames System / hohe CPU- oder RAM-Auslastung

**Symptom:** Anwendungen starten träge, System reagiert verzögert, Lüfter läuft dauerhaft hoch.

**Ursachenanalyse:**
- Task-Manager (`Strg+Umschalt+Esc`) öffnen → Reiter „Prozesse" nach CPU/RAM/Datenträger sortieren
- Prüfen, ob ein einzelner Prozess dauerhaft hohe Auslastung verursacht (z. B. `svchost.exe`, Windows Search, Virenscanner, Browser mit vielen Tabs)
- Autostart-Programme prüfen (`Task-Manager → Autostart`)
- Datenträgerauslastung prüfen – bei 100 % Disk-Auslastung oft Hinweis auf fehlerhafte HDD/SSD oder Windows Update im Hintergrund

**Lösungsschritte:**
1. Nicht benötigte Autostart-Programme deaktivieren
2. Windows Update-Verlauf prüfen, laufende Installationen abschliessen lassen
3. Datenträgerbereinigung ausführen: `cleanmgr.exe`
4. Bei Verdacht auf Malware: vollständigen Virenscan durchführen
5. Windows Search Index neu aufbauen, falls `SearchIndexer.exe` dauerhaft hohe Last verursacht
6. Treiber (v. a. Chipsatz, SSD-Controller) auf Aktualität prüfen

**Eskalationskriterien:**
- Auslastung bleibt nach allen Massnahmen dauerhaft > 90 %
- Verdacht auf Hardwaredefekt (S.M.A.R.T.-Fehler im Datenträger)
- Wiederkehrendes Verhalten nach Neuinstallation

---

## 2. Bluescreen (BSOD)

**Symptom:** System stürzt mit blauem Bildschirm ab, meist mit einem Fehlercode (z. B. `IRQL_NOT_LESS_OR_EQUAL`, `MEMORY_MANAGEMENT`, `KERNEL_SECURITY_CHECK_FAILURE`).

**Ursachenanalyse:**
- Fehlercode notieren oder Foto machen, bevor das System neu startet
- Ereignisanzeige öffnen → `Windows-Protokolle → System` → nach Einträgen mit Quelle „BugCheck" oder „Kernel-Power" suchen
- Speicherabbild analysieren, falls vorhanden: `C:\Windows\Minidump\`
- Häufige Ursachen: fehlerhafte/inkompatible Treiber, defekter RAM, überhitzte Hardware, fehlerhafte Windows Updates

**Lösungsschritte:**
1. Windows-Speicherdiagnose ausführen: `mdsched.exe`
2. Neueste Gerätetreiber prüfen, insbesondere Grafik-, Chipsatz- und Netzwerktreiber
3. Kürzlich installierte Updates oder Software identifizieren und ggf. deinstallieren
4. Systemwiederherstellung auf einen früheren Zeitpunkt durchführen, falls verfügbar
5. Bei Verdacht auf Hardwaredefekt: RAM einzeln testen, Temperaturen prüfen

**Eskalationskriterien:**
- Bluescreens treten wiederholt trotz Treiber-/Update-Bereinigung auf
- Speicherdiagnose meldet Fehler → Hardware-Austausch nötig
- Gerät fällt unter Garantie/Wartungsvertrag → Hersteller-Support kontaktieren

---

## 3. Boot-Probleme (System startet nicht)

**Symptom:** System bleibt beim Logo hängen, zeigt „Kein Startgerät gefunden" oder landet in einer Wiederherstellungsschleife.

**Ursachenanalyse:**
- Fehlermeldung genau notieren
- Prüfen, ob es sich um ein Software- (Bootloader, Systemdateien) oder Hardwareproblem (Datenträger, Kabel, BIOS-Einstellung) handelt
- Bootreihenfolge im BIOS/UEFI prüfen

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
4. Falls kein Zugriff auf WinRE möglich: Installationsmedium verwenden und Reparaturinstallation starten
5. Als letzter Schritt: Datensicherung (falls möglich) und Neuinstallation

**Eskalationskriterien:**
- Datenträger wird im BIOS gar nicht erkannt → Hardwaredefekt, Datenrettung ggf. nötig
- Wiederherstellungsversuche schlagen wiederholt fehl
- Verschlüsselung (BitLocker) verhindert Zugriff und Recovery Key ist nicht auffindbar

---

## 4. Einfrierende oder abstürzende Anwendungen

**Symptom:** Einzelne Programme reagieren nicht mehr („Keine Rückmeldung") oder stürzen wiederholt ab.

**Ursachenanalyse:**
- Prüfen, ob das Problem nur eine Anwendung oder das gesamte System betrifft
- Ereignisanzeige → „Windows-Protokolle → Anwendung" nach Fehlern der betroffenen Anwendung durchsuchen
- Prüfen, ob genügend freier Speicherplatz und RAM vorhanden ist

**Lösungsschritte:**
1. Anwendung über Task-Manager beenden und neu starten
2. Anwendung auf aktuelle Version prüfen / aktualisieren
3. Programmcache/-konfiguration zurücksetzen (anwendungsspezifisch, z. B. Outlook-Profil neu anlegen)
4. Kompatibilitätsmodus testen, falls ältere Software auf neuem Windows läuft
5. Anwendung deinstallieren und sauber neu installieren

**Eskalationskriterien:**
- Problem tritt bei mehreren Nutzenden mit derselben Anwendung auf → Hinweis auf zentrales Problem (z. B. fehlerhaftes Softwarepaket, GPO)
- Nach Neuinstallation weiterhin instabil → Weiterleitung an Applikationsverantwortliche/Hersteller

---

## Verwandte Themen
- [Drucker-und-Peripherie.md](./Drucker-und-Peripherie.md)
- [Netzwerk-und-VPN.md](./Netzwerk-und-VPN.md)
- [Hardware-Diagnose.md](./Hardware-Diagnose.md)
- [../03-Windows-Administration/Registry-Troubleshooting.md](../03-Windows-Administration/Registry-Troubleshooting.md)

## Letzte Aktualisierung
2026-08-06
