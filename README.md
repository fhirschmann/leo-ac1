# LEO-AC1 — Ventilator im Klimaanlagen-Look

Kleiner Akku-Ventilator für das Kinderzimmer, gestaltet wie die Außeneinheit einer Split-Klimaanlage (Proportionen eines 800 × 550 × 285 mm großen Geräts). Ein 120-mm-PC-Lüfter bläst durch das runde Gitter nach vorn, die Luft kommt durch die Schlitze in der Rückwand und der linken Seite. Rechts sitzt ein Fach für den Akku (3,2 V 6000 mAh LiFePO4, JST-PH 2.0) und die Elektronik. Gedruckt auf der Bambu Lab H2S in PETG Basic Weiß und Grau.

![Baugruppe](img/01_assembly.png)

| Rückseite | Explosionsansicht |
|---|---|
| ![Rückseite](img/02_back.png) | ![Explosion](img/03_exploded.png) |

## Teile

| Teil | Menge | Material | Maße (mm) | Drucklage |
|---|---|---|---|---|
| `body` Gehäuse | 1 | PETG weiß + grau (Typenschild) | 225 × 155 × 77,6 | Front aufs Bett, Schriftzug „LEO" als Einlage in den ersten 0,6 mm |
| `back` Rückwand | 1 | PETG weiß | 225 × 155 × 40,6 | Außenseite aufs Bett, Akku-Halterippen stehen senkrecht |
| `grille` Lüftergitter | 1 | PETG grau | Ø 136 × 6 | Vorderseite aufs Bett |
| `cover` Servicedeckel | 1 | PETG grau | 84 × 34 × 9 | Außenseite aufs Bett |
| `foot` Fußschiene | 2 | PETG grau | 18 × 96 × 10 | Unterseite aufs Bett, Kanal wird überbrückt |

Alle Teile liegen als Bambu-Studio-Projekt in [`stl/leo_ac1_all_parts.3mf`](stl/leo_ac1_all_parts.3mf): Platte 1 Gehäuse (mit Wischturm), Platte 2 Rückwand, Platte 3 graue Teile. Filament 1 PETG Basic Weiß, Filament 2 PETG Basic Grau, Filament 3 Grau für das Typenschild (im AMS dieselbe Spule wie Filament 2). Wer das Gehäuse einfarbig druckt, nimmt `stl/body.stl`.

Rechnerisch **ca. 0,41 kg und 11,8 Stunden** (diagnostisches Slicen, jede Instanz als eigener Druck; Gehäuse allein 257 g / 6 h).

## Zukaufteile

| Teil | Menge | Hinweis |
|---|---|---|
| PC-Lüfter 120 × 120 × 25 mm | 1 | Lochabstand 105 mm; 12-V-Lüfter brauchen einen Step-up-Wandler |
| Akku 3,2 V 6000 mAh LiFePO4 mit Schutzplatine, JST-PH 2.0 | 1 | Nur mit LiFePO4-Ladegerät laden (3,65 V), **kein** TP4056 (4,2 V) |
| Einschmelzmuttern Ruthex M3 × 5,7 | 20 | Loch Ø 4,0, Tiefe 6,5 |
| M3 × 10 Senkkopf | 4 | Gitter, von vorn |
| M3 × 30 Zylinderkopf | 4 | Lüfter, von hinten durch den Rahmen |
| M3 × 8 Senkkopf | 6 | Rückwand |
| M3 × 8 Zylinderkopf | 6 | Fußschienen (4) und Servicedeckel (2), von innen |

## Zusammenbau

1. Einschmelzmuttern setzen: 4 Gitter- und 4 Lüfterdome innen an der Front, 6 Dome am hinteren Rand des Gehäuses, je 2 in den Fußschienen, 2 im Servicedeckel.
2. Fußschienen von innen mit M3 × 8 anschrauben, Servicedeckel ebenso von innen.
3. Gitter von vorn aufsetzen (der Kragen zentriert es in der Öffnung) und mit M3 × 10 Senkkopf anschrauben.
4. Lüfter von hinten auf die Dome setzen, Blasrichtung nach vorn, mit M3 × 30 anschrauben. Kabel durch die Aussparung in der Trennwand ins Elektronikfach führen.
5. Akku stehend von hinten in die Wiege schieben; das Fach darüber ist für die Elektronik.
6. Rückwand aufsetzen (die Rippen halten den Akku mit 1 mm Luft) und mit M3 × 8 Senkkopf verschrauben.

## Offen

- Akku und Lüfter nachmessen (Modell: Akku Ø 35 × 72 mm inkl. Schutzplatine, Lüfter nach Norm).
- Elektronik (Wandler, Laden, Schalter, Drehzahl) festlegen: Lage im Elektronikfach, Durchbrüche für Ladebuchse und Schalter (z. B. im Servicedeckel).

## Modell, Exporte und Prüfungen

Modell: [`leo_ac.scad`](leo_ac.scad), Einstellungen und Projektprüfungen: [`print_project.py`](print_project.py). Werkzeuge aus dem Skill `openscad-print-project` (Kopien in `scripts/`).

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r scripts/requirements.txt
.venv/bin/python scripts/print_tools.py export     # prüfen und stl/, asm/, docs/verification.json ersetzen
.venv/bin/python scripts/analyze.py islands        # schwebende Bereiche
.venv/bin/python scripts/slice_check.py            # Bambu-CLI, Projekt-3MF, docs/slicer-summary.json
.venv/bin/python scripts/build_viewer.py           # build/viewer.html
.venv/bin/python scripts/render_views.py           # img/
```

Geprüft werden: Teileliste gegen die `part`-Zweige, geschlossene Netze, Bettlage, Bauraum, keine Überschneidung zwischen 12 Baugruppenkörpern (66 Paare, inklusive Schrauben, Lüfter- und Akku-Hüllkörper), Auflagekontakt von Gitter, Lüfter, Rückwand, Füßen, Deckel und Akku, Anschläge des Akkus (hinten 1,25 mm, oben 3,25 mm, seitlich 0,75 mm), 6 Ein- und Ausbauwege in realistischer Reihenfolge, 20 Insert-Aufnahmen (Achse frei, Ring und Boden voll), Einschraubtiefen (≥ 4,7 mm, Spitze ≥ 0,9 mm vor dem Taschenende), Normmaße (120-mm-Lüfter, Ruthex M3), Gitterspalt ≤ 6 mm (Fingerschutz), Mehrfarb-Deckung des Typenschilds. Druckbarkeit: keine schwebenden Bereiche, Einlage auf Schicht 1 sauber. Keine Festigkeits-, Luftstrom- oder Passungsprüfung am echten Teil.
