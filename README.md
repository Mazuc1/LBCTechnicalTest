# LBCTechnicalTest

POC réalisé dans le cadre d'un test technique pour Leboncoin.

# ⚙️ Côté tech

Architecture MVVM-R
Combine
Auto-layout
iOS 14.0+
Aucune librairies utilisées

# 👀

![Simulator Screenshot - iPhone 14 Pro - 2023-05-08 at 21 40 16](https://user-images.githubusercontent.com/42061402/236917529-fa64b247-221d-4b82-bf82-dcc66498d6fa.png)

# 📈 Ce qui aurait pu être améliorée

Côté UI / UX, tout aurait pu être améliorée indéfiniment. J'ai dû faire un compromis temps/UIUX qui ne m'as pas permis d'exploiter toutes les idées que j'avais.
La UI/UX sur iPad est fonctionnelle bien que cela sois moins agréable que sur iPhone.

Côté tech, on aurait pu avoir une pagination (pas fournis par l'endpoint), une injection de dépendance...

Je n'ai volontairement pas fait de branche pour découper mon travail mais si ça avait été le cas, voilà comment je l'aurais découpé:
- Setup global du projet
- Création de la UI de la list avec des données mocké
- Création du service & affichage dynamique des données
- Gestions des états (erreur, aucun résultat)
- Filtrer par catégories
- Vue détails
