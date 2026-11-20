# E-commerce Conversion Analysis

## Project Overview

Analiza aktywności zakupowej w **Google Merchandise Store** od 1 do 30 listopada 2020 r. Projekt łączy zapytania SQL, eksplorację eksportów w Pythonie i dashboard w Looker Studio.

[Otwórz dashboard](https://datastudio.google.com/reporting/cbaa9ff4-41ed-47cd-8f8d-b98d650fef40/page/OB2DG) · [Przejdź do wniosków biznesowych](insights/business_insights.md)

## Business Questions

- Ilu użytkowników obejrzało produkt, dodało go do koszyka, rozpoczęło zamówienie lub dokonało zakupu?
- Jaki odsetek osób wyświetlających produkty zarejestrował pierwszy zakup po pierwszym wyświetleniu?
- Jak zmieniała się dzienna liczba kupujących i jak wyglądało porównanie mobile i desktop?

## Dataset Description

Źródłem jest publiczny, zanonimizowany przez obfuskację eksport zdarzeń GA4 dla Google Merchandise Store. Zapytania korzystają z tabel `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` dla okresu **1–30 listopada 2020 r.** W repozytorium są trzy zagregowane eksporty CSV użyte w raporcie. [Dokumentacja zbioru Google](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset)

## Tools & Technologies

| Narzędzie | Zastosowanie |
| --- | --- |
| Google BigQuery / GoogleSQL | Agregacja zdarzeń i porównanie czasu pierwszych zdarzeń |
| Python / Pandas / Matplotlib | Walidacja i eksploracja CSV oraz wykres aktywności |
| Looker Studio | Dashboard i prezentacja wyników |
| GitHub | Kod, dane zagregowane i dokumentacja |

## Methodology

1. **Aktywność według zdarzenia.** Dla każdego zdarzenia osobno zliczam unikalne, niepuste wartości `user_pseudo_id`. Ten sam użytkownik może wystąpić w kilku kategoriach.
2. **View-to-purchase rate.** Dla każdego użytkownika wyznaczam pierwsze `view_item` i pierwsze `purchase` w listopadzie na podstawie `event_timestamp`. Licznik obejmuje użytkowników, dla których pierwsze wyświetlenie było ściśle wcześniejsze niż pierwszy zakup. Mianownik obejmuje wszystkich użytkowników z `view_item` w tym okresie.
3. **Kupujący według dnia.** Liczę unikalnych użytkowników z `purchase` dla każdej daty raportowej GA4 (`event_date`). Użytkownik kupujący w dwóch dniach wystąpi w obu zliczeniach.
4. **Konwersja według urządzenia.** Wyznaczam pierwsze zdarzenia osobno dla każdej pary użytkownik–kategoria urządzenia. Mianownik obejmuje osoby, które oglądały produkty w danej kategorii mobile lub desktop. Użytkownik może wystąpić w obu kategoriach.

## Key Metrics

| Metryka | Wynik |
| --- | ---: |
| Użytkownicy wyświetlający produkt | 21 440 |
| Użytkownicy ze zdarzeniem `add_to_cart` | 2 060 |
| Użytkownicy ze zdarzeniem `begin_checkout` | 4 219 |
| Kupujący | 1 532 |
| Użytkownicy z oboma zdarzeniami `view_item` i `purchase` | 1 524 |
| Użytkownicy, których pierwsze `view_item` poprzedziło pierwsze `purchase` | 1 516 |
| View-to-purchase rate | **7,07%** |

Po zaokrągleniu **1 516 ÷ 21 440 × 100 = 7,07%**.

## Dashboard Preview

Dashboard pokazuje trzy KPI, aktywność według zdarzeń, dzienną liczbę kupujących i porównanie mobile z desktopem. Wartość 7,07% jest stałą wartością dla listopada. [Otwórz raport w Looker Studio](https://datastudio.google.com/reporting/cbaa9ff4-41ed-47cd-8f8d-b98d650fef40/page/OB2DG)

![Raport za listopad 2020. Trzy wskaźniki KPI, liczebności zdarzeń, konwersja według urządzenia i dzienna liczba kupujących.](dashboard/dashboard.png)

## Key Findings

- **Kolejność zdarzeń wpływa na licznik.** Spośród 1 524 użytkowników z wyświetleniem i zakupem 1 516 spełniło warunek kolejności.
- **Checkout odnotowano u większej liczby osób niż dodanie do koszyka.** Zdarzenie `begin_checkout` miało 4 219 użytkowników, a `add_to_cart` 2 060. Te liczebności nie pozwalają określić, ilu użytkowników przeszło z jednego etapu do drugiego.
- **W badanym okresie wskaźnik był wyższy na mobile.** Wyniósł 7,43% (638 z 8 588) na mobile i 6,83% (853 z 12 497) na desktopie. Różnica wyniosła 0,60 p.p. przy wyświetlanej dokładności.

## Business Recommendations

1. Zweryfikować rejestrację i kolejność zdarzeń koszyka oraz checkoutu na poziomie sesji przed budową lejka.
2. Raportować licznik i mianownik obok wskaźnika dla każdego urządzenia, a różnicę sprawdzić w porównywalnych grupach według źródła ruchu.
3. Przy każdym użyciu wskaźnika podawać okres analizy oraz dokładną definicję populacji i kolejności zdarzeń.

## Data Limitations

- Jednostką analizy jest pseudonimowy identyfikator użytkownika GA4. Metryka nie mierzy konwersji na poziomie sesji ani zakupu tego samego produktu, który wcześniej wyświetlono.
- Warunek kolejności obejmuje dwa zdarzenia. Cztery liczebności raportowane osobno nie potwierdzają pełnej ścieżki zakupowej.
- Granice listopada mogą wykluczać wcześniejsze wyświetlenia lub późniejsze zakupy. Równe znaczniki czasu nie spełniają warunku ścisłej kolejności.
- Porównanie urządzeń ma charakter opisowy. Obfuskacja danych może wpływać na ich wewnętrzną spójność. [Ograniczenia zbioru Google](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset#limitations)

## Repository Structure

| Ścieżka | Zawartość |
| --- | --- |
| [`sql/`](sql/) | Cztery zapytania odtwarzające analizę w BigQuery |
| [`python/ecommerce_analysis.ipynb`](python/ecommerce_analysis.ipynb) | Kontrola jakości eksportów, krótka eksploracja i wykres zdarzeń |
| [`data/`](data/) | Zagregowane CSV i instrukcja eksportu |
| [`dashboard/`](dashboard/) | Link i pełny podgląd istniejącego raportu |
| [`insights/`](insights/) | Obserwacje, hipotezy i rekomendacje |

## How to Reproduce the Analysis

1. W BigQuery Studio uruchom cztery zapytania z [`sql/`](sql/) w trybie GoogleSQL.
2. Porównaj metryki z tabelą powyżej. W razie potrzeby zapisz ponownie wyniki jako CSV według [instrukcji eksportu](data/README.md). Do pracy z dołączonymi CSV wystarczy lokalny Python.
3. W głównym katalogu repozytorium zainstaluj biblioteki i otwórz notebook.

   ```bash
   python -m pip install jupyterlab pandas matplotlib
   python -m jupyterlab python/ecommerce_analysis.ipynb
   ```

4. Uruchom wszystkie komórki. Notebook wczyta trzy eksporty, sprawdzi braki i duplikaty oraz narysuje wykres aktywności.

Wyniki czterech zapytań sprawdzono w BigQuery. Odtworzono wartości z tabeli metryk i potwierdzono zgodność wszystkich wierszy trzech eksportów. Notebook uruchomiono na dołączonych danych.
