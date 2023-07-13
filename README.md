# native-inertia
Welche Potenziale und Einschränkungen bietet ein Ansatz zur nativen iOS-App-Entwicklung mit Swift-basiertem Backend und webbasiertem Frontend im Vergleich zu einer vollständig mit Swift entwickelten iOS-App?

## Lokales Setup

Folge diesen Schritten, um das GitHub-Projekt lokal zum Laufen zu bringen:

1. Klonen des Projekts:

   ```
   git clone <GitHub-Projekt-URL>
   ```

   Ersetze `<GitHub-Projekt-URL>` durch die tatsächliche URL des GitHub-Projekts.

2. Öffnen des Projekts in Visual Studio Code:

   - Öffne das Projekt in Visual Studio Code.
   - Navigiere zum "www" Ordner des geklonten Projekts. Hierbei handelt es sich um das Frontend der Applikation.


3. Öffnen des Projekts in Xcode:

   - Öffne Xcode auf deinem Computer.
   - Öffne die Datei "native-inertia-boilerplate.xcodeproj" in Xcode.

4. Wähle den Modus aus:

   - In Xcode findest du oben in der Symbolleiste ein Dropdown-Menü mit den verfügbaren Schemes.
   - Wähle das Scheme "native-inertia-boilerplate" für den Dev-Modus oder "native-inertia-boilerplate-prod" für den Prod-Modus aus.

### Dev-Modus

1. Wähle das Scheme "native-inertia-boilerplate" in Xcode aus.

2. Installiere die Frontend-Pakete:

   - Öffne das Terminal in Visual Studio Code.
   - Navigiere im Visual Studio Code Terminal zum "www" Ordner des geklonten Projekts

   - Führe den folgenden Befehl aus, um alle Frontend-Pakete zu installieren:

     ```
     pnpm i
     ```

3. Starte das Frontend:

   - Führe den folgenden Befehl im Terminal aus, um einen lokalen Server und somit das Frontend zu starten:

     ```
     pnpm run dev
     ```

4. Baue und starte die App:

   - Baue und starte die App in Xcode.
   - Die Inhalte, die du in der App siehst, werden vom Server ausgeführt und angezeigt. Dies ist besonders hilfreich während der Entwicklung, da Änderungen sofort angezeigt werden, ohne dass Sie die App erneut gebaut werden muss.


### PROD-Modus

1. Installiere die Frontend-Pakete:

   - Öffne das Terminal in Visual Studio Code.
   - Navigiere im Visual Studio Code Terminal zum "www" Ordner des geklonten Projekts

   - Führe den folgenden Befehl aus, um alle Frontend-Pakete zu installieren:

     ```
     pnpm i
     ```

2. Starte das Frontend:

   - Führe den folgenden Befehl im Terminal aus, um das Frontend zu bauen:

     ```
     pnpm run build
     ```

3. Baue und starte die App:

   - Baue und starte die App in Xcode.
   - Die Inhalte, die du in der App siehst, werden auf dem mobilen Endgerät oder im Simulator ausgeführt und angezeigt. Wenn du Änderungen vornimmst, musst du das Frontend in Visual Studio Code erneut bauen und die App in Xcode ebenfalls erneut bauen und starten.

Das war's! Nun sollte das GitHub-Projekt lokal laufen und je nach Bedarf im Dev- oder Prod-Modus verwendet werden.
