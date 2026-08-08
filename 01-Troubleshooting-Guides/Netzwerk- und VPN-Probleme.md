# Netzwerk- und VPN-Probleme

**Tags:** `#netzwerk` `#vpn` `#wlan` `#dns` `#firewall` `#netzlaufwerk` `#servicedesk`

## Kurzbeschreibung
Sammlung der häufigsten Netzwerk- und VPN-Probleme im Support-Alltag: fehlgeschlagene oder abbrechende VPN-Verbindungen, nicht erreichbare Netzlaufwerke,WLAN-Probleme, langsame Verbindungen, DNS-Fehler, IP-Adresskonflikte und Firewall-/Portblockierungen. Jeder Abschnitt folgt dem Schema Symptom → Ursachenanalyse → Lösungsschritte → Eskalationskriterien.

## Voraussetzungen
- Lokaler Administratorzugriff auf dem betroffenen Client
- Zugriff auf die Kommandozeile ( `ipconfig`, `ping`, `tracert`, `nslookup`)
- Kenntnis des verwendeten VPN-Clients (z. B. Cisco AnyConnect, FortiClient, Windows-eigenes VPN) und der Zugangsdaten/Zertifikate
- Ggf.Zugriff auf Active Directory/ Intune für richtliniengesteuerte Netzwerkprofile
- Zugriff auf Remote-Support-Tool (z. B. Quick Assist, TeamViewer) – funktioniert bei VPN-Problemen nur, solange noch eine Basisverbindung besteht

## Inhaltsverzeichnis
1. [VPN-Verbindung schlägt fehl oder bricht ab](#1-vpn-verbindung-schlägt-fehl-oder-bricht-ab)
2. [Netzlaufwerke nicht erreichbar](#2-netzlaufwerke-nicht-erreichbar)
3. [WLAN-Verbindungsprobleme](#3-wlan-verbindungsprobleme)
4. [Langsame Netzwerkverbindung / hohe Latenz](#4-langsame-netzwerkverbindung--hohe-latenz)
5. [DNS-Probleme (Internet da, Webseiten nicht erreichbar)](#5-dns-probleme-internet-da-webseiten-nicht-erreichbar)
6. [IP-Adresskonflikt / keine IP-Adresse erhalten](#6-ip-adresskonflikt--keine-ip-adresse-erhalten)
7. [Firewall-/Portblockierungen](#7-firewall--portblockierungen)
8. [Remote-Support-Hinweise](#remote-support-hinweise)

---

## 1. VPN-Verbindung schlägt fehl oder bricht ab

**Priorität:** P2

**Symptom:** Der VPN-Client meldet einen Verbindungsfehler, bleibt beim Verbindungsaufbau hängen, oder die Verbindung bricht nach einigen Minuten wieder ab.

**Erfahrungsbericht:** Bei VPN-Tickets zahlt es sich fast immer aus, zuerst zu fragen, wo genau die Person gerade sitzt – Heimnetz, Hotel-WLAN, Mobile-Hotspot oder ein anderes Firmennetz. Viele Heimrouter blockieren standardmässig genau die Protokolle, die VPN-Clients brauchen (v. a. IPsec/IKEv2), oder ein doppeltes NAT beim Provider sorgt für Instabilität. Bevor man sich also in Zertifikate und Client-Logs vertieft, lohnt sich der schnelle Test: Funktioniert die Verbindung über einen Mobile-Hotspot? Wenn ja, liegt es sehr wahrscheinlich am Heimnetzwerk und nicht am Client oder am Gerät.

**Ursachenanalyse:**
- Genaue Fehlermeldung des VPN-Clients notieren (Code oder Text)
- Prüfen, von welchem Netzwerk aus die Verbindung aufgebaut wird (Heimnetz, öffentliches WLAN, Mobile-Hotspot)
- Gültigkeit von Zertifikat bzw. Zugangsdaten prüfen, insbesondere bei zeitlich befristeten Client-Zertifikaten
- Client-Logs des VPN-Programms auf wiederkehrende Fehler prüfen
- Prüfen, ob das Problem nur bei einer Person oder bei mehreren gleichzeitig auftritt

**Lösungsschritte:**
1. VPN-Client vollständig beenden und neu starten
2. Internetverbindung ohne VPN testen (z. B. Webseite aufrufen),  um Basiskonnektivität auszuschliessen.
3. Verbindung über ein alternatives Netzwerk (z. B. Mobile-Hotspot) testen, um Heimnetz-Blockaden zu erkennen.
4. Datum/Uhrzeit des Geräts prüfen – falsche Systenzeit führt häufig zu Zertifikatsfehlern
5. VPN-Client neu installieren bzw. auf aktuelle Version aktualisieren.
6. Bei zertifikatsbasierter Anmeldung: Zertifikat auf Gültigkeit und korrekten Speicherort prüfen, bei Bedarf neu ausstellen lassen.

**Eskalationskriterien:**
- Verbindung schlägt auch über ein alternatives Netzwerk und mit aktuellem Client fehl
- Mehrere Personen gleichzeitig betroffen → Hinweis auf Problem am VPN-Gateway
- Zertifikat kann nicht automatisch erneuert werden

**Eskalation an:** Netzwerk-/Security-Team bei Gateway-Verdacht, PKI/Identity-Team bei Zertifikatsproblemen

---

**Priorität:** P2

**Symptom:** Ein zugeordnetes Netzlaufwerk wird mit einem roten Kreuz angezeigt, ist nicht erreichbar, oder beim Öffnen erscheint eine Fehlermeldung wie „Netzwerkpfad wurde nicht gefunden".

**Ursachenanalyse:**
- Prüfen, ob grundsätzlich eine Netzwerkverbindung besteht (LAN, WLAN oder VPN, je nach Standort)
- Erreichbarkeit des Fileservers testen: `ping <servername>` sowie `\\<servername>\<freigabe>` direkt im Explorer aufrufen
- Prüfen, ob es sich um ein Berechtigungsproblem oder ein reines Erreichbarkeitsproblem handelt
- Prüfen, ob das Problem nur bei eine Person oder bei mehreren am gleichen Server/Standort auftritt

**Lösungsschritte:**
1. Grundlegende Netzwerkverbindung prüfen (LAN-Kabel, WLAN, ggf. VPN-Status).
2. Server per `ping` und direktem UNC-Pfad testen.
3. Netzlaufwerk trennen und neu verbinden (`net use X: /delete` gefolgt von `net use X: \\server\freigabe`).
4. Zwischengespeicherte Zugangdaten prüfen und bei Bedarf löschen (`Anmeldeinformationsverwaltung` in der Systemsteuerung).
5. Bei VPN-abhängigen Freigaben: VPN-Verbindung neu aufbauen, bevor das Laufwerk erneut verbunden wird.

**Eskalationskriterien:**
- Server ist per `ping` nicht erreichbar, obwohl das Grundnetzwerk funktioniert → Hinweis auf Serverproblem
- Mehrere Nutzende am gleichen Standort oder Server betroffen

**Eskalation an:** Server-Team bei Erreichbarkeits- oder Berechtigungsproblemen, Netzwerk-Team bei Standort-weiten Ausfällen

---

## 3. WLAN-Verbindungsprobleme

**Priorität:** P3

**Symptom:** Das Gerät verbindet sich nicht mit dem WLAN, verliert wiederholt die Verbindung, oder zeigt zwar eine Verbindung an, hat aber keinen Internetzugriff.

**Ursachenanalyse:**
- Prüfen, ob das Problem nur ein Gerät oder mehrere im gleichen Bereich betrifft (Hinweis auf Access-Point-Problem)
-  WLAN-Signalstärke am betroffenen Standort prüfen
- Prüfen, ob das Gerät mit dem richtigen Netzwerk-Profil(SSID) verbunden ist, insbesondere bei mehreren ähnlich benannten Netzwerken.
- Treiber der WLAN-Netzwerkkarte auf Aktualität prüfen.

**Lösungsschritte:**
1. WLAN aus- und wieder einschalten.
2. Gespeichertes Netzwerkprofil entfernen und Verbindung neu aufbauen (`Netzwerk vergessen` → neu verbinden mit Passwort/Zertifikat).
3. WLAN-Treiber aktualisieren oder neu installieren.
4. Gerät an einem anderen Standort testen, um lokale Funklöcher auszuschliessen.
5. Netzwerkadapter über den Geräte-Manager zurücksetzen (deaktivieren/aktivieren).

**Eskalationskriterien:**
- Mehrere Geräte im gleichen Bereich gleichzeitig betroffen → Hinweis auf Access-Point-Ausfall
-  Verbindung besteht, aber es gibt keinen Internetzugriff, auch nach Neuverbindung

**Eskalation an:** Netzwerk-Team bei Access-Point- / Infrastrukturverdacht

---

## 4. Langsame Netzwerkverbindung / hohe Latenz

**Priorität:** P3

**Symptom:** Seitenaufbau, Dateizugriffe oder Videokonferenzen sind spürbar langsam oder stocken, obwohl grundsätzlich eine Verbindung besteht.

**Erfahrungsbericht:** Ein Klassiker, der sich in wenigen Minuten klären lässt: einfach gemeinsam mit der Person `ping <ziel> -t` laufen lassen, während sie kurz beschreibt, wann es hakt. Steigen die Antwortzeiten genau dann an, wenn im Homeoffice gleichzeitig jemand andere streamt oder ein grosses Backup läuft, ist es meist die Bandbreite im Heimnetz und kein Firmenproblem. Bleiben die Zeiten dagegen konstant hoch, auch bei sonst ruhigem Netzwerk, lohnt sich der Blick auf VPN-Routing oder die Entfernung zum nächsten Standort-Gateway

**Ursachenanalyse:**
- Latenz mit `ping` und Streckenverlauf mit `tracert` zu einem bekannten Ziel prüfen
- Prüfen, ob das Problem bei kabelgebundener und WLAN-Verbindung gleichermassen auftritt
- Bei Homeoffice: prüfen, ob gleichzeitig andere Geräte im gleichen Netz die Bandbreite stark beanspruchen
- Prüfen, ob das Problem nur über VPN oder auch im lokalen Netzwerk auftritt

**Lösungsschritte:**
1. `ping` und `tracert` zu einem internen sowie einem externen Ziel ausführen und Ergebnisse dokumentieren.
2. Bandbreitenauslastung im lokalen Netz prüfen (andere Geräte, Downloads, Streaming).
3. Kabelverbindung anstelle von WLAN testen, um Funkprobleme auszuschliessen.
4. Bei VPN-Nutzung: Split-Tunneling-Konfiguration prüfen, damit nicht sämtlicher Verkehr unnötig über das Firmennetz läuft.
5. Netzwerktreiber und Firmware des Routers/ Access Points auf Aktualität prüfen.

**Eskalationskriterien:**
- Hohe Latenz besteht konstant, auch bei geringer Netzwerklast und über Kabelverbindung
- `tracert` zeigt auffällige Sprünge an einem bestimmten Punkt der Strecke, der ausserhalb der Kontrolle der Nutzenden liegt

**Eskalation an:** Netzwerk-Team

---

## 5. DNS-Probleme (Internet da, Webseiten nicht erreichbar)

**Priorität:** P3

**Symptom:** Grundlegende Internetverbindung funktioniert (z. B. Ping auf eine IP-Adresse ist erfolgreich) , aber Webseiten oder interne Dienste lassen sich über ihren Namen nicht öffnen.

**Ursachenanalyse:**
- Prüfen, ob eine IP-Adresse direkt erreichbar ist, ein Domainname aber nicht (klassisches Zeichen für ein DNS-Problem)
- Aktuell zugewiesene DNS-Server mit `ipconfig /all` prüfen
- Prüfen, ob das Problem nur bei internen oder auch bei externen Adressen auftritt
- Prüfen, ob kürzlich Änderungen an der DNS-Konfiguration (z.B. per GPO) vorgenommen wurden..

**Lösungsschritte:**
1. `ipconfig /flushdns` ausführen, um den lokalen DNS-Cache zu leeren.
2. Namensauflösung testen mit `nslookup <domain>`.
3. DNS-Server-Einstellungen prüfen und bei Bedarf auf die vorgegebenen Firmen-DNS-Server zurücksetzen.
4. Netzwerkadapter neu starten bzw. IP-Konfiguration erneuern (`ipconfig /release` und `ipconfig /renew`).

**Eskalationskriterien:**
- Problem betrifft mehrere Nutzende oder ausschliesslich interne Adressen → Hinweis auf zentrales DNS-Problem
- `nslookup` liefert bei korrektem DNS- Server dennoch keine Antwort

**Eskalation an:** Netzwerk-/Infrastruktur-Team

---

## 6. IP-Adresskonflikt / keine IP-Adresse erhalten

**Priorität:** P3

**Symptom:** Windows meldet einen IP-Adreskonflikt, das Gerät erhält keine gültige IP-Adresse (169.254.x.x) oder die Verbindung funktioniert nur sporadisch.

**Ursachenanalyse:**
- Aktuelle IP-Konfiguration mit `ipconfig /all` prüfen
- Prüfen, ob eine statische IP-Adresse manuell konfiguriert wurde, die inzwischen bereits vergeben ist
- Prüfen, ob das Problem nach einem Standort- oder Netzwerkwechsel aufgetreten ist
- Bei wiederholtem Konflikt: prüfen,ob mehrere Geräte mit derselben Netzwerkkonfiguration (z. B. geklontes Image) im gleichen Netz sind

**Lösungsschritte:**
1. `ipconfig /release` gefolgt von `ipconfig /renew` ausführen.
2. Bei manuell konfigurierter IP: auf automatischen DHCP-Bezug umstellen, sofern keine feste IP benötigt wird
3. Netzwerkadapter deaktivieren und wieder aktivieren
4. Gerät neu starten, um eine saubere DHCP-Anfrage auszulösen

**Eskalationskriterien:**
- Konflikt tritt wiederholt trotz DHCP-Bezug auf → Hinweis auf DHCP-Scope- oder Reservierungsproblem
- Mehrere Geräte im gleichen Netzsegment betroffen.

**Eskalation an:** Netzwerk-Team

---

## 7. Firewall-/Portblockierungen

**Priorität:** P3

**Symptom:** Eine bestimmte Anwendung kann nicht mit einem Server oder Dienst kommunizieren, obwohl die grundlegende Netzwerkverbindung funktioniert. Typische Meldungen: „Verbindung zum Server fehlgeschlagen" oder „Zeitüberschreitung".

**Ursachenanalyse:**
- Prüfen, welcher Port bzw. welches Protokoll von der Anwendung benötigt wird (Dokumentation des Herstellers)
- Verbindung zum Zielport testen, z. B. mit `Test-NetConnection -ComputerName <ziel> -Port <portnummer>` in PowerShell
- Prüfen, ob die Windows-Firewall lokal blockeirt oder ob die Blockade weiter aussen (Firmen-Firewall, Proxy) liegt
- Prüfen, ob das Problem nur in einem bestimmten Netzwerksegment (z. B. Gäste-WLAN, Homeoffice über VPN) auftritt

**Lösungsschritte:**
1. Verbindung zum benötigten Port testen (`Test-NetConnection`), um zwischen Client- und Netzwerkblockade zu unterscheiden.
2. Windows-Firewall-Regeln für die betroffene Anwendung prüfen und bei Bedarf eine Ausnahme ergänzen.
3. Antivirus-/Endpoint-Security-Software auf eine eigene Netzwerkfilterung hin prüfen, die zusätzlich zur Windows-Firewall greifen kann
4. Bei Verdacht auf zentrale Blockade:gleiche Verbindung von einem anderen Standort oder Netzsegment aus testen.

**Eskalationskriterien:**
- Port ist von keinem Gerät im betroffenen Netzsegment erreichbar → Hinweis auf zentrale Firewall-/Proxy-Regel
- Anwendung benötigt eine neue oder geänderte Firewall-Freigabe, die nicht lokal vorgenommen werden kann

**Eskalation an:** Netzwerk-/Security-Team

---

## Remote-Support-Hinweise

Netzwerk- und VPN-Probleme haben eine Besonderheit: Sobald die Netzwerkverbindung selbst betroffen ist, funktioniert auch die Ferndiagnose oft nur eingeschränkt oder gar nicht.

- **Quick Assist / TeamViewer:** funktioniert nur, solange noch eine Basisverbindung zum Internet besteht – geeignet für Abschnitte 2, 4, 5, 6, 7, sofern das Gerät grundsätzlich online ist
- **Telefonische Anleitung:** oft die einzige Option bei vollständigem VPN-Ausfall (Abschnitt 1) oder totalem WLAN-Verlust (Abschnitt 3), da kein Remote-Zugriff möglich ist
- **Vor-Ort-Support nötig, wenn:**
  - Das Gerät über kein Netzwerk mehr erreichbar ist und auch telefonisch keine Lösung gefunden wird
  - Physische Netzwerkkomponenten (Kabel, Access Point, Switch-Port) geprüft werden müssen
  - Es sich um ein bekanntes, standort-weites Problem handelt, bei dem mehrere Personen gleichzeitig betroffen sind

**Faustregel:** Bei einem vollständigen VPN- oder WLAN-Ausfall zuerst klären, ob überhaupt noch eine alternative Erreichbarkeit besteht (z. B. Mobiltelefon der Nutzenden) –ohne das ist auch die best Ferndiagnose nutzlos, und man sollte direkt auf telefonische Anleitung oder Vor-Ort-Support umschalten.

---

## Verwandte Themen
- [Windows-Client-Probleme.md](./Windows-Client-Probleme.md)
- [Drucker-und-Peripherie.md](./Drucker-und-Peripherie.md)
- [Hardware-Diagnose.md](./Hardware-Diagnose.md)

## Changelog
| Datum | Änderung |
|---|---|
| 2026-08-07 | Erste Version |