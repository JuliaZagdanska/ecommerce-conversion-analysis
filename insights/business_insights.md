# Business Insights

Google Merchandise Store · listopad 2020

## Observations

1. **7,07% oglądających spełniło warunek kolejności zdarzeń.** Spośród 21 440 oglądających 1 516 zarejestrowało pierwsze wyświetlenie przed pierwszym zakupem. Oba zdarzenia wystąpiły u 1 524 użytkowników, a zakup odnotowano u 1 532.
2. **Checkout odnotowano u większej liczby użytkowników niż dodanie do koszyka.** `begin_checkout` miało 4 219 użytkowników, a `add_to_cart` 2 060. Populację każdego zdarzenia policzono osobno.
3. **Mobile miał w tym okresie wyższy wskaźnik.** Wyniósł 7,43% (638 z 8 588 oglądających) na mobile i 6,83% (853 z 12 497) na desktopie. Różnica wynosi 0,60 p.p. przy wyświetlanej dokładności.

## Hypotheses to Test

1. **Część sesji z checkoutem może nie zawierać wcześniejszego zdarzenia dodania do koszyka.** W sesjach z `begin_checkout` sprawdzić, jaki odsetek ma wcześniejsze `add_to_cart`. Porównać sesje według urządzenia i strony wejścia, jeśli pola są dostępne.
2. **Udział poszczególnych źródeł ruchu może częściowo wyjaśniać różnicę między urządzeniami.** Porównać mobile i desktop w obrębie tego samego źródła ruchu, stosując tę samą definicję wskaźnika i podając liczebność grup.

## Recommendations

- Najpierw zweryfikować rejestrację zdarzeń koszyka i checkoutu na poziomie sesji, a dopiero potem zdefiniować etapy lejka.
- Obok wskaźników według urządzenia podawać licznik i mianownik. Porównanie segmentów wykorzystać do wskazania obszarów dalszej analizy.
- W kolejnych raportach podawać daty, mianownik i warunek kolejności obok wskaźnika view-to-purchase.

## Limitations

Wyniki dotyczą jednego miesiąca obfuskowanej próbki GA4. Kolejność zdarzeń nie pozwala powiązać wyświetlenia i zakupu z tym samym produktem ani potwierdzić pełnej ścieżki w jednej sesji. Porównanie urządzeń wskazuje zaobserwowaną różnicę bez ustalenia jej przyczyn.
