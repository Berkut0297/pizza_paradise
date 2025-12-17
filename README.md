## Tagok
- **Tokai Ádám & Kis Marcell Zsombor**

---

# Indítás

### Webszerver szimuláció
1. Indítsa el a **XAMPP Control Panel** alkalmazást.
2. Kapcsolja be az alábbi modulokat:
   - Apache
   - MySQL

---

### Adatbázis importálása (ELSŐ indítás esetén szükséges)
1. Kattintson a **MySQL Admin** gombra.
2. A bal oldali menüben kattintson az **Új** elemre.
3. Adja meg az adatbázis nevét: `pizzaparadise`.
4. A mellette lévő legördülő menüben válassza az `utf8mb4_general_ci` karakterkódolást.
5. Kattintson a **Létrehozás** gombra.
6. A felső menüben kattintson az **Importálás** menüpontra.
7. Kattintson a **Fájl kiválasztása** gombra, majd navigáljon a következő útvonalra:  
   `\pizza_paradise\WEB\db\pizzaparadise.sql`
8. Válassza ki a fájlt, majd kattintson a **Megnyitás** gombra.

---

### Weblap indítása
1. Nyissa meg a böngészőt.
2. A felső címsorba írja be a következő URL-t:  
    `http://localhost/"Almappa neve"/pizza_paradise/WEB`
---

# Hivatkozások
- **GitHub repo:** [https://github.com/Berkut0297/pizza_paradise](https://github.com/Berkut0297/pizza_paradise)
- **Trello board:** [https://trello.com/b/ldym4MkP/pizza-paradise-vizsgaremek](https://trello.com/b/ldym4MkP/pizza-paradise-vizsgaremek)

---

### Projekt leírás
A **Pizza Paradise** egy pizzarendelő webalkalmazás, ahol a felhasználók:
- böngészhetnek a kínálatban,
- testre szabhatják rendeléseiket,
- és egyszerűen leadhatják a megrendelést.

A projekt célja egy **letisztult, felhasználóbarát rendelési élmény** kialakítása.
