<div align="center">

# 🖥️ ICT Service Desk Knowledge Base (Deutsch)

**Persönliche Wissensdatenbank für den Aufbau von IT-Support-Know-how**

Troubleshooting-Guides · Standard Operating Procedures (SOPs) · Windows-Administration · Microsoft 365 · Netzwerktechnik · PowerShell

[![Maintenance](https://img.shields.io/badge/Maintained-yes-brightgreen.svg)](#)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](#-lizenz)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-orange.svg)](#-mitwirken)
[![Markdown](https://img.shields.io/badge/Format-Markdown-informational.svg)](#)

</div>

---

## 📖 Über dieses Projekt

Diese Knowledge Base ist eine strukturierte Sammlung von Dokumentationen, Anleitungen und Lösungswegen rund um typische Aufgaben eines IT Service Desk / First & Second Level Support. Ziel ist es, wiederkehrende Probleme, Standardprozesse und technisches Wissen an einem zentralen Ort festzuhalten — als Nachschlagewerk und Lernressource für alle, die sich mit IT-Support-Themen beschäftigen.

Die Inhalte entstehen durch eigene Recherche, Lernprojekte und den Aufbau praxisnaher Dokumentation und werden laufend erweitert, korrigiert und aktualisiert.

> 💡 **Hinweis:** Alle Inhalte sind allgemeingültig und übertragbar gehalten und enthalten keinerlei unternehmensspezifische oder vertrauliche Informationen.

---

## 🎯 Ziele der Knowledge Base

- ⚡ **Schnellere Lösungszeiten (MTTR)** durch dokumentierte, geprüfte Lösungswege
- 📚 **Wissenssicherung** – Erfahrungswissen geht nicht verloren, wenn es aufgeschrieben ist
- 🔁 **Konsistenz** – gleiche Probleme werden nach dem gleichen Standard gelöst
- 🧑‍🏫 **Onboarding-Hilfe** für neue Support-Mitarbeitende
- 🛠️ **Selbstlernressource** zur Vertiefung von Windows-, M365-, Netzwerk- und Scripting-Kenntnissen

---

## 🗂️ Struktur des Repositories

```
ICT-Service-Desk-Knowledge-Base/
│
├── 📁 01-Troubleshooting-Guides/
│   ├── Windows-Client-Probleme.md
│   ├── Drucker-und-Peripherie.md
│   ├── Netzwerk-und-VPN.md
│   ├── Outlook-und-Mail.md
│   └── Hardware-Diagnose.md
│
├── 📁 02-SOPs (Standard Operating Procedures)/
│   ├── Onboarding-neuer-Mitarbeitender.md
│   ├── Offboarding-Prozess.md
│   ├── Passwort-Reset-Verfahren.md
│   ├── Ticket-Eskalationsprozess.md
│   └── Asset-Management.md
│
├── 📁 03-Windows-Administration/
│   ├── Active-Directory-Grundlagen.md
│   ├── Gruppenrichtlinien-GPO.md
│   ├── Imaging-und-Deployment.md
│   ├── Update-Management-WSUS.md
│   └── Registry-Troubleshooting.md
│
├── 📁 04-Microsoft-365/
│   ├── Exchange-Online-Verwaltung.md
│   ├── Teams-Administration.md
│   ├── SharePoint-und-OneDrive.md
│   ├── Intune-Geraeteverwaltung.md
│   ├── Lizenzmanagement.md
│   └── Multi-Faktor-Authentifizierung.md
│
├── 📁 05-Netzwerktechnik/
│   ├── TCP-IP-Grundlagen.md
│   ├── DNS-und-DHCP.md
│   ├── VPN-Konfiguration.md
│   ├── WLAN-Troubleshooting.md
│   └── Firewall-Grundlagen.md
│
├── 📁 06-PowerShell/
│   ├── Nuetzliche-Cmdlets.md
│   ├── AD-Automatisierung.ps1
│   ├── M365-Bulk-Operationen.ps1
│   ├── System-Diagnose-Skripte.ps1
│   └── Reporting-Skripte.ps1
│
├── 📁 assets/
│   └── screenshots, diagrams, etc.
│
├── LICENSE
└── README.md
```

---

## 🔧 Inhaltliche Schwerpunkte

### 🩺 1. Troubleshooting-Guides
Strukturierte Schritt-für-Schritt-Anleitungen zur Fehlerdiagnose und -behebung, u. a.:
- Windows-Bluescreens, Boot-Probleme, Performance-Issues
- Drucker- und Peripheriefehler (Treiber, Spooler, Netzwerkdrucker)
- Netzwerkverbindungsprobleme, VPN-Verbindungsabbrüche
- Outlook-Synchronisationsfehler, PST/OST-Probleme
- Hardware-Diagnose (RAM, Festplatte, Peripheriegeräte)

Jeder Guide folgt einem einheitlichen Aufbau: **Symptom → Ursachenanalyse → Lösungsschritte → Eskalationskriterien**.

### 📋 2. Standard Operating Procedures (SOPs)
Klar definierte, wiederholbare Prozesse für Routineaufgaben:
- On- und Offboarding von Mitarbeitenden (Accounts, Hardware, Zugriffsrechte)
- Passwort-Reset- und Account-Entsperrungsverfahren
- Ticket-Priorisierung und Eskalationswege (ITIL-orientiert)
- Asset- und Lizenzverwaltung

### 🪟 3. Windows-Administration
- Active Directory (Benutzer, Gruppen, OUs)
- Gruppenrichtlinien (GPOs) – Erstellung, Troubleshooting, Best Practices
- Client-Imaging und Softwareverteilung
- Patch- und Updatemanagement (WSUS)
- Registry-Eingriffe und Systemreparatur

### ☁️ 4. Microsoft 365
- Exchange Online: Postfächer, Verteilerlisten, Freigaben
- Teams-Administration und Troubleshooting
- SharePoint & OneDrive: Berechtigungen, Synchronisationsprobleme
- Intune: Geräteregistrierung, Compliance-Richtlinien, Autopilot
- Lizenzmanagement und MFA-Konfiguration

### 🌐 5. Netzwerktechnik
- TCP/IP-Grundlagen und Subnetting
- DNS- und DHCP-Troubleshooting
- VPN-Einrichtung und -Fehlerbehebung
- WLAN-Diagnose
- Firewall- und Portfreigaben-Grundlagen

### ⚙️ 6. PowerShell
Skripte und Cmdlet-Sammlungen zum Lernen und Anpassen:
- Automatisierte Benutzerverwaltung in AD und Entra ID
- Bulk-Operationen in Microsoft 365
- Systemdiagnose und automatisiertes Reporting
- Wiederkehrende administrative Aufgaben

---

## 🚀 Verwendung

1. Repository klonen oder herunterladen:
   ```bash
   git clone https://github.com/SilvioSimon/ICT-Service-Desk-Knowledge-Base.git
   ```
2. Über die Ordnerstruktur zum passenden Themenbereich navigieren.
3. Guides und SOPs direkt als Markdown lesen (GitHub rendert sie automatisch) oder lokal in einem Editor deiner Wahl (z. B. VS Code, Obsidian) öffnen.
4. PowerShell-Skripte vor dem produktiven Einsatz immer zuerst in einer Testumgebung prüfen und ggf. anpassen (Variablen, Domänennamen, Pfade).

> ⚠️ **Wichtig:** Skripte und Anleitungen sind allgemein gehalten und müssen an die jeweilige Systemumgebung angepasst werden. Keine Garantie auf Vollständigkeit oder Fehlerfreiheit – produktiver Einsatz auf eigene Verantwortung.

---

## 🧭 Konventionen & Formatstandards

Damit die Knowledge Base einheitlich und durchsuchbar bleibt, folgen alle Dokumente diesem Schema:

| Element | Beschreibung |
|---|---|
| **Titel** | Klar benannt, Thema sofort erkennbar |
| **Kurzbeschreibung** | 1–2 Sätze zum Anwendungsfall |
| **Voraussetzungen** | Benötigte Rechte, Tools, Zugänge |
| **Schritt-für-Schritt-Anleitung** | Nummeriert, nachvollziehbar |
| **Häufige Fehler** | Bekannte Stolpersteine |
| **Verwandte Themen** | Querverweise auf andere Dokumente |
| **Letzte Aktualisierung** | Datum der letzten Überarbeitung |

---

## 🤝 Mitwirken

Feedback, Korrekturen und Ergänzungen sind willkommen! So kannst du beitragen:

1. Repository forken
2. Neuen Branch erstellen (`git checkout -b feature/neuer-guide`)
3. Änderungen committen (`git commit -m "Neuer Guide: XYZ"`)
4. Branch pushen (`git push origin feature/neuer-guide`)
5. Pull Request eröffnen

Bitte bestehende Formatkonventionen (siehe oben) einhalten.

---

## ⚖️ Haftungsausschluss

Diese Knowledge Base dient ausschliesslich zu Informations- und Lernzwecken. Sämtliche Inhalte sind allgemein gehalten und enthalten keine vertraulichen Unternehmens- oder Kundendaten. Für die Richtigkeit, Vollständigkeit oder Aktualität der Inhalte wird keine Gewähr übernommen. Der Einsatz von Skripten und Konfigurationen in produktiven Umgebungen erfolgt auf eigene Verantwortung.

---

## 📄 Lizenz

Dieses Projekt steht unter der [MIT-Lizenz](LICENSE) – freie Nutzung, Veränderung und Weitergabe unter Namensnennung.

---

## 👤 Über dieses Repository

Diese Knowledge Base wird kontinuierlich gepflegt und erweitert, mit Fokus auf Windows-Administration, Microsoft 365, Netzwerktechnik und PowerShell-Automatisierung.

📫 Fragen, Anregungen oder Feedback? Gerne über Issues oder Pull Requests.

---

<div align="center">

⭐ **Wenn dir diese Knowledge Base weiterhilft, lass gerne einen Stern da!** ⭐

</div>
