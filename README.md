# LEO-AC1 — Ventilator im Klimaanlagen-Look

Kleiner Akku-Ventilator für das Kinderzimmer, gestaltet wie die Außeneinheit einer Split-Klimaanlage (Proportionen eines 800 × 550 × 285 mm großen Geräts). Ein 120-mm-PC-Lüfter bläst durch das runde Gitter nach vorn, die Luft kommt durch die Schlitze in der Rückwand und der linken Seite. Ein Luftkanal zwischen Front und Lüfterrahmen sorgt dafür, dass die Luft vorn herauskommt und nicht seitlich ins Gehäuse zurückströmt. Rechts auf der Front steht das Logo „LEO INDUSTRIES AC-1“ in eigener Blockschrift (LEO in Schablonen-Buchstaben) über waagerechten Zierrillen wie bei Mitsubishi-Außengeräten; dahinter liegt ein Fach für den Akku (3,2 V 6000 mAh LiFePO4, JST-PH 2.0) und die Elektronik. Gedruckt auf der Bambu Lab H2S in PETG Basic Weiß und Grau.

![Baugruppe](img/01_assembly.png)

3D-Viewer (Artifact, wird nach jeder Modelländerung unter derselben URL erneuert): a private Claude viewer artifact

| Rückseite | Explosionsansicht | Logo und Rillen | Luftkanal von hinten | Servicedeckel mit Drehknopf | Unterseite mit M5-Gewinde |
|---|---|---|---|---|---|
| ![Rückseite](img/02_back.png) | ![Explosion](img/03_exploded.png) | ![Logo](img/04_front_right.png) | ![Luftkanal](img/05_duct.png) | ![Drehknopf](img/06_knob.png) | ![Unterseite](img/07_underside.png) |

## Teile

| Teil | Menge | Material | Maße (mm) | Drucklage |
|---|---|---|---|---|
| `body` Gehäuse | 1 | PETG weiß + grau (Typenschild) | 225 × 155 × 77,6 | Front aufs Bett, Logo als Einlage in den ersten 0,6 mm, Zierrillen 0,8 mm tief zur Bettseite offen |
| `back` Rückwand | 1 | PETG weiß | 225 × 155 × 40,6 | Außenseite aufs Bett, Akku-Halterippen stehen senkrecht |
| `grille` Lüftergitter | 1 | PETG grau | Ø 136 × 6 | Vorderseite aufs Bett |
| `cover` Servicedeckel | 1 | PETG grau | 116 × 34 × 11 | Außenseite aufs Bett; wird auf die rechte Seitenwand geklebt |
| `knob` Drehknopf | 1 | PETG grau | Ø 28 × 13,7 (flache Kappe, steht 7 mm vor dem Servicedeckel) | Oberseite aufs Bett, Schaft mit D-Bohrung zeigt nach oben |
| `handle` Griff | 1 | PETG grau | 170 × 42 × 24 (30 mm Luft unter dem Balken, Öffnung oben 90 mm) | auf der Seite liegend (Schichten in Zugrichtung), Fasen 45° |

Alle Teile liegen als Bambu-Studio-Projekt in [`stl/leo_ac1_all_parts.3mf`](stl/leo_ac1_all_parts.3mf): Platte 1 Gehäuse (mit Wischturm), Platte 2 Rückwand, Platte 3 graue Teile (Gitter, Servicedeckel, Griff, Drehknopf). Filament 1 PETG Basic Weiß, Filament 2 PETG Basic Grau, Filament 3 Grau für das Typenschild (im AMS dieselbe Spule wie Filament 2). Wer das Gehäuse einfarbig druckt, nimmt `stl/body.stl`.

Rechnerisch **ca. 0,59 kg und 16,7 Stunden** (diagnostisches Slicen, jede Instanz als eigener Druck; Gehäuse allein 343 g / 7,9 h).

## Druck und Stabilität

Alle Teile drucken ohne Stützen (geprüft mit `analyze.py islands`, `overhangs` > 45°, `ridges`, `inlays`):

- Gehäuse mit der Front aufs Bett: Wände, Trennwand, Akkuwiege und Elektronikboden stehen senkrecht; Schrauben-Dome der Rückwand laufen mit 45°-Kegel in die Ecken; Seitenschlitze überbrücken nur 1,6 mm; Zierrillen sind zur Bettseite offen.
- Luftkanal: rundes Rohr Ø 118 mm (wie die Gitteröffnung), 1,6 mm Wand, von der Front bis 0,2 mm vor den Lüfterrahmen (geprüft: Wand rundum geschlossen, Rohrende liegt vollständig auf dem Rahmen); keine toten Ecken zwischen rundem Gitter und eckigem Rahmen.
- Sturzfest: Wände und Front 3,2 mm, Rückwand 4 mm (Schraubenköpfe versenkt), Eckradius 6 mm, 4-mm-Hohlkehle innen zwischen Front und Wänden, Gitterring 4 mm mit 2,4 mm Stäben, Versteifungsrippen innen unter den Griff-Füßen, zusätzliche Strebe in den Rückwandschlitzen.
- Einschmelzmuttern haben mindestens 3 mm Material bis zur Sichtfläche (Gitter 3,5 mm, Lüfter 3,9 mm, Servicedeckel 4,5 mm), damit sich die Front beim Eindrücken nicht verzieht.
- Gitterspalt 4,9 mm (Fingerschutz).
- M5-Halterung: Die Mutter wird von außen in ein Sackloch gepresst (10,5 mm = L + 1 laut Datenblatt), darüber 2,5 mm Boden; das Gewicht auf der Halterung drückt sie gegen diesen Boden. Der Dom ist bewusst nur Ø 15 mm: 4,3 mm Wand werden mit 6 Wandlinien komplett massiv gedruckt statt mit Füllung. Dazu eine Rippe nach hinten, 45°-Anlauf zur Front und innen eine 3 mm dicke Bodenverdopplung von der Front bis zur Trennwand (60 × 56 mm), die Hebelkräfte in Front und Trennwand leitet. Für echtes Kamerazubehör gäbe es auch Ruthex RX-1/4x12.7 (1/4"-20, Loch Ø 8,0, Wand ≥ 3,3).
- Slicer-Profil: 6 Wände, 5 Decken-/Bodenlagen, 30 % Gyroid. PETG ist schlagzäher als PLA.

## Zukaufteile

| Teil | Menge | Hinweis |
|---|---|---|
| PC-Lüfter 120 × 120 × 25 mm | 1 | Lochabstand 105 mm; 12-V-Lüfter brauchen einen Step-up-Wandler |
| Akku 3,2 V 6000 mAh LiFePO4 mit Schutzplatine, JST-PH 2.0 (32700-Zelle, Ø 34 × 70 mm) | 1 | Nur mit LiFePO4-Ladegerät laden (3,65 V), **kein** TP4056 (4,2 V) |
| Lade-/Boostmodul „2-in-1 3,2 V LiFePO4“, Variante 12 V | 1 | 35,4 × 11 × 3,6 mm; Pads IN± (5 V laden), B± (Akku), O± (12 V, max. ca. 0,32 A) |
| PWM-Lüfterregler DC 8–24 V 5 A mit Drehpoti und Schalter | 1 | 4-Pin-Lüfter; Poti sitzt auf der Platine; beides über dem Elektronikboden an der rechten Seitenwand, Knopf oben im Servicedeckel (angenommen: Platine 45 × 30 mm mit 12 mm hohen Bauteilen, Poti WH148 mit D-Achse Ø 6 × 15, M7) |
| Kleber für den Servicedeckel | – | 2K-Epoxid oder Sekundenkleber auf den 2,4 mm breiten Rand |
| USB-C-Einbaubuchse 5 V | 1 | Zum Laden, Lage im Servicedeckel noch offen |
| Einschmelzmuttern Ruthex RX-M3x5.7 | 18 | Loch Ø 4,0, Tiefe 7 (Datenblatt: ≥ L + 1 = 6,7), Wand ≥ 1,6 |
| Einschmelzmutter Ruthex RX-M5x9.5 | 1 | Halterungsgewinde in der Unterseite (wie ein Stativgewinde): von außen eingepresst, Sackloch Ø 6,4 × 10,5 (L + 1), darüber 2,5 mm Boden; Wand 4,3 mm (Datenblatt ≥ 2,6) |
| M3 × 12, ISO 7380 Torx | 4 | Gitter, von vorn, Kopf 1,9 mm im Gitterring versenkt |
| **M3 × 30**, ISO 7380 Torx | 4 | Lüfter, von hinten durch den Rahmen (nicht im nas-case-Satz, nachkaufen) |
| M3 × 8, ISO 7380 Torx | 6 | Rückwand, von außen, Kopf 1,9 mm versenkt |
| M3 × 8, ISO 7380 Torx | 4 | Griff, von innen |

## Zusammenbau

1. Einschmelzmuttern setzen: 4 Gitter- und 4 Lüfterdome innen an der Front, 6 Dome am hinteren Rand des Gehäuses, 4 in den Griff-Füßen; die M5-Mutter von unten in das Sackloch in der Unterseite.
2. PWM-Platine mit dem Poti von hinten über den Elektronikboden führen, Poti von innen durch die rechte Seitenwand stecken und außen mit seiner Mutter festziehen. Erst dann den Servicedeckel aufkleben (danach ist die Platine nur nach Abhebeln des Deckels tauschbar). Griff von innen mit M3 × 8 anschrauben; Drehknopf durch das Loch im Servicedeckel auf die Achse drücken (Zeigerstrich zur Achsabflachung).
3. Gitter von vorn aufsetzen (der Kragen zentriert es in der Öffnung) und mit M3 × 12 anschrauben.
4. Lüfter von hinten auf die Dome hinter dem Luftkanal setzen, Blasrichtung nach vorn, mit M3 × 30 anschrauben. Kabel durch die Aussparung in der Trennwand ins Elektronikfach führen.
5. Akku stehend von hinten in die Wiege schieben, Kabelende nach oben; das Kabel läuft durch den Schlitz im Elektronikboden darüber.
6. Rückwand aufsetzen (die Rippen halten den Akku mit 1 mm Luft) und mit M3 × 8 verschrauben.

## Offen

- Poti des PWM-Reglers, PWM-Platine und USB-C-Buchse messen (Lage im Elektronikfach, USB-C-Durchbruch).
- Akku und Lüfter nachmessen (Akku laut Etikett Ø 34 × 70 mm, im Modell Ø 35 × 72 mm; Lüfter nach Norm).
- Elektronik (Wandler, Laden, Schalter, Drehzahl) festlegen: Lage im Elektronikfach, Durchbrüche für Ladebuchse und Schalter (z. B. im Servicedeckel).

## Modell, Exporte und Prüfungen

Modell: [`leo_ac.scad`](leo_ac.scad), Einstellungen und Projektprüfungen: [`print_project.py`](print_project.py). Werkzeuge aus dem Skill `openscad-print-project` (Kopien in `scripts/`).

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r scripts/requirements.txt
.venv/bin/python scripts/print_tools.py export     # prüfen und stl/, asm/, docs/verification.json ersetzen
.venv/bin/python scripts/analyze.py islands        # schwebende Bereiche
.venv/bin/python scripts/analyze.py overhangs      # Überhänge > 45°, Brücken
.venv/bin/python scripts/slice_check.py            # Bambu-CLI, Projekt-3MF, docs/slicer-summary.json
.venv/bin/python scripts/build_viewer.py           # build/viewer.html
.venv/bin/python scripts/render_views.py           # img/
```

Geprüft werden: Teileliste gegen die `part`-Zweige, geschlossene Netze, Bettlage, Bauraum, keine Überschneidung zwischen 15 Baugruppenkörpern (105 Paare, inklusive angenommener PWM-Platine, inklusive Schrauben, Lüfter- und Akku-Hüllkörper), Auflagekontakt von Gitter, Lüfter, Rückwand, Deckel, Griff, Poti und Akku, Anschläge des Akkus (hinten 1,25 mm, oben 3,25 mm, seitlich 0,75 mm), 6 Ein- und Ausbauwege in realistischer Reihenfolge, 19 Insert-Aufnahmen (18 × M3, 1 × M5; Achse frei, volle Mindestwand laut Ruthex-Datenblatt, Boden voll), Einschraubtiefen (≥ 4,7 mm, Spitze ≥ 0,9 mm vor dem Taschenende), Normmaße (120-mm-Lüfter, Ruthex M3), Gitterspalt ≤ 6 mm (Fingerschutz), Mehrfarb-Deckung des Logos. Druckbarkeit: keine schwebenden Bereiche, Einlage auf Schicht 1 ohne zu schmale Stellen, Stege zwischen den Rillen ≥ 1,1 mm. Keine Festigkeits-, Luftstrom- oder Passungsprüfung am echten Teil.
