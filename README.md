# check_mk - Notification Skript - SMS-Gateway LOX24

##### Quick 'n Dirty Scripting | nicht schön, aber selten

Bei diesem Bash-Skript handelt es sich um ein Benachrichtigungsskript für check_mk.
`sms-lox24.sh verschickt eine SMS an die im Benutzer hinterlegte Telefon- bzw. Handynummer (`Pager address`).

Folgende Variablen müssen angepasst werden:

 * `LOX24USER` - User-ID eures LOX24 Accounts
 * `LOX24PW` - MD5-Hash eures LOX24 Account
 * `LOX24TARIF` - Tarif-ID
 * `LOX24FROM` - Absenderadresse/-name je nach Tarif-ID einstellbar

Das Skript gehört bei einer OMD-Installation in das Verzeichnis `/omd/sites/sitename/local/share/check_mk/notifications/` und muss natürlich mit `chmod` sowie `chown` für den OMD-User ausführbar gemacht werden. In den WATO Benutzereinstellungen kann dann bei *Flexible Notifications* **SMS via LOX24 SMS Gateway** ausgewählt und konfiguriert werden.

Viel Spaß!

##### Inspiration & Dank
 * [bbhenry - email-sms-custom.sh](https://github.com/bbhenry/check_mk_server/blob/master/email-sms-custom.sh)
 * [check_mk - Flexible Notifications](https://mathias-kettner.de/checkmk_flexible_notifications.html)