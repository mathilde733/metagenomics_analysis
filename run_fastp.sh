#!/bin/bash

module load fastp/0.23.4-GCC-10.3.0
# Function to traverse subdirectories recursively and execute fastp

starting_directory="."
output_file="fastp.txt"

traverse_directories() {
    local directory="$1"
                
    # Loop through the contents of the current directory
    for entry in "$directory"/*; do
        # Check if the entry is a file
        if [[ -f "$entry" ]]; then
	    if [[ $entry =~ _1\.fq\.gz$ ]];then
            
     # Définir les noms de fichiers
            read_1="${entry%_1.fq.gz}_1.fq.gz"
            read_2="${entry%_1.fq.gz}_2.fq.gz" # Supprime l'extension .gz et ajoute _2.fastq.gz pour le fichier read_2
            clean_read_1="${entry%_1.fq.gz}_clean_1.fq.gz" # Fichier de sortie pour read_1
            clean_read_2="${entry%_1.fq.gz}_clean_2.fq.gz" # Fichier de sortie pour read_2
            report="${entry%_1.fq.gz}"
		    echo "$entry" >> "$starting_directory"/"$output_file"
		    fastp -w 12 -g -M 20 -l 100 -i "$read_1" -I "$read_2" -o "$clean_read_1" -O "$clean_read_2" -R "$report" -j "${report}.fastp.json" -h "${report}.html"
	    fi
        elif [[ -d "$entry" ]]; then
            # If the entry is a directory, recursively call the function to process it
            traverse_directories "$entry"
	fi
    done

    # Output the filenames in the current directory
    echo "Files in $directory:"
}

# Call the function to begin the traversal
traverse_directories "$starting_directory"
