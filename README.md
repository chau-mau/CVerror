# CVerror
Here's a standalone Bash + Python script workflow that:  Runs ADMIXTURE for a range of K values.  Saves the output with verbose logging.  Extracts CV errors from the outputs.  Plots a CV error vs. K plot using Python.  🔧 Requirements ADMIXTURE  Python 3 with matplotlib installed  PLINK .bed/.bim/.fam files ready (e.g. data.bed, data.bim, data.fam)
🚀 Usage
1. Prepare your input
Make sure your input files (data.bed, data.bim, data.fam) are ready.

2. Edit config (optional)
Open the top of admixture_cv_plot.sh and update:

bash
Copy
Edit
INPUT_PREFIX="data"     # Change if your file is not named 'data.bed'
K_MIN=2
K_MAX=10
3. Run the script
bash
Copy
Edit
chmod +x admixture_cv_plot.sh
./admixture_cv_plot.sh
4. View the plot
After the script runs, open the generated plot:

bash
Copy
Edit
xdg-open admixture_out/cv_error_plot.png  # Linux
open admixture_out/cv_error_plot.png      # macOS
📊 Example Output

🧠 Notes
The script uses admixture --cv=10 -j4, meaning 10-fold cross-validation and 4 threads. You can change this in the script.

The script automatically extracts CV error (K=X): ... from ADMIXTURE's verbose output using regex.

🛠️ To-Do
 Add automatic optimal K detection

 Add parallel execution with GNU parallel

 Optional argument parsing with getopts
