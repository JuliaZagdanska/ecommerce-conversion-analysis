# Aggregate data exports

Pliki zawierają zagregowane wyniki analizy publicznej próbki GA4 Google Merchandise Store z listopada 2020 r. Zawartość ogranicza się do liczebności, kategorii urządzeń, dat i obliczonych wskaźników.

| Plik | Zapytanie źródłowe | Poziom agregacji |
| --- | --- | --- |
| `funnel_events_nov2020.csv` | [`event_exploration.sql`](../sql/event_exploration.sql) | Jeden wiersz na rodzaj zdarzenia |
| `daily_purchases_nov2020.csv` | [`daily_purchasers.sql`](../sql/daily_purchasers.sql) | Jeden wiersz na datę raportową GA4 z zakupami |
| `device_conversion_nov2020.csv` | [`device_conversion.sql`](../sql/device_conversion.sql) | Jeden wiersz na kategorię urządzenia mobile i desktop |

Plik aktywności zachowuje oryginalną nazwę eksportu. Każdy wiersz to niezależna liczebność użytkowników dla danego zdarzenia. Notebook porządkuje zdarzenia na wykresie według typowej ścieżki zakupowej.

## Export from BigQuery

1. Otwórz zapytanie źródłowe w BigQuery Studio i uruchom je w trybie GoogleSQL.
2. W panelu **Results** wybierz **Save results** i pobierz plik CSV z nagłówkami.
3. Zapisz plik w tym folderze pod nazwą podaną w tabeli.
4. Do odtworzenia wskaźników z głównego README służy [`view_to_purchase.sql`](../sql/view_to_purchase.sql).

[Dokumentacja eksportu BigQuery](https://cloud.google.com/bigquery/docs/export-file)
