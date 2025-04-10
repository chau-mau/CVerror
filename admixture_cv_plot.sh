#!/bin/bash

# ========= CONFIG =========
INPUT_PREFIX="data"        # Prefix for .bed/.bim/.fam
K_MIN=2                    # Minimum K
K_MAX=10                   # Maximum K
OUTDIR="admixture_out"     # Output directory for logs and results
PYTHON_SCRIPT="plot_cv.py" # Python script to plot
# ==========================

mkdir -p "$OUTDIR"

echo "Running ADMIXTURE for K=$K_MIN to K=$K_MAX..."

# Run ADMIXTURE for each K and save verbose output
for K in $(seq $K_MIN $K_MAX); do
    echo "Running K=$K..."
    admixture --cv=10 -j4 ${INPUT_PREFIX}.bed $K > "${OUTDIR}/log_K${K}.txt"
done

echo "All ADMIXTURE runs complete. Extracting CV errors..."

# Generate Python script to extract and plot CV errors
cat << EOF > "$PYTHON_SCRIPT"
import re
import matplotlib.pyplot as plt
import os

log_dir = "$OUTDIR"

cv_errors = {}
for fname in os.listdir(log_dir):
    if fname.startswith("log_K") and fname.endswith(".txt"):
        with open(os.path.join(log_dir, fname)) as f:
            text = f.read()
            match = re.search(r"CV error \\(K=(\\d+)\\): ([0-9.]+)", text)
            if match:
                k = int(match.group(1))
                error = float(match.group(2))
                cv_errors[k] = error

# Sort by K
cv_errors = dict(sorted(cv_errors.items()))

# Plot
ks = list(cv_errors.keys())
errors = list(cv_errors.values())

plt.figure(figsize=(8, 5))
plt.plot(ks, errors, marker='o', color='teal', linewidth=2)
plt.title("ADMIXTURE CV Error vs. K")
plt.xlabel("K")
plt.ylabel("CV Error")
plt.grid(True)
plt.xticks(ks)
plt.tight_layout()
plt.savefig(os.path.join(log_dir, "cv_error_plot.png"))
plt.show()
EOF

# Run the Python script
python3 "$PYTHON_SCRIPT"

echo "Plot saved as ${OUTDIR}/cv_error_plot.png"