#!/usr/bin/env bash
# ============================================================
#  setup_repo.sh
#  Script de mise en place locale et push GitHub
#  Cours IA & Cybersécurité — Master 1
#
#  UTILISATION (depuis le dossier contenant vos notebooks) :
#    chmod +x setup_repo.sh
#    ./setup_repo.sh
# ============================================================

set -e  # arrêt immédiat si une commande échoue

# ── Couleurs pour les messages ────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[✔]${NC} $1"; }
warning() { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✘]${NC} $1"; exit 1; }

echo ""
echo "============================================"
echo "  Setup repo — IA & Cybersécurité M1"
echo "============================================"
echo ""

# ── 1. Vérifications préalables ───────────────────────────────
command -v git  >/dev/null 2>&1 || error "git n'est pas installé."
command -v python3 >/dev/null 2>&1 || error "python3 n'est pas installé."

# ── 2. Dossier racine du cours ────────────────────────────────
REPO_DIR="$HOME/Documents/Cours/IA/Github/ia-cyber-m1"

if [ ! -d "$REPO_DIR" ]; then
    warning "Dossier repo introuvable, création : $REPO_DIR"
    mkdir -p "$REPO_DIR"
fi

cd "$REPO_DIR"
info "Dossier de travail : $REPO_DIR"

# ── 3. Créer l'arborescence des TPs ──────────────────────────
info "Création de l'arborescence des TPs..."

mkdir -p tp/TP_S1
mkdir -p tp/TP_S2
mkdir -p tp/TP0
mkdir -p tp/TP1
mkdir -p tp/TP2
mkdir -p tp/TP4
mkdir -p tp/TP5
mkdir -p tp/TP6

info "Arborescence créée."

# ── 4. Copier les notebooks depuis ~/Downloads (si présents) ──
info "Recherche des notebooks dans ~/Downloads..."

NOTEBOOKS=(
    "TP4_reseau_neurones.ipynb:tp/TP4/"
    "TP5_ia_generative.ipynb:tp/TP5/"
    "TP6_defensive_ai.ipynb:tp/TP6/"
)

for entry in "${NOTEBOOKS[@]}"; do
    fichier="${entry%%:*}"
    dest="${entry##*:}"
    src="$HOME/Downloads/$fichier"
    if [ -f "$src" ]; then
        cp "$src" "$dest"
        info "Copié : $fichier → $dest"
    else
        warning "Non trouvé dans Downloads : $fichier (à copier manuellement dans $dest)"
    fi
done

# ── 5. Copier SETUP.md et requirements.txt ───────────────────
for f in "SETUP.md" "requirements.txt"; do
    src="$HOME/Downloads/$f"
    if [ -f "$src" ]; then
        cp "$src" .
        info "Copié : $f"
    else
        warning "Non trouvé : $f (à copier manuellement à la racine)"
    fi
done

# ── 6. Créer le README si absent ──────────────────────────────
if [ ! -f "README.md" ]; then
    info "Création du README.md..."
    cat > README.md << 'EOF'
# IA & Cybersécurité — Master 1

Dépôt du cours IA & Cybersécurité pour les étudiants de Master 1 en ingénierie aéronautique et spatiale.

## Démarrage rapide

Consultez [SETUP.md](SETUP.md) pour installer l'environnement et lancer JupyterLab.

## Structure

```
ia-cyber-m1/
├── SETUP.md              ← guide d'installation étudiant
├── requirements.txt      ← dépendances Python
└── tp/
    ├── TP_S1/            ← IA symbolique : règles & systèmes experts
    ├── TP_S2/            ← Ontologies & graphes (MITRE ATT&CK)
    ├── TP0/              ← Perceptron débutant (très guidé)
    ├── TP1/              ← Perceptron NumPy + PyTorch
    ├── TP2/              ← UEBA : K-Means & Isolation Forest
    ├── TP4/              ← Réseau multicouches (MLP)
    ├── TP5/              ← IA générative & sécurité LLMs
    └── TP6/              ← IDS par Machine Learning (Defensive AI)
```

## Cours IA & Cybersécurité · M1 · 2025-2026
EOF
    info "README.md créé."
fi

# ── 7. Créer le .gitignore si absent ─────────────────────────
if [ ! -f ".gitignore" ]; then
    info "Création du .gitignore..."
    cat > .gitignore << 'EOF'
# Python
__pycache__/
*.pyc
*.pyo
venv/
.env
*.egg-info/

# Jupyter
.ipynb_checkpoints/
**/.ipynb_checkpoints/

# Données (ne pas versionner les gros fichiers)
tp/*/data/
*.csv
*.pkl
*.h5
*.pt
*.parquet

# Kaggle (ne JAMAIS versionner la clé API)
kaggle.json
.kaggle/

# OS
.DS_Store
Thumbs.db

# Corrections (fichiers prof, hors repo)
*_correction*
*_corrige*
EOF
    info ".gitignore créé."
fi

# ── 8. Initialiser Git si nécessaire ─────────────────────────
if [ ! -d ".git" ]; then
    info "Initialisation du dépôt Git..."
    git init
    git branch -M main
fi

# ── 9. Commit ─────────────────────────────────────────────────
info "Préparation du commit..."
git add .

# Vérifier s'il y a des changements à commiter
if git diff --cached --quiet; then
    warning "Aucun changement à commiter (dépôt déjà à jour)."
else
    git commit -m "feat: ajout TP4 MLP, TP5 LLM sécurité, TP6 IDS défensif + SETUP.md"
    info "Commit créé."
fi

# ── 10. Push GitHub ───────────────────────────────────────────
echo ""
echo "Voulez-vous pousser sur GitHub maintenant ? (o/n)"
read -r reponse

if [[ "$reponse" =~ ^[Oo]$ ]]; then
    # Vérifier si un remote existe déjà
    if git remote get-url origin >/dev/null 2>&1; then
        info "Remote 'origin' existant détecté."
    else
        echo ""
        echo "Entrez l'URL de votre dépôt GitHub :"
        echo "(format : https://github.com/pierremarielore-oss/ia-cyber-m1.git)"
        read -r remote_url
        git remote add origin "$remote_url"
        info "Remote configuré : $remote_url"
    fi

    info "Push en cours..."
    git push -u origin main
    info "Push réussi !"
    echo ""
    echo "  → Dépôt disponible sur GitHub."
    echo "  → Les étudiants peuvent cloner avec :"
    echo "     git clone https://github.com/pierremarielore-oss/ia-cyber-m1.git"
else
    warning "Push annulé. Faites-le manuellement avec : git push -u origin main"
fi

# ── 11. Résumé ────────────────────────────────────────────────
echo ""
echo "============================================"
echo "  Résumé de l'arborescence finale"
echo "============================================"
find . -not -path './.git/*' -not -path './venv/*' | sort | head -40
echo ""
info "Setup terminé !"
echo ""
