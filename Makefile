# Makefile for text analysis pipeline
# Define phony targets (targets that don't create files with these names)
.PHONY: all clean

# Default target that builds everything
all: report/count_report.html

# Data processing: create .dat files from input text files
results/isles.dat: data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat: data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat: data/last.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat: data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat

# Create plots from .dat files
results/figure/isles.png: results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png

results/figure/abyss.png: results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png

results/figure/last.png: results/last.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png

results/figure/sierra.png: results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png

# Generate the final report
report/count_report.html: report/count_report.qmd results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	quarto render report/count_report.qmd

# Clean target to remove generated files
clean:
	rm -f results/*.dat
	rm -f results/figure/*.png
	rm -f report/count_report.html
