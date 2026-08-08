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
