# Guide d'installation — Cours IA & Cybersécurité · M1
**École d'ingénieurs aéronautique et spatiale · 2025-2026**

---

## Vue d'ensemble

Ce guide vous permet de mettre en place l'environnement Python nécessaire pour tous les TPs du cours. Comptez **15 à 20 minutes** la première fois.

```
Votre machine
├── Python 3.10+
├── Environnement virtuel  ← isolé, propre, reproductible
│   └── toutes les bibliothèques du cours
├── JupyterLab             ← interface pour les notebooks
└── Kaggle API             ← pour télécharger les datasets réels
```

---

## Étape 1 — Vérifier Python

Ouvrez un terminal et tapez :

```bash
python3 --version
```

Vous devez voir `Python 3.10.x` ou supérieur.  
Si Python n'est pas installé : [python.org/downloads](https://www.python.org/downloads/) (cochez **"Add to PATH"** sous Windows).

---

## Étape 2 — Récupérer le dépôt du cours

```bash
git clone https://github.com/pierremarielore-oss/ia-cyber-m1.git
cd ia-cyber-m1
```

Si git n'est pas installé : [git-scm.com](https://git-scm.com/downloads)

---

## Étape 3 — Créer l'environnement virtuel

```bash
# Créer l'environnement (une seule fois)
python3 -m venv venv

# L'activer (à faire à chaque nouvelle session)
source venv/bin/activate          # macOS / Linux
# ou
venv\Scripts\activate             # Windows
```

> ✅ Votre invite de commande doit afficher `(venv)` au début.

---

## Étape 4 — Installer les dépendances

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

L'installation prend 3 à 5 minutes selon votre connexion. C'est normal.

---

## Étape 5 — Configurer l'accès Kaggle

Kaggle est une plateforme gratuite qui héberge les datasets utilisés dans les TPs 5 et 6.

### 5.1 Créer un compte Kaggle

1. Allez sur [kaggle.com](https://www.kaggle.com) et créez un compte gratuit
2. Cliquez sur votre avatar → **Settings**
3. Section **API** → cliquez **Create New Token**
4. Un fichier `kaggle.json` se télécharge

### 5.2 Placer la clé

```bash
# macOS / Linux
mkdir -p ~/.config/kaggle
mv ~/Downloads/kaggle.json ~/.config/kaggle/kaggle.json
chmod 600 ~/.config/kaggle/kaggle.json

# Windows (PowerShell)
mkdir "$env:USERPROFILE\.config\kaggle" -Force
Move-Item "$env:USERPROFILE\Downloads\kaggle.json" "$env:USERPROFILE\.config\kaggle\kaggle.json"
```

> 🔒 `chmod 600` protège votre clé : elle ne sera lisible que par vous.  
> Ne partagez jamais ce fichier — il donne accès à votre compte Kaggle.

### 5.3 Vérifier

```bash
kaggle datasets list
```

Si vous voyez une liste de datasets, c'est bon.

---

## Étape 6 — Lancer JupyterLab

```bash
# Depuis le dossier ia-cyber-m1, environnement venv activé :
jupyter lab
```

Le navigateur s'ouvre automatiquement sur `http://localhost:8888`.  
Naviguez dans le dossier `tp/` pour accéder aux notebooks.

> 💡 **Astuce** : ajoutez un alias dans votre terminal pour aller plus vite :
> ```bash
> echo 'alias jl="cd ~/ia-cyber-m1 && source venv/bin/activate && jupyter lab"' >> ~/.bashrc
> source ~/.bashrc
> ```
> Ensuite, tapez simplement `jl` pour tout lancer d'un coup.

---

## Structure du dépôt

```
ia-cyber-m1/
├── SETUP.md                  ← ce guide
├── requirements.txt          ← dépendances Python
└── tp/
    ├── TP_S1/
    │   └── TP_S1_symbolique.ipynb          — IA symbolique : règles & systèmes experts
    ├── TP_S2/
    │   └── TP_S2_ontologies.ipynb          — Ontologies & graphes (MITRE ATT&CK)
    ├── TP0/
    │   └── TP0_perceptron_debutant.ipynb   — Mon premier neurone (très guidé)
    ├── TP1/
    │   └── TP1_perceptron.ipynb            — Perceptron NumPy + PyTorch
    ├── TP2/
    │   └── TP2_ueba.ipynb                  — UEBA : K-Means & Isolation Forest
    ├── TP4/
    │   └── TP4_reseau_neurones.ipynb       — Réseau multicouches (MLP)
    ├── TP5/
    │   └── TP5_ia_generative.ipynb         — IA générative & sécurité LLMs
    └── TP6/
        └── TP6_defensive_ai.ipynb          — IDS par Machine Learning
```

---

## Résolution des problèmes fréquents

| Problème | Solution |
|---|---|
| `python3` introuvable | Réinstallez Python en cochant "Add to PATH" |
| `(venv)` n'apparaît pas | Relancez `source venv/bin/activate` |
| `ModuleNotFoundError` | Vérifiez que le venv est activé puis `pip install NOM` |
| JupyterLab ne s'ouvre pas | Copiez l'URL avec le token depuis le terminal |
| Port 8888 occupé | `jupyter lab --port 8889` |
| Kaggle : `401 Unauthorized` | Vérifiez l'emplacement de `kaggle.json` (section 5.2) |
| Kaggle : `403 Forbidden` | Acceptez les conditions d'utilisation du dataset sur kaggle.com |
| Téléchargement Kaggle lent | Normal pour les gros datasets — patientez |

---

## Mise à jour des notebooks

L'enseignant peut corriger ou ajouter des fichiers pendant le semestre.  
Pour récupérer les dernières versions :

```bash
cd ia-cyber-m1
git pull
```

> ⚠️ Si vous avez modifié un notebook, Git refusera le pull. Sauvegardez d'abord votre travail sous un autre nom (ex : `TP4_mon_travail.ipynb`), puis faites `git pull`.

---

*Cours IA & Cybersécurité · M1 · 2025-2026*
