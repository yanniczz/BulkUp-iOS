# BulkUp iOS App

BulkUp ist eine native iOS-App, die als WebView-Wrapper für die BulkUp Web-Anwendung dient.

## Projektübersicht

- **Bundle ID:** com.bulkup.app
- **Display Name:** BulkUp
- **Version:** 1.0 (Build 1)
- **Deployment Target:** iOS 15.0+
- **Plattformen:** iPhone, iPad, Mac Catalyst
- **Produktion URL:** https://bulkup.app/
- **Privacy Policy:** https://bulkup.app/privacy

## Features

- Native WebView-Integration mit JavaScript-Bridge
- Push-Benachrichtigungen (APNs - ohne Firebase)
- Universal Links & Deep Linking
- Kamera, Mikrofon & Standort-Zugriff
- Dark/Light Mode Support
- Pull-to-Refresh
- Druck-Funktionalität
- Connection Error Handling mit Auto-Retry

## Projektstruktur

```
BulkUp-iOS/
├── BulkUp/
│   ├── AppDelegate.swift           # App lifecycle
│   ├── SceneDelegate.swift         # Scene lifecycle
│   ├── ViewController.swift        # Main view controller
│   ├── WebView.swift              # WebView configuration
│   ├── Settings.swift             # App settings & URLs
│   ├── PushNotifications.swift    # Push notification handling
│   ├── Printer.swift              # Print functionality
│   ├── Assets.xcassets/           # App icons & images
│   ├── Base.lproj/                # Storyboards
│   ├── Entitlements/              # App capabilities
│   └── Info.plist                 # App metadata
├── BulkUp.xcodeproj/              # Xcode project
├── Podfile                        # CocoaPods (keine Dependencies)
└── README.md                      # Diese Datei
```

## Voraussetzungen

- macOS mit Xcode 14.0+
- Apple Developer Account ($99/Jahr)
- iOS 15.0+ Device für Testing
- Zugriff auf https://bulkup.app/

## Setup-Schritte

### 1. Apple Developer Account

- [ ] Bei [Apple Developer Program](https://developer.apple.com/programs/) anmelden
- [ ] Account aktivieren und bezahlen ($99/Jahr)
- [ ] In Xcode einloggen: Xcode → Settings → Accounts → Add Apple ID

### 2. Xcode Projekt konfigurieren

1. Projekt in Xcode öffnen: `BulkUp.xcworkspace` (NICHT .xcodeproj)
2. Target "BulkUp" auswählen
3. Unter "Signing & Capabilities":
   - [ ] Team auswählen (dein Developer Account)
   - [ ] "Automatically manage signing" aktivieren
   - [ ] Bundle Identifier verifizieren: `com.bulkup.app`

### 3. App ID & Capabilities in Apple Developer Portal

Im [Apple Developer Portal](https://developer.apple.com/account/):

- [ ] App ID erstellen/verifizieren: com.bulkup.app
- [ ] Folgende Capabilities aktivieren:
  - Push Notifications
  - Associated Domains
- [ ] Provisioning Profiles erstellen:
  - Development Profile für Testing
  - Distribution Profile für App Store

### 4. Universal Links Setup

Auf dem Server https://bulkup.app/:

- [ ] `.well-known/apple-app-site-association` Datei erstellen
- [ ] Content-Type: `application/json` (ohne .json Extension)
- [ ] Inhalt:

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAMID.com.bulkup.app",
        "paths": ["*"]
      }
    ]
  },
  "webcredentials": {
    "apps": ["TEAMID.com.bulkup.app"]
  }
}
```

Ersetze `TEAMID` mit deiner Apple Team ID (zu finden im Developer Portal unter "Membership").

### 5. Push-Benachrichtigungen (Optional)

Falls ihr in Zukunft Push-Notifications nutzen wollt:

- [ ] APNs Auth Key im Apple Developer Portal erstellen
- [ ] Server-seitig APNs Integration implementieren
- [ ] Device Token vom iOS App an euren Server senden

**Hinweis:** Die App ist derzeit auf native APNs vorbereitet (ohne Firebase). Der Code in [PushNotifications.swift](BulkUp/PushNotifications.swift) registriert das Device für Push-Notifications.

### 6. Testing

- [ ] App auf physischem iPhone testen (Simulator hat Einschränkungen)
- [ ] Push-Benachrichtigungen testen
- [ ] Universal Links testen (z.B. via Safari)
- [ ] Kamera-Zugriff testen
- [ ] Mikrofon-Zugriff testen
- [ ] Standort-Zugriff testen
- [ ] Dark/Light Mode testen
- [ ] Offline-Verhalten testen

### 7. App Store Connect Setup

1. In [App Store Connect](https://appstoreconnect.apple.com/):

- [ ] Neue App anlegen
- [ ] Bundle ID: com.bulkup.app
- [ ] SKU: (eindeutige ID für interne Verwaltung)

2. App-Informationen:

- [ ] App-Name: BulkUp
- [ ] Untertitel (30 Zeichen)
- [ ] Kategorie: Gesundheit & Fitness (oder Produktivität)
- [ ] Privacy Policy URL: https://bulkup.app/privacy
- [ ] Support URL: (eure Support-Seite)

3. Screenshots vorbereiten:

- [ ] iPhone 6.7" (Pro Max) - mindestens 3 Screenshots
- [ ] iPhone 6.5" - mindestens 3 Screenshots
- [ ] iPad Pro 12.9" - mindestens 3 Screenshots
- [ ] Optional: App-Vorschau-Video

4. App-Beschreibung:

- [ ] Beschreibung (max. 4000 Zeichen)
- [ ] Keywords (max. 100 Zeichen, kommasepariert)
- [ ] Werbetext (optional, 170 Zeichen)

### 8. Build & Upload

1. In Xcode:

- [ ] Scheme auf "BulkUp" setzen
- [ ] Device auf "Any iOS Device" setzen
- [ ] Product → Archive
- [ ] Warten bis Build fertig ist
- [ ] Im Organizer: "Distribute App"
- [ ] "App Store Connect" auswählen
- [ ] Upload durchführen

2. In App Store Connect:

- [ ] Warten bis Build verarbeitet ist (5-30 Minuten)
- [ ] Build zur Version hinzufügen
- [ ] Export Compliance: "No" (falls keine Encryption außer HTTPS)
- [ ] Zur Review einreichen

### 9. App Review

- **Durchschnittliche Review-Zeit:** 1-3 Tage
- Apple prüft:
  - Funktionalität
  - UI/UX
  - Privacy Policy
  - Inhalt der Web-App
  - Permissions-Nutzung

**Wichtig:** Stellt sicher, dass https://bulkup.app/ vollständig funktioniert und keine Fehler hat!

## Bekannte Einschränkungen

- **Kein Firebase:** Push-Notifications müssen über APNs direkt implementiert werden
- **WebView-Wrapper:** Apple prüft WebView-Apps strenger - stellt sicher, dass genug "native Wert" vorhanden ist
- **CocoaPods:** Aktuell keine Dependencies - Podfile ist leer

## Wichtige Dateien

- [Settings.swift](BulkUp/Settings.swift): Production URL & erlaubte Origins
- [Info.plist](BulkUp/Info.plist): App metadata, Permissions, Privacy Policy URL
- [Entitlements.plist](BulkUp/Entitlements/Entitlements.plist): Capabilities (Push, Universal Links)
- [AppDelegate.swift](BulkUp/AppDelegate.swift): App lifecycle, Push registration
- [PushNotifications.swift](BulkUp/PushNotifications.swift): Push notification handling

## Änderungen für Production

Alle notwendigen Änderungen für Production wurden bereits durchgeführt:

- ✅ Production URL auf `https://bulkup.app/` geändert
- ✅ Bundle ID auf `com.bulkup.app` geändert
- ✅ Privacy Policy URL hinzugefügt
- ✅ App Transport Security konfiguriert
- ✅ Associated Domains auf `bulkup.app` gesetzt
- ✅ Firebase Dependencies entfernt
- ✅ Version auf 1.0 gesetzt

## Troubleshooting

### Build-Fehler: "No signing identity found"

→ Apple Developer Account Team muss in Xcode unter "Signing & Capabilities" ausgewählt werden

### Universal Links funktionieren nicht

→ Überprüfen ob `.well-known/apple-app-site-association` korrekt auf dem Server liegt und über HTTPS erreichbar ist

### Push-Notifications kommen nicht an

→ Stellt sicher, dass:
1. Device Token vom iOS Device an euren Server gesendet wird
2. Euer Server APNs Auth Key konfiguriert hat
3. Push-Berechtigung vom User erteilt wurde

### App lädt nicht / Connection Error

→ Überprüfen ob https://bulkup.app/ erreichbar ist und korrekt lädt

## Support & Kontakt

Bei Fragen oder Problemen:

1. Xcode Build Logs überprüfen
2. Console.app öffnen und nach "BulkUp" filtern
3. Apple Developer Forums: https://developer.apple.com/forums/

## Nächste Schritte

1. ✅ Code-Anpassungen für Production (erledigt)
2. ⏳ Apple Developer Account einrichten
3. ⏳ Xcode Signing konfigurieren
4. ⏳ Auf Device testen
5. ⏳ Screenshots erstellen
6. ⏳ App Store Connect Setup
7. ⏳ Build hochladen
8. ⏳ Review einreichen
9. ⏳ Launch! 🚀

**Geschätzte Zeit bis zum Launch:** 3-5 Wochen

---

**License:** Unlicense (Public Domain)
