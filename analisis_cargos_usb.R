# Análisis de Cargos Académicos USB - Concurso de Credenciales 2026
# Convocatoria: 02/05/2026 – 18/05/2026 | Inicio: 01/09/2026
# Fuente: Solicitudes de Personal Académico por División (PDFs USB)

library(ggplot2)
library(dplyr)
library(tidyr)
library(forcats)
library(scales)
library(tibble)

# ── Datos ─────────────────────────────────────────────────────────────────────
cargos <- tribble(
  ~division, ~depto_codigo, ~depto_nombre,                                       ~id,        ~dedicacion, ~horas, ~n,
  # ── CB: Ciencias Biológicas ───────────────────────────────────────────────────
  "CB", "BL",   "Biología",                                                      "BL-01",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-02",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-03",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-04",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-05",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-06",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-07",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-08",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-09",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-10",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-11",    "DE",  40, 1,
  "CB", "BL",   "Biología",                                                      "BL-12",    "TI",  36, 1,
  "CB", "BL",   "Biología",                                                      "BL-13",    "TI",  36, 1,
  "CB", "BL",   "Biología",                                                      "BL-14",    "TI",  36, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-01",   "DE",  40, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-02",   "TI",  36, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-03",   "DE",  40, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-04",   "TI",  36, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-05",   "TI",  36, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-06",   "TI",  40, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-07",   "TI",  40, 1,
  "CB", "PBB",  "Procesos Biológicos y Bioquímicos",                             "PBB-08",   "TC",  40, 1,
  # ── CTAI: Ciencias y Tecnologías Administrativas e Industriales ───────────
  "CTAI", "FG", "Formación General",                                             "FG-01",    "TI",  36, 5,
  "CTAI", "FG", "Formación General",                                             "FG-02",    "TC",  12, 5,
  "CTAI", "FG", "Formación General",                                             "FG-03",    "TI",  36, 4,
  "CTAI", "FG", "Formación General",                                             "FG-04",    "TC",  12, 5,
  "CTAI", "FG", "Formación General",                                             "FG-05",    "TI",  36, 4,
  "CTAI", "FG", "Formación General",                                             "FG-07",    "TC",  12, 4,
  "CTAI", "FG", "Formación General",                                             "FG-08",    "TC",  12, 3,
  "CTAI", "FG", "Formación General",                                             "FG-09",    "TC",  12, 3,
  "CTAI", "FG", "Formación General",                                             "FG-10",    "TC",  12, 1,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-01",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-02",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-03",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-04",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-05",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-06",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-07",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-08",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-09",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-10",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-11",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-12",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-13",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-14",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-15",    "TC",  12, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-16",    "TI",  36, 2,
  "CTAI", "TS", "Tecnología y Servicios",                                        "TS-17",    "TC",  12, 2,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-01",    "TI",  36, 6,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-02",    "TI",  36, 6,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-03",    "TC",   8, 4,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-04",    "TC",  12, 4,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-05",    "TC",  12, 1,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-06",    "TC",   8, 2,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-07",    "TC",  12, 4,
  "CTAI", "TI", "Tecnología Industrial",                                         "TI-08",    "TC",   8, 4,
  # ── FyM: Física y Matemáticas ─────────────────────────────────────────────
  "FyM",  "MA", "Matemáticas",                                                   "MA-01",    "DE",  40, 5,
  "FyM",  "MA", "Matemáticas",                                                   "MA-02",    "DE",  40, 4,
  "FyM",  "MA", "Matemáticas",                                                   "MA-03",    "DE",  40, 5,
  "FyM",  "MA", "Matemáticas",                                                   "MA-04",    "DE",  40, 3,
  "FyM",  "MA", "Matemáticas",                                                   "MA-05",    "TC",  12, 1,
  "FyM",  "MA", "Matemáticas",                                                   "MA-06",    "TC",  12, 1,
  "FyM",  "FS", "Física",                                                        "FS-01",    "DE",  40, 3,
  "FyM",  "FS", "Física",                                                        "FS-02",    "DE",  40, 3,
  "FyM",  "FS", "Física",                                                        "FS-03",    "DE",  40, 4,
  "FyM",  "FS", "Física",                                                        "FS-04",    "DE",  40, 3,
  "FyM",  "FS", "Física",                                                        "FS-05",    "DE",  40, 2,
  "FyM",  "FS", "Física",                                                        "FS-06",    "TI",  36, 1,
  "FyM",  "FS", "Física",                                                        "FS-07",    "TC",  12, 2,
  "FyM",  "FS", "Física",                                                        "FS-08",    "TC",  12, 1,
  "FyM",  "QM", "Química",                                                       "QM-01",    "DE",  40, 5,
  "FyM",  "QM", "Química",                                                       "QM-02",    "DE",  40, 4,
  "FyM",  "QM", "Química",                                                       "QM-03",    "TC",  12, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-01",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-02",    "TC",   5, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-03",    "TC",  10, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-04",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-05",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-06",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-07",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-08",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-09",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-10",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-11",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-12",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-13",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-14",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-15",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-16",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-17",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-18",    "DE",  40, 1,
  "FyM",  "MC", "Mecánica",                                                      "MC-19",    "DE",  40, 1,
  "FyM",  "TF", "Termodinámica y Fenómenos de Transferencia",                    "TF-01",    "DE",  40, 1,
  "FyM",  "TF", "Termodinámica y Fenómenos de Transferencia",                    "TF-02",    "DE",  40, 2,
  "FyM",  "TF", "Termodinámica y Fenómenos de Transferencia",                    "TF-03",    "DE",  40, 1,
  "FyM",  "TF", "Termodinámica y Fenómenos de Transferencia",                    "TF-04",    "DE",  40, 1,
  "FyM",  "TF", "Termodinámica y Fenómenos de Transferencia",                    "TF-05",    "DE",  40, 1,
  "FyM",  "TF", "Termodinámica y Fenómenos de Transferencia",                    "TF-06",    "DE",  40, 1,
  "FyM",  "TF", "Termodinámica y Fenómenos de Transferencia",                    "TF-07",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-01",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-02",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-03",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-04",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-05",    "DE",  40, 2,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-06",    "TC",  12, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-07",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-08",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-09",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-10",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-11",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-12",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-13",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-14",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-15",    "TC",   6, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-16",    "DE",  40, 1,
  "FyM",  "EC", "Electrónica y Circuitos",                                       "EC-17",    "DE",  40, 1,
  "FyM",  "CT", "Computación",                                                   "CT-01",    "TC",   8, 1,
  "FyM",  "CT", "Computación",                                                   "CT-02",    "TC",   5, 1,
  "FyM",  "CT", "Computación",                                                   "CT-03",    "DE",  40, 1,
  "FyM",  "CT", "Computación",                                                   "CT-04",    "TC",   5, 1,
  "FyM",  "CT", "Computación",                                                   "CT-05",    "DE",  40, 1,
  "FyM",  "CT", "Computación",                                                   "CT-06",    "DE",  40, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-01",    "DE",  40, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-02",    "TI",  36, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-03",    "DE",  40, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-04",    "TI",  36, 4,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-05",    "TC",   8, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-06",    "TC",   8, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-07",    "DE",  40, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-08",    "DE",  40, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-09",    "TI",  36, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-10",    "TI",  36, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-11",    "TI",  36, 1,
  "FyM",  "PS", "Procesos y Sistemas",                                           "PS-12",    "TC",   4, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-01",    "DE",  40, 2,
  "FyM",  "MT", "Materiales",                                                    "MT-02",    "DE",  40, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-03",    "TC",   8, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-04",    "DE",  40, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-05",    "DE",  40, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-06",    "DE",  40, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-07",    "DE",  40, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-08",    "TC",   6, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-09",    "DE",  40, 2,
  "FyM",  "MT", "Materiales",                                                    "MT-10",    "TC",   8, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-11",    "TI",  36, 1,
  "FyM",  "MT", "Materiales",                                                    "MT-12",    "DE",  40, 1,
  "FyM",  "CI", "Ciencias de la Tierra",                                         "CI-01",    "TC",   8, 1,
  "FyM",  "CI", "Ciencias de la Tierra",                                         "CI-02",    "TC",   4, 2,
  "FyM",  "CI", "Ciencias de la Tierra",                                         "CI-03",    "DE",  40, 1,
  "FyM",  "CI", "Ciencias de la Tierra",                                         "CI-04",    "DE",  40, 4,
  "FyM",  "GC", "Geofísica",                                                     "GC-01",    "TC",  12, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-02",    "DE",  40, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-03",    "DE",  40, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-04",    "DE",  40, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-05",    "TC",   3, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-06",    "TC",  12, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-07",    "TC",   6, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-08",    "DE",  40, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-09",    "DE",  40, 1,
  "FyM",  "GC", "Geofísica",                                                     "GC-10",    "DE",  40, 1,
  # ── SyH: Ciencias Sociales y Humanidades ─────────────────────────────────
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-01",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-02",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-03",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-04",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-05",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-06",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-07",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-08",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-09",    "TI",  36, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-011",   "TC",   6, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-012",   "TC",   6, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-013",   "TC",   6, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-014",   "TC",   6, 1,
  "SyH",  "LL", "Lengua y Literatura",                                           "LL-015",   "TC",   6, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-01",  "TI",  36, 3,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-02",  "TI",  36, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-03",  "TI",  36, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-04",  "TI",  36, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-05",  "TI",  36, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-06",  "TI",  36, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-07",  "TC",  12, 2,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-08",  "TC",   4, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-09",  "TC",   4, 1,
  "SyH",  "DAAP","Dpto. de Arte y Arquitectura del Paisaje",                     "DAAP-10",  "TC",   3, 1,
  "SyH",  "ID",  "Idiomas",                                        "ID-01",    "DE",  40, 5,
  "SyH",  "ID",  "Idiomas",                                        "ID-02",    "TI",  36, 1,
  "SyH",  "ID",  "Idiomas",                                        "ID-03",    "TI",  36, 1,
  "SyH",  "ID",  "Idiomas",                                        "ID-04",    "TI",  36, 1,
  "SyH",  "ID",  "Idiomas",                                        "ID-05",    "TI",  36, 1,
  "SyH",  "ID",  "Idiomas",                                        "ID-06",    "TC",  12, 1,
  "SyH",  "ID",  "Idiomas",                                        "ID-07",    "TC",   8, 1,
  "SyH",  "ID",  "Idiomas",                                        "ID-08",    "TC",   8, 3,
  "SyH",  "ID",  "Idiomas",                                        "ID-09",    "TC",   8, 1,
  "SyH",  "CTC", "Ciencias del Comportamiento",                                  "CTC-01",   "TI",  36, 1,
  "SyH",  "CTC", "Ciencias del Comportamiento",                                  "CTC-02",   "TI",  36, 2,
  "SyH",  "CTC", "Ciencias del Comportamiento",                                  "CTC-03",   "TI",  36, 1,
  "SyH",  "CTC", "Ciencias del Comportamiento",                                  "CTC-04",   "TI",  36, 2,
  "SyH",  "CTC", "Ciencias del Comportamiento",                                  "CTC-05",   "TC",   6, 1,
  "SyH",  "CEA", "Ciencias Económicas y Administrativas",                        "CEA-05",   "TC",  12, 1,
  "SyH",  "CEA", "Ciencias Económicas y Administrativas",                        "CEA-09",   "TC",  12, 1,
  "SyH",  "CEA", "Ciencias Económicas y Administrativas",                        "CEA-010",  "TI",  36, 1,
  "SyH",  "CEA", "Ciencias Económicas y Administrativas",                        "CEA-011",  "TI",  36, 1,
  "SyH",  "CEA", "Ciencias Económicas y Administrativas",                        "CEA-013",  "TI",  36, 1,
  "SyH",  "FL",  "Filosofía",                                                    "FL-03",    "TC",   9, 1,
  "SyH",  "FL",  "Filosofía",                                                    "FL-04",    "TC",  12, 1,
  "SyH",  "FL",  "Filosofía",                                                    "FL-05",    "TC",  12, 1,
  "SyH",  "FL",  "Filosofía",                                                    "FL-06",    "TC",  12, 1,
  "SyH",  "FL",  "Filosofía",                                                    "FL-07",    "TC",  12, 1,
  "SyH",  "FL",  "Filosofía",                                                    "FL-08",    "TC",  12, 1,
  "SyH",  "PL",  "Planificación Urbana",                                         "PL-01",    "TI",  36, 1,
  "SyH",  "PL",  "Planificación Urbana",                                         "PL-02",    "TI",  36, 1,
  "SyH",  "PL",  "Planificación Urbana",                                         "PL-03",    "DE",  40, 1,
  "SyH",  "PL",  "Planificación Urbana",                                         "PL-04",    "TC",   9, 1,
  "SyH",  "PL",  "Planificación Urbana",                                         "PL-05",    "TC",   8, 1,
  "SyH",  "PL",  "Planificación Urbana",                                         "PL-06",    "TC",   8, 1,
  "SyH",  "PL",  "Planificación Urbana",                                         "PL-07",    "TI",  36, 1,
  "SyH",  "CS",  "Ciencias Sociales",                                            "CS-02",    "TI",  36, 1
)

# ── Paletas y tema ─────────────────────────────────────────────────────────────
colores_ded <- c(
  "DE" = "#003087",   # azul USB — Dedicación Exclusiva
  "TI" = "#E8A020",   # ámbar    — Tiempo Integral
  "TC" = "#CC2200"    # rojo     — Tiempo Convencional
)

colores_div <- c(
  "CB"   = "#1A6B3C",
  "CTAI" = "#5C3D8F",
  "FyM"  = "#003087",
  "SyH"  = "#CC2200"
)

nombres_div <- c(
  "CB"   = "Ciencias Biológicas",
  "CTAI" = "Cs. y Tecnologías\nAdministrativas e Industriales",
  "FyM"  = "Física y Matemáticas",
  "SyH"  = "Ciencias Sociales\ny Humanidades"
)

tema_usb <- theme_minimal(base_size = 14) +
  theme(
    plot.title      = element_text(face = "bold", size = 18, color = "#003087", margin = margin(b = 6)),
    plot.subtitle   = element_text(size = 12, color = "#555555", margin = margin(b = 12)),
    plot.caption    = element_text(size = 9,  color = "#888888", hjust = 0),
    plot.background = element_rect(fill = "white", color = NA),
    panel.grid.major= element_line(color = "#EEEEEE"),
    panel.grid.minor= element_blank(),
    axis.title      = element_text(face = "bold", color = "#333333"),
    axis.text       = element_text(color = "#333333"),
    legend.position = "bottom",
    legend.title    = element_text(face = "bold"),
    plot.margin     = margin(20, 24, 16, 20)
  )

pie_nota <- "Fuente: USB – Concurso de Credenciales 2026 (convocatoria 02/05/2026–18/05/2026)\nDE = Dedicación Exclusiva (40 h/sem) | TI = Tiempo Integral (36 h/sem) | TC = Tiempo Convencional (≤12 h/sem)"

# ── Tablas resumen ─────────────────────────────────────────────────────────────
por_div <- cargos |>
  group_by(division) |>
  summarise(total = sum(n), .groups = "drop") |>
  mutate(division = fct_reorder(division, total))

por_div_ded <- cargos |>
  group_by(division, dedicacion) |>
  summarise(total = sum(n), .groups = "drop") |>
  mutate(
    division  = factor(division,  levels = c("CB", "CTAI", "FyM", "SyH")),
    dedicacion = factor(dedicacion, levels = c("DE", "TI", "TC"))
  )

global_ded <- cargos |>
  group_by(dedicacion) |>
  summarise(total = sum(n), .groups = "drop") |>
  mutate(
    dedicacion = factor(dedicacion, levels = c("TC", "TI", "DE")),
    pct        = total / sum(total),
    label      = paste0(total, "\n(", percent(pct, accuracy = 1), ")")
  )

por_depto <- cargos |>
  group_by(division, depto_codigo, depto_nombre) |>
  summarise(total = sum(n), .groups = "drop")

# ── Resumen en consola ─────────────────────────────────────────────────────────
cat("\n═══════════════════════════════════════════════════════════════\n")
cat("  USB – CONCURSO DE CREDENCIALES 2026\n")
cat("  RESUMEN DE CARGOS ACADÉMICOS (total: 335)\n")
cat("═══════════════════════════════════════════════════════════════\n\n")

resumen_div <- cargos |>
  group_by(division, dedicacion) |>
  summarise(cargos = sum(n), .groups = "drop") |>
  pivot_wider(names_from = dedicacion, values_from = cargos, values_fill = 0) |>
  mutate(Total = rowSums(across(where(is.numeric)))) |>
  arrange(match(division, c("CB", "CTAI", "FyM", "SyH")))

print(resumen_div, n = Inf)
cat("\n")

cat("Top 10 departamentos por cargos:\n")
por_depto |>
  slice_max(total, n = 10) |>
  arrange(desc(total)) |>
  mutate(depto = paste0(depto_codigo, " (", division, ")")) |>
  select(Departamento = depto, Nombre = depto_nombre, Cargos = total) |>
  print(n = 10)

cat("\n═══════════════════════════════════════════════════════════════\n\n")

# ── PLOT 1: Cargos totales por División ───────────────────────────────────────
p1 <- ggplot(por_div, aes(x = division, y = total, fill = division)) +
  geom_col(width = 0.65, show.legend = FALSE) +
  geom_text(aes(label = total), vjust = -0.5, fontface = "bold", size = 5.5, color = "#222222") +
  scale_fill_manual(values = colores_div) +
  scale_x_discrete(labels = nombres_div) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.12))) +
  labs(
    title    = "Cargos académicos abiertos por División — USB 2026",
    subtitle = "335 cargos en total · inicio de clases: 01/09/2026",
    x        = "División",
    y        = "Número de cargos",
    caption  = pie_nota
  ) +
  tema_usb

ggsave("plot1_cargos_por_division.png", p1,
       width = 10, height = 7, dpi = 150, bg = "white")
message("✓ plot1_cargos_por_division.png guardado")

# ── PLOT 2: Cargos por División y Dedicación (stacked) ────────────────────────
p2 <- ggplot(por_div_ded, aes(x = division, y = total, fill = dedicacion)) +
  geom_col(width = 0.65, position = "stack") +
  geom_text(
    aes(label = ifelse(total > 0, total, "")),
    position = position_stack(vjust = 0.5),
    fontface = "bold", size = 4.5, color = "white"
  ) +
  scale_fill_manual(
    values = colores_ded,
    name   = "Dedicación",
    labels = c("DE – Exclusiva (40h)", "TI – Integral (36h)", "TC – Convencional (≤12h)")
  ) +
  scale_x_discrete(labels = nombres_div) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.06))) +
  labs(
    title    = "Cargos académicos por División y tipo de dedicación — USB 2026",
    subtitle = "Convocatoria: 02 al 18 de mayo de 2026",
    x        = "División",
    y        = "Número de cargos",
    caption  = pie_nota
  ) +
  tema_usb +
  guides(fill = guide_legend(nrow = 1))

ggsave("plot2_division_por_dedicacion.png", p2,
       width = 11, height = 7.5, dpi = 150, bg = "white")
message("✓ plot2_division_por_dedicacion.png guardado")

# ── PLOT 3: Distribución global de dedicación (barras horizontales) ────────────
p3 <- ggplot(global_ded, aes(x = dedicacion, y = total, fill = dedicacion)) +
  geom_col(width = 0.55, show.legend = FALSE) +
  geom_text(aes(label = label), hjust = -0.1, fontface = "bold", size = 5, color = "#222222") +
  coord_flip() +
  scale_fill_manual(values = colores_ded) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.25))) +
  scale_x_discrete(labels = c(
    "TC" = "TC\nConvencional\n(≤12 h/sem)",
    "TI" = "TI\nIntegral\n(36 h/sem)",
    "DE" = "DE\nExclusiva\n(40 h/sem)"
  )) +
  labs(
    title    = "Distribución global de cargos por tipo de dedicación — USB 2026",
    subtitle = "Sobre un total de 335 cargos en las cuatro Divisiones",
    x        = NULL,
    y        = "Número de cargos",
    caption  = pie_nota
  ) +
  tema_usb

ggsave("plot3_distribucion_dedicacion.png", p3,
       width = 10, height = 6.5, dpi = 150, bg = "white")
message("✓ plot3_distribucion_dedicacion.png guardado")

# ── PLOT 4: Top 15 departamentos por cargos ───────────────────────────────────
top15 <- por_depto |>
  slice_max(total, n = 15) |>
  mutate(
    etiqueta = paste0(depto_codigo, "\n(", division, ")"),
    etiqueta = fct_reorder(etiqueta, total)
  )

p4 <- ggplot(top15, aes(x = etiqueta, y = total, fill = division)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = total), hjust = -0.2, fontface = "bold", size = 4.5, color = "#222222") +
  coord_flip() +
  scale_fill_manual(values = colores_div, name = "División", labels = nombres_div) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.18))) +
  labs(
    title    = "Top 15 departamentos con más cargos académicos — USB 2026",
    subtitle = "Concurso de Credenciales · inicio de clases: 01/09/2026",
    x        = NULL,
    y        = "Número de cargos",
    caption  = pie_nota
  ) +
  tema_usb

ggsave("plot4_top15_departamentos.png", p4,
       width = 11, height = 8, dpi = 150, bg = "white")
message("✓ plot4_top15_departamentos.png guardado")

# ── PLOT 5: Todos los departamentos por División (facetado) ───────────────────
depto_completo <- por_depto |>
  mutate(
    depto_label = depto_nombre,
    depto_label = fct_reorder2(depto_label, division, total)
  )

p5 <- ggplot(depto_completo, aes(x = fct_reorder(depto_label, total), y = total, fill = division)) +
  geom_col(width = 0.75, show.legend = FALSE) +
  geom_text(aes(label = total), hjust = -0.2, size = 3.2, fontface = "bold", color = "#222222") +
  coord_flip() +
  facet_wrap(~division, scales = "free_y", ncol = 2,
             labeller = labeller(division = c(
               "CB"   = "Ciencias Biológicas",
               "CTAI" = "Cs. y Tecnologías Administrativas e Industriales",
               "FyM"  = "Física y Matemáticas",
               "SyH"  = "Ciencias Sociales y Humanidades"
             ))) +
  scale_fill_manual(values = colores_div) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.22))) +
  labs(
    title    = "Cargos académicos por departamento y División — USB 2026",
    subtitle = "Concurso de Credenciales · 335 cargos en 24 departamentos",
    x        = NULL,
    y        = "Número de cargos",
    caption  = pie_nota
  ) +
  tema_usb +
  theme(
    strip.text       = element_text(face = "bold", size = 13, color = "white"),
    strip.background = element_rect(fill = "#003087", color = NA),
    panel.spacing    = unit(1.2, "lines")
  )

ggsave("plot5_todos_departamentos_facetado.png", p5,
       width = 14, height = 12, dpi = 150, bg = "white")
message("✓ plot5_todos_departamentos_facetado.png guardado")

message("\nTodos los gráficos guardados en: ", getwd())
