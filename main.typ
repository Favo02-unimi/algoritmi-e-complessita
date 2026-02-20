#import "template.typ": *

#show: academic-notes.with(
  // --- Required
  title: "Algoritmi e Complessità",
  subtitle: "Università degli Studi di Milano - Informatica Magistrale",
  authors: (
    ("Luca Favini", "Favo02"),
    ("Luca Corradini", "LucaCorra02"),
  ),
  lang: "it",

  // --- Optional, uncomment to change
  repo-url: "https://github.com/Favo02/algoritmi-e-complessita",
  course-url: "https://boldi.di.unimi.it/Corsi/AlgComp2025/",
  year: "2025/26",
  lecturer: "Paolo Boldi",
  // date: datetime.today(),
  // license: "CC-BY-4.0",
  // license-url: "https://creativecommons.org/licenses/by/4.0/",
  // heading-numbering: "1.1.",
  // equation-numbering: none,
  // page-numbering: "1",

  // --- Optional with language-based defaults, uncomment to change
  // introduction: auto,
  // last-modified-label: auto,
  // outline-title: auto,
  // part-label: auto,
  // note-title: auto,
  // warning-title: auto,
  // informally-title: auto,
  // example-title: auto,
  // proof-title: auto,
  // theorem-title: auto,
  // theorem-label: auto,
  // equation-supplement: auto,
  // figure-supplement: auto,
)

// content

#part("Fondamenti")
#include "chapters/1-notazione.typ"
#include "chapters/2-problemi-e-algoritmi.typ"
#include "chapters/3-classi-di-complessita.typ"

#part("Algoritmi di Approssimazione")
#include "chapters/4-problema-max-bimatching.typ"
#include "chapters/5-problema-load-balancing.typ"
#include "chapters/6-problema-center-selection.typ"
#include "chapters/7-problema-set-cover.typ"
#include "chapters/8-problema-vertex-cover.typ"
#include "chapters/9-problema-congested-paths.typ"
#include "chapters/10-problema-tsp-metrico.typ"
#include "chapters/11-problema-knapsack.typ"

#part("Algoritmi Probabilistici")
#include "chapters/12-algoritmi-probabilistici.typ"
#include "chapters/13-problema-min-cut.typ"
#include "chapters/14-problema-set-cover.typ"
#include "chapters/15-problema-max-ek-sat.typ"

#part("Teoria della Complessità di Approssimazione")
#include "chapters/16-teorema-pcp.typ"

#part("Strutture Dati Compresse")
#include "chapters/17-strutture-dati-compresse.typ"
#include "chapters/18-struttura-rango-e-selezione.typ"
#include "chapters/19-struttura-albero.typ"
#include "chapters/20-struttura-sequenza-monotona.typ"
#include "chapters/21-struttura-funzione.typ"
