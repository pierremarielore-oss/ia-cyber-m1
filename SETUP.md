# Guide d'installation — TP IA & Cybersécurité

Bienvenue ! Ce guide vous permettra d'installer l'environnement Python/Jupyter
et de récupérer les notebooks de TP depuis le dépôt Git du cours.

---

## Étape 1 — Installer Python

### Windows
1. Téléchargez Python 3.11+ sur [python.org/downloads](https://www.python.org/downloads/)
2. **Cochez impérativement** "Add Python to PATH" lors de l'installation
3. Vérifiez dans un terminal (`cmd` ou `PowerShell`) :
   ```
   python --version
   ```

### macOS
```bash
# Via Homebrew (recommandé)
brew install python@3.11

# Ou via le site officiel : https://www.python.org/downloads/
python3 --version
```

### Linux (Debian/Ubuntu)
```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv -y
python3 --version
```

---

## Étape 2 — Créer un environnement virtuel (recommandé)

Un environnement virtuel isole les dépendances du cours de votre Python système.

```bash
# Créez un dossier de travail pour le cours
mkdir ia-cyber && cd ia-cyber

# Créez l'environnement virtuel
python -m venv venv

# Activez-le
# Windows :
venv\Scripts\activate
# macOS / Linux :
source venv/bin/activate

# Votre terminal doit afficher (venv) en début de ligne
```

> **Important** : activez toujours l'environnement virtuel avant de travailler
> sur les TP. Si vous fermez le terminal, réactivez-le.

---

## Étape 3 — Installer Jupyter et les bibliothèques du cours

```bash
pip install --upgrade pip
pip install jupyter numpy pandas matplotlib scikit-learn torch torchvision
```

> L'installation peut prendre 2 à 5 minutes selon votre connexion.

Vérifiez que Jupyter est bien installé :
```bash
jupyter --version
```

---

## Étape 4 — Récupérer les notebooks depuis Git

### Option A — Via Git (recommandé)

Si Git n'est pas installé : [git-scm.com/downloads](https://git-scm.com/downloads)

```bash
# Clonez le dépôt du cours (remplacez l'URL par celle fournie par votre enseignant)
git clone https://github.com/VOTRE-ENSEIGNANT/ia-cyber-m1.git

# Accédez au dossier
cd ia-cyber-m1
```

Pour mettre à jour les notebooks en cours de semestre :
```bash
git pull
```

### Option B — Téléchargement ZIP (sans Git)

1. Rendez-vous sur la page GitHub du cours (URL fournie par l'enseignant)
2. Cliquez sur le bouton vert **"Code"** → **"Download ZIP"**
3. Extrayez le ZIP dans votre dossier de travail

---

## Étape 5 — Lancer Jupyter

```bash
# Depuis le dossier du cours (avec l'environnement virtuel activé)
jupyter notebook
```

Votre navigateur s'ouvre automatiquement sur `http://localhost:8888`.
Naviguez vers le dossier `tp/` pour accéder aux notebooks de TP.

> Si le navigateur ne s'ouvre pas, copiez l'URL affichée dans le terminal
> (elle ressemble à `http://localhost:8888/?token=...`)

---

## Récapitulatif — Commandes du quotidien

```bash
# 1. Aller dans le dossier du cours
cd ia-cyber/ia-cyber-m1

# 2. Activer l'environnement virtuel
source venv/bin/activate        # macOS/Linux
# ou
venv\Scripts\activate           # Windows

# 3. Mettre à jour les notebooks
git pull

# 4. Lancer Jupyter
jupyter notebook
```

---

## Résolution des problèmes fréquents

| Problème | Solution |
|---|---|
| `python` introuvable (Windows) | Relancez l'installateur Python, cochez "Add to PATH" |
| `pip` introuvable | `python -m pip install --upgrade pip` |
| Port 8888 occupé | `jupyter notebook --port 8889` |
| Kernel mort dans Jupyter | Kernel → Restart, vérifiez que le venv est activé |
| `ModuleNotFoundError` | `pip install NOM_DU_MODULE` dans le venv activé |
| Problème SSL sur pip | `pip install --trusted-host pypi.org NOM_DU_MODULE` |

---

## Structure du dépôt Git

```
ia-cyber-m1/
├── SETUP.md              ← ce guide
├── tp/
│   ├── tp1_perceptron/
│   │   └── tp1_perceptron.ipynb
│   ├── tp2_detection/
│   │   └── tp2_detection_anomalies.ipynb
│   └── tp3_adversarial/
│       └── tp3_attaques.ipynb
├── cours/
│   └── slides/           ← diapositives PDF
└── requirements.txt      ← toutes les dépendances du cours
```

Pour installer toutes les dépendances en une seule commande :
```bash
pip install -r requirements.txt
```
