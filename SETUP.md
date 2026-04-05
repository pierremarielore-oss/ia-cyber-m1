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
└── Kaggle API             ← pour télécharger les datasets réels (TP5, TP6)
```

---

## Étape 1 — Vérifier Python

Ouvrez un terminal et tapez :

```bash
python3 --version
```

Vous devez voir `Python 3.10.x` ou supérieur.  
Si Python n'est pas installé : [python.org/downloads](https://www.python.org/downloads/)  
→ Sous Windows, cochez impérativement **"Add Python to PATH"** pendant l'installation.

---

## Étape 2 — Récupérer le dépôt du cours

```bash
git clone https://github.com/pierremarielore-oss/ia-cyber-m1.git
cd ia-cyber-m1
```

> Pas besoin de compte GitHub — le dépôt est public.  
> Si git n'est pas installé : [git-scm.com](https://git-scm.com/downloads)

---

## Étape 3 — Créer l'environnement virtuel

```bash
# Créer l'environnement (une seule fois)
python3 -m venv venv

# L'activer — à refaire à chaque nouvelle session terminal
source venv/bin/activate          # macOS / Linux
venv\Scripts\activate             # Windows
```

> ✅ Votre invite de commande doit afficher `(venv)` au début.  
> Si ce n'est pas le cas, l'environnement n'est pas actif — les bibliothèques ne seront pas trouvées.

---

## Étape 4 — Installer les dépendances

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

L'installation prend 3 à 5 minutes selon votre connexion. C'est normal.

---

## Étape 5 — Configurer l'accès Kaggle

Kaggle est une plateforme gratuite qui héberge les datasets utilisés dans les TP5 et TP6.

### 5.1 Créer un compte Kaggle

1. Allez sur [kaggle.com](https://www.kaggle.com) et créez un compte gratuit
2. Cliquez sur votre avatar en haut à droite → **Settings**
3. Section **API** → cliquez **Create New Token**
4. Un fichier `kaggle.json` se télécharge automatiquement

### 5.2 Placer la clé

**macOS / Linux :**
```bash
mkdir -p ~/.config/kaggle
mv ~/Downloads/kaggle.json ~/.config/kaggle/kaggle.json
chmod 600 ~/.config/kaggle/kaggle.json
```

**Windows (PowerShell) :**
```powershell
mkdir "$env:USERPROFILE\.config\kaggle" -Force
Move-Item "$env:USERPROFILE\Downloads\kaggle.json" "$env:USERPROFILE\.config\kaggle\kaggle.json"
```

> 🔒 `chmod 600` protège votre clé : elle ne sera lisible que par vous.  
> Ne partagez jamais ce fichier — il donne accès à votre compte Kaggle.

### 5.3 Vérifier

```bash
kaggle datasets list
```

Si vous voyez une liste de datasets s'afficher, c'est bon.

---

## Étape 6 — Lancer JupyterLab

```bash
# Depuis le dossier ia-cyber-m1, environnement venv activé :
jupyter lab
```

Le navigateur s'ouvre automatiquement sur `http://localhost:8888`.  
Naviguez dans le dossier `tp/` pour accéder aux notebooks.

> 💡 **Astuce** : ajoutez un alias dans votre terminal pour tout lancer en une commande :
> ```bash
> echo 'alias jl="cd ~/ia-cyber-m1 && source venv/bin/activate && jupyter lab"' >> ~/.bashrc
> source ~/.bashrc
> ```
> Ensuite, tapez simplement `jl` pour démarrer.

---

## Structure du dépôt

```
ia-cyber-m1/
├── SETUP.md                          ← ce guide
├── requirements.txt                  ← dépendances Python
└── tp/
    ├── tp_s1_symbolique/             — IA symbolique : règles & systèmes experts
    ├── tp_s2_ontologies/             — Ontologies & graphes (MITRE ATT&CK)
    ├── tp0_perceptron_debutant/      — Mon premier neurone (très guidé)
    ├── tp1_perceptron/               — Perceptron NumPy + PyTorch
    ├── tp2_ueba_non_supervise/       — UEBA : K-Means & Isolation Forest
    ├── tp4_reseau_neurones/          — Réseau multicouches (MLP)
    ├── tp5_ia_generative/            — IA générative & sécurité LLMs
    └── tp6_defensive_ai/             — IDS par Machine Learning
```

---

## Mettre à jour les notebooks

L'enseignant peut corriger ou ajouter des fichiers pendant le semestre.  
Pour récupérer les dernières versions :

```bash
cd ia-cyber-m1
git pull
```

> ⚠️ Si vous avez modifié un notebook, Git peut refuser le pull.  
> Sauvegardez d'abord votre travail sous un autre nom (ex : `TP4_mon_travail.ipynb`), puis faites `git pull`.

---

## Résolution des problèmes fréquents

| Problème | Solution |
|---|---|
| `python3` introuvable | Réinstallez Python en cochant "Add to PATH" |
| `(venv)` n'apparaît pas | Relancez `source venv/bin/activate` |
| `ModuleNotFoundError` | Vérifiez que le venv est activé, puis `pip install NOM` |
| JupyterLab ne s'ouvre pas | Copiez l'URL affichée dans le terminal (avec le token) |
| Port 8888 occupé | `jupyter lab --port 8889` |
| Kaggle : `401 Unauthorized` | Vérifiez l'emplacement de `kaggle.json` (étape 5.2) |
| Kaggle : `403 Forbidden` | Acceptez les conditions d'utilisation du dataset sur kaggle.com |

---

*Cours IA & Cybersécurité · M1 · 2025-2026*
