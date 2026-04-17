#!/bin/bash

module load MultiQC/1.11-foss-2021a
# Function to traverse subdirectories recursively and execute fastqc

starting_directory="."
output_file="multiqc.txt"

traverse_directories() {
    local directory="$1"

    # Loop through the contents of the current directory
    for entry in "$directory"/*; do
        # Check if the entry is a file
        if [[ -f "$entry" ]]; then
	    if [[ $entry =~ :\.html$ ]];then
		    echo "$entry" >> "$starting_directory"/"$output_file"
		    multiqc -o "$directory" "$entry"
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
