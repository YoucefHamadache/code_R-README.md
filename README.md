# 📊 Scripts R – Reproduction des Dynamiques du Chômage

## 📘 Mémoire :  
**Le Chômage : Mécanisme et Reproduction de Graphiques**  
Université Paris 8 – 2023/2024  

Auteurs :  
- Hamadache Youcef  
- Rahou Aymen  
- Zenagui Walid  

---

# 🎯 Objectif du Code

Ces scripts R permettent de reproduire empiriquement :

- Le taux de chômage par niveau d’éducation  
- Le taux de sortie du chômage (Outflow / Hazard rate)  
- Le taux d’entrée dans le chômage (Inflow)  
- Les graphiques lissés correspondants  

Les calculs sont réalisés à partir des données du **Current Population Survey (CPS)** couvrant la période 1976–2015.

---

# 📂 Description des Scripts

---

## 1️⃣ propre 2.0.R (Script principal)

### 🔹 Importation des données

```r
MM <- read.csv("hcud-sample25-edu2.csv")
```

La base `MM` contient :

- Employed  
- Unemployed  
- Short-Term Unemployed  
- Ratios  
- Year  
- Variables par niveau d’éducation  

---

### 🔹 Calcul du taux de chômage

Formule utilisée :

Txchô = (U / (E + U)) × 100

Variables créées :

- TxchôAll  
- TxchôLH  
- TxchôHS  
- TxchôSC  
- TxchôC  

---

### 🔹 Correction de la discontinuité CPS (janvier 1994)

Suite au changement méthodologique du CPS :

1. Calcul de la moyenne des ratios entre 1994–2015  
2. Reconstruction des séries Short-Term Unemployed  
3. Création des variables ajustées : UST1_*  

---

### 🔹 Calcul du Outflow (probabilité de sortie)

Formule :

Ft = 1 - (U(t+1) - Us(t+1)) / U(t)

Puis transformation en hazard rate :

ft = -log(1 - Ft)

Variables obtenues :

- ft  
- ft_LH  
- ft_HS  
- ft_SC  
- ft_C  

Ces variables mesurent l’intensité de sortie du chômage.

---

## 2️⃣ solution de x.R (Calcul du Inflow)

Ce script résout numériquement une équation via `uniroot()` :

(1 - exp(-(ft + x))) * x/(ft + x) * LabourForce  
+ exp(-(ft + x)) * U_t  
- U(t+1) = 0  

Pour chaque période, on obtient :

- x_LH  
- x_HS  
- x_SC  
- x_C  

Ces variables représentent le **taux d’entrée dans le chômage (Inflow rate)**.

---

## 3️⃣ graphique 1 Txchô.R

Production du graphique du taux de chômage par niveau d’éducation.

Méthode :

```r
loess(..., span = 0.2)
```

Affichage comparatif des catégories :

- Less than High School  
- High School  
- Some College  
- College  

---

## 4️⃣ Graphique 2 Outflow rate.R

Graphique du Hazard Rate (ft × 100).

Étapes :

- Nettoyage des valeurs NA  
- Lissage LOESS  
- Superposition des courbes  

Montre les différences de dynamique de sortie du chômage.

---

## 5️⃣ Graphique 3 Inflow rate.R

Graphique du taux d’entrée dans le chômage :

- x_LH  
- x_HS  
- x_SC  
- x_C  

Même méthode :

- Nettoyage  
- Lissage LOESS  
- Visualisation comparative  

---

# ▶️ Ordre d’exécution recommandé

1. propre 2.0.R  
2. solution de x.R  
3. graphique 1 Txchô.R  
4. Graphique 2 Outflow rate.R  
5. Graphique 3 Inflow rate.R  

---

# 📈 Résultats Économiques

Les scripts confirment :

- Corrélation négative entre niveau d’éducation et taux de chômage  
- Volatilité plus forte chez les moins diplômés  
- Meilleure stabilité d’emploi pour les diplômés universitaires  
- Rôle central du capital humain  

---

# 🛠 Technologies utilisées

- Base R  
- LOESS smoothing  
- Résolution numérique (uniroot)  
- Analyse de séries temporelles  

---

# 📌 Conclusion

Ces scripts permettent de reproduire fidèlement les mécanismes de flux du chômage étudiés par Cairo & Cajner (2018) et mettent en évidence l’impact structurant du niveau d’éducation sur la stabilité du marché du travail.
